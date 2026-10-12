#!/usr/bin/env bash
# Generates the Play upload keystore for Tea and prints the env exports
# that android/app/build.gradle reads. Run once; back the .jks file up somewhere
# safe — losing it means you cannot update the app on Play.
set -euo pipefail

OUT_DIR="${1:-$HOME/.tea}"
KS="$OUT_DIR/tea-upload.jks"
ALIAS="tea-upload"

mkdir -p "$OUT_DIR"
if [[ -f "$KS" ]]; then
  echo "Keystore already exists at $KS — not overwriting."
  exit 0
fi

read -r -s -p "Keystore/key password (min 6 chars): " PASS; echo
keytool -genkeypair -v \
  -keystore "$KS" -alias "$ALIAS" \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -storepass "$PASS" -keypass "$PASS" \
  -dname "CN=Tea, OU=Mobile, O=Kraftisium, L=Mumbai, ST=MH, C=IN"

cat <<EOF

Created $KS

Add to ~/.gradle/gradle.properties (or export as env vars before ./gradlew):
TEA_UPLOAD_STORE_FILE=$KS
TEA_UPLOAD_STORE_PASSWORD=<password>
TEA_UPLOAD_KEY_ALIAS=$ALIAS
TEA_UPLOAD_KEY_PASSWORD=<password>

Then: bun run android:bundle   # -> android/app/build/outputs/bundle/release/app-release.aab
EOF
