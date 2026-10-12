#!/usr/bin/env bash
# Build the Tea Dating Advice BFF image locally, ship it to the VPS, and roll it out.
#
#   apps/tea/scripts/vps-deploy.sh                 # build + deploy :latest
#   apps/tea/scripts/vps-deploy.sh --tag v0.2.0    # explicit tag
#   apps/tea/scripts/vps-deploy.sh --no-build      # redeploy the tag that already exists locally
#
# Requirements: docker (local), ssh access as $VPS_USER@$VPS_HOST, docker compose on the VPS.
# The VPS never builds (4 GB RAM); it only loads the tarball and restarts the bff service.
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VPS_HOST="${VPS_HOST:-185.139.7.99}"
VPS_USER="${VPS_USER:-prod}"
VPS_DIR="${VPS_DIR:-/home/${VPS_USER}/tea}"
IMAGE="tea-bff"
TAG="latest"
BUILD=1

while [[ $# -gt 0 ]]; do
  case "$1" in
    --tag) TAG="$2"; shift 2 ;;
    --no-build) BUILD=0; shift ;;
    -h|--help) sed -n '2,12p' "$0"; exit 0 ;;
    *) echo "unknown arg $1"; exit 1 ;;
  esac
done

SSH="ssh -o StrictHostKeyChecking=accept-new ${VPS_USER}@${VPS_HOST}"
TARBALL="/tmp/${IMAGE}-${TAG}.tar.gz"

if [[ $BUILD -eq 1 ]]; then
  echo "==> Building ${IMAGE}:${TAG} (linux/amd64)"
  docker buildx build --platform linux/amd64 -t "${IMAGE}:${TAG}" "${HERE}/bff" --load
fi

echo "==> Exporting image"
docker save "${IMAGE}:${TAG}" | gzip -1 > "${TARBALL}"
du -h "${TARBALL}"

echo "==> Preparing ${VPS_USER}@${VPS_HOST}:${VPS_DIR}"
$SSH "mkdir -p '${VPS_DIR}/bff'"
scp -q "${HERE}/compose.prod.yml" "${VPS_USER}@${VPS_HOST}:${VPS_DIR}/compose.prod.yml"
scp -q "${HERE}/deploy/nginx.tea.conf" "${VPS_USER}@${VPS_HOST}:${VPS_DIR}/nginx.tea.conf"
if [[ -f "${HERE}/bff/.env.prod" ]]; then
  scp -q "${HERE}/bff/.env.prod" "${VPS_USER}@${VPS_HOST}:${VPS_DIR}/bff/.env.prod"
  echo "==> Synced bff/.env.prod to ${VPS_DIR}/bff/.env.prod"
fi

echo "==> Uploading image"
scp -q "${TARBALL}" "${VPS_USER}@${VPS_HOST}:/tmp/"

echo "==> Loading + rolling out"
$SSH bash -s <<EOF
set -euo pipefail
cd '${VPS_DIR}'
gunzip -c '/tmp/$(basename "${TARBALL}")' | docker load
rm -f '/tmp/$(basename "${TARBALL}")'
chmod 600 bff/.env.prod
export BFF_IMAGE='${IMAGE}:${TAG}'
docker compose -f compose.prod.yml --env-file bff/.env.prod up -d
echo "--- waiting for health"
for i in \$(seq 1 20); do
  if curl -fsS http://127.0.0.1:8014/api/v1/health >/dev/null 2>&1; then echo "healthy"; break; fi
  sleep 3
  if [[ \$i -eq 20 ]]; then echo "BFF did not become healthy"; docker compose -f compose.prod.yml logs --tail=80 bff; exit 1; fi
done
docker compose -f compose.prod.yml --env-file bff/.env.prod ps
EOF

rm -f "${TARBALL}"
echo "==> Done. nginx: copy ${VPS_DIR}/nginx.tea.conf to /etc/nginx/sites-enabled/ once and reload."
