import Svg, { Circle, Ellipse, Path, Rect, G } from 'react-native-svg';

import { colors } from '@/constants/theme';

type IconProps = { size?: number; color?: string; active?: boolean };

export function HomeIcon({ size = 24, color = colors.plum, active }: IconProps) {
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24" fill="none">
      <Path
        d="M12 3L4 10V20C4 20.2652 4.12036 20.5196 4.33474 20.7071C4.54911 20.8946 4.83983 21 5.14286 21H8.57143C8.87446 21 9.16518 20.8946 9.37955 20.7071C9.59393 20.5196 9.71429 20.2652 9.71429 20V16C9.71429 15.7348 9.83464 15.4804 10.049 15.2929C10.2634 15.1054 10.5541 15 10.8571 15H13.1429C13.446 15 13.7367 15.1054 13.951 15.2929C14.1654 15.4804 14.2857 15.7348 14.2857 16V20C14.2857 20.2652 14.4061 20.5196 14.6204 20.7071C14.8348 20.8946 15.1255 21 15.4286 21H18.8571C19.1602 21 19.4509 20.8946 19.6653 20.7071C19.8796 20.5196 20 20.2652 20 20V10L12 3Z"
        fill={active ? color : 'none'}
        stroke={color}
        strokeWidth={2}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </Svg>
  );
}

export function DiscoverIcon({ size = 24, color = colors.plum }: IconProps) {
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24" fill="none">
      <Circle cx="12" cy="12" r="9" stroke={color} strokeWidth={2} />
      <Path
        d="M8 16L10 10L16 8L14 14L8 16Z"
        stroke={color}
        strokeWidth={2}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </Svg>
  );
}

export function CreateIcon({ size = 24, color = colors.plum }: IconProps) {
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24" fill="none">
      <Path d="M12 5V19" stroke={color} strokeWidth={2} strokeLinecap="round" />
      <Path d="M5 12H19" stroke={color} strokeWidth={2} strokeLinecap="round" />
    </Svg>
  );
}

export function MatchesIcon({ size = 24, color = colors.plum }: IconProps) {
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24" fill="none">
      <Path
        d="M9 11C10.6569 11 12 9.65685 12 8C12 6.34315 10.6569 5 9 5C7.34315 5 6 6.34315 6 8C6 9.65685 7.34315 11 9 11Z"
        stroke={color}
        strokeWidth={2}
      />
      <Path
        d="M15 11C16.6569 11 18 9.65685 18 8C18 6.34315 16.6569 5 15 5"
        stroke={color}
        strokeWidth={2}
        strokeLinecap="round"
      />
      <Path
        d="M3 19V18C3 15.7909 4.79086 14 7 14H11C13.2091 14 15 15.7909 15 18V19"
        stroke={color}
        strokeWidth={2}
        strokeLinecap="round"
      />
      <Path
        d="M17 14H18C20.2091 14 22 15.7909 22 18V19"
        stroke={color}
        strokeWidth={2}
        strokeLinecap="round"
      />
    </Svg>
  );
}

export function MessagesIcon({ size = 24, color = colors.plum }: IconProps) {
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24" fill="none">
      <Path
        d="M21 11.5C21.0034 12.8199 20.6951 14.1219 20.1 15.3C19.3944 16.7118 18.3098 17.8992 16.9674 18.7293C15.6251 19.5594 14.0782 19.9994 12.5 20C11.1801 20.0034 9.87812 19.6951 8.7 19.1L3 21L4.9 15.3C4.30493 14.1219 3.99656 12.8199 4 11.5C4.00074 9.92179 4.44077 8.37488 5.27096 7.03258C6.10114 5.69028 7.28885 4.60556 8.7 3.90003C9.87812 3.30493 11.1801 2.99656 12.5 3H13C15.0843 3.11502 17.053 3.99479 18.5291 5.47089C20.0052 6.94699 20.885 8.91568 21 11V11.5Z"
        stroke={color}
        strokeWidth={2}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </Svg>
  );
}

export function BellIcon({ size = 24, color = colors.plum }: IconProps) {
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24" fill="none">
      <Path
        d="M10 5C10 4.46957 10.2107 3.96086 10.5858 3.58579C10.9609 3.21071 11.4696 3 12 3C12.5304 3 13.0391 3.21071 13.4142 3.58579C13.7893 3.96086 14 4.46957 14 5C15.1484 5.54303 16.1274 6.38834 16.8321 7.4453C17.5367 8.50225 17.9404 9.73107 18 11V14C18.0753 14.6217 18.2954 15.2171 18.6428 15.7381C18.9902 16.2592 19.4551 16.6914 20 17H4C4.54493 16.6914 5.00981 16.2592 5.35723 15.7381C5.70465 15.2171 5.92475 14.6217 6 14V11C6.05956 9.73107 6.4633 8.50225 7.16795 7.4453C7.8726 6.38834 8.85159 5.54303 10 5"
        stroke={color}
        strokeWidth={1.5}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
      <Path
        d="M9 17V18C9 18.7956 9.31607 19.5587 9.87868 20.1213C10.4413 20.6839 11.2044 21 12 21C12.7956 21 13.5587 20.6839 14.1213 20.1213C14.6839 19.5587 15 18.7956 15 18V17"
        stroke={color}
        strokeWidth={1.5}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
      <Circle cx="18" cy="6" r="3" fill={colors.pink} stroke="white" strokeWidth={1.5} />
    </Svg>
  );
}

export function PhoneLoginIcon({ size = 40 }: { size?: number }) {
  return (
    <Svg width={size} height={size} viewBox="0 0 40 40" fill="none">
      <Circle cx="20" cy="20" r="20" fill="white" />
      <Path
        d="M13 12H17L19 17L16.5 18.5C17.571 20.6715 19.3285 22.429 21.5 23.5L23 21L28 23V27C28 27.5304 27.7893 28.0391 27.4142 28.4142C27.0391 28.7893 26.5304 29 26 29C22.0993 28.763 18.4202 27.1065 15.6568 24.3432C12.8935 21.5798 11.237 17.9007 11 14C11 13.4696 11.2107 12.9609 11.5858 12.5858C11.9609 12.2107 12.4696 12 13 12"
        stroke={colors.plum}
        strokeWidth={2}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
      <Path
        d="M23 15C23.5304 15 24.0391 15.2107 24.4142 15.5858C24.7893 15.9609 25 16.4696 25 17"
        stroke={colors.plum}
        strokeWidth={2}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
      <Path
        d="M23 11C24.5913 11 26.1174 11.6321 27.2426 12.7574C28.3679 13.8826 29 15.4087 29 17"
        stroke={colors.plum}
        strokeWidth={2}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </Svg>
  );
}

export function EmailLoginIcon({ size = 40 }: { size?: number }) {
  return (
    <Svg width={size} height={size} viewBox="0 0 40 40" fill="none">
      <Circle cx="20" cy="20" r="20" fill="white" />
      <Path
        d="M12 14H28C29.1 14 30 14.9 30 16V24C30 25.1 29.1 26 28 26H12C10.9 26 10 25.1 10 24V16C10 14.9 10.9 14 12 14Z"
        stroke={colors.plum}
        strokeWidth={2}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
      <Path
        d="M11 15L20 21L29 15"
        stroke={colors.plum}
        strokeWidth={2}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </Svg>
  );
}

export function GoogleLoginGlyph({ size = 40 }: { size?: number }) {
  return (
    <Svg width={size} height={size} viewBox="0 0 40 40" fill="none">
      <Circle cx="20" cy="20" r="20" fill="white" />
      <Path
        d="M29.8055 18.0415H29V18H20V22H25.6515C24.827 24.3285 22.6115 26 20 26C16.6865 26 14 23.3135 14 20C14 16.6865 16.6865 14 20 14C21.5295 14 22.921 14.577 23.9805 15.5195L26.809 12.691C25.023 11.0265 22.634 10 20 10C14.4775 10 10 14.4775 10 20C10 25.5225 14.4775 30 20 30C25.5225 30 30 25.5225 30 20C30 19.3295 29.931 18.675 29.8055 18.0415Z"
        fill="#FFC107"
      />
      <Path
        d="M11.1528 15.3455L14.4383 17.755C15.3273 15.554 17.4803 14 19.9998 14C21.5293 14 22.9208 14.577 23.9803 15.5195L26.8088 12.691C25.0228 11.0265 22.6338 10 19.9998 10C16.1588 10 12.8278 12.1685 11.1528 15.3455Z"
        fill="#FF3D00"
      />
      <Path
        d="M20.0002 30.0001C22.5832 30.0001 24.9302 29.0116 26.7047 27.4041L23.6097 24.7851C22.5719 25.5743 21.3039 26.0011 20.0002 26.0001C17.3992 26.0001 15.1907 24.3416 14.3587 22.0271L11.0977 24.5396C12.7527 27.7781 16.1137 30.0001 20.0002 30.0001Z"
        fill="#4CAF50"
      />
      <Path
        d="M29.8055 18.0415H29V18H20V22H25.6515C25.2571 23.1082 24.5467 24.0766 23.608 24.7855L23.6095 24.7845L26.7045 27.4035C26.4855 27.6025 30 25 30 20C30 19.3295 29.931 18.675 29.8055 18.0415Z"
        fill="#1976D2"
      />
    </Svg>
  );
}

export function TeaLogo({
  size = 32,
  color = '#020202',
}: {
  size?: number;
  color?: string;
}) {
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24" fill="none">
      <Path
        d="M17 8H19C19.7956 8 20.5587 8.31607 21.1213 8.87868C21.6839 9.44129 22 10.2044 22 11C22 11.7956 21.6839 12.5587 21.1213 13.1213C20.5587 13.6839 19.7956 14 19 14H17M3 8H17V13C17 14.5913 16.3679 16.1174 15.2426 17.2426C14.1174 18.3679 12.5913 19 11 19H9C7.4087 19 5.88258 18.3679 4.75736 17.2426C3.63214 16.1174 3 14.5913 3 13V8ZM2 21H18"
        stroke={color}
        strokeWidth={2.5}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </Svg>
  );
}

export const PaloraLogo = TeaLogo;

export function WelcomeHeroGraphic({ width = 280, height = 280 }: { width?: number; height?: number }) {
  return (
    <Svg width={width} height={height} viewBox="0 0 291 285" fill="none">
      <Path
        opacity={0.16}
        d="M145.5 10C215 10 271 66 271 142.5C271 219 215 275 145.5 275C76 275 20 219 20 142.5C20 66 76 10 145.5 10Z"
        stroke={colors.pink}
        strokeWidth={2}
        strokeDasharray="8 12"
      />
      <Ellipse cx="145.5" cy="142" rx="88" ry="86" fill={colors.pink} opacity={0.12} />
      <Circle cx="145.5" cy="142" r="58" fill="white" />
      <G transform="translate(85.5, 87.5) scale(1.26)">
        <Path
          d="M32.8949 25.4469C31.6033 25.1575 30.9936 23.9382 31.5413 22.7292L39.5599 5.1522C40.1076 3.9432 42.7943 4.29453 43.6003 4.88353C44.4063 5.48287 45.3259 7.0122 45.6463 8.30386L50.3479 27.2035C50.6683 28.4849 49.8726 29.2909 48.5809 29.0015L32.8949 25.4469Z"
          fill="#F7374E"
        />
        <Path
          d="M31.3552 43.789C31.7169 45.0704 31.6756 47.137 31.2622 48.3977L26.1679 64.094C25.7546 65.3444 24.6592 65.613 23.7189 64.6727L9.54156 50.4954C8.61156 49.5654 8.61156 48.036 9.54156 47.0957L14.8012 41.8464C15.7312 40.906 16.4959 40.1414 16.4959 40.1414C16.4959 40.1414 17.2709 39.3767 18.2009 38.4364L25.6099 31.0274C26.5502 30.0974 27.6042 30.3764 27.9556 31.6474L31.3552 43.789Z"
          fill="#F7374E"
        />
        <Path
          d="M9.52091 42.3523C7.33025 44.543 -1.22576 31.8123 0.148573 25.385C1.52291 18.9576 4.27158 14.6383 6.26591 15.7853C8.24991 16.9323 10.6989 22.4813 11.7012 28.113C12.7036 33.755 11.7219 40.1616 9.52091 42.3523V42.3523Z"
          fill="#E80356"
        />
        <Path
          d="M84.9335 24.2179C85.7912 21.4382 88.1782 20.8492 90.2449 22.9056L91.9292 24.6002C93.9856 26.6566 95.2359 30.6866 94.7089 33.5386L91.2679 42.2186C89.7902 44.7296 86.6799 45.3289 84.3652 43.5619L84.1896 43.4379C81.8749 41.6709 80.6762 37.9509 81.5442 35.1713L84.9335 24.2179Z"
          fill="#E80356"
        />
        <Path
          d="M46.8759 61.9752C47.7956 62.9259 48.3639 64.7652 48.1365 66.0672L45.0882 83.2516C44.8505 84.5536 43.8999 84.8532 42.9596 83.9232L29.7949 70.7482C28.8545 69.8079 28.4309 68.0202 28.8339 66.7596L33.7629 51.6006C34.1762 50.3399 35.2612 50.0919 36.1912 51.0322L46.8759 61.9752Z"
          fill="#A3195B"
        />
        <Path
          d="M84.3032 47.7568C85.3572 48.5524 85.4502 49.9784 84.5202 50.9084L73.2569 62.1718C72.3269 63.1018 70.4875 63.7424 69.1649 63.5978L56.9405 62.2028C55.6282 62.0478 55.4009 61.2418 56.4239 60.4151L76.1812 44.5018C77.2042 43.6751 78.9092 43.6441 79.9632 44.4501L84.3032 47.7568Z"
          fill="#F7374E"
        />
        <Path
          d="M49.2732 8.91384C48.9529 7.62217 49.6245 6.03083 50.7612 5.35917L64.5872 0.058169C65.8892 -0.189831 67.7182 0.378504 68.6482 1.31884L76.9355 9.60617C77.8759 10.5465 77.7622 11.9415 76.6875 12.7165L56.1965 27.5448C55.1322 28.3198 53.9955 27.9065 53.6752 26.6148L49.2732 8.91384Z"
          fill="#D60B52"
        />
        <Path
          d="M73.8252 1.73212C72.8849 0.79179 73.1535 0.368122 74.4039 0.781455C74.4039 0.781455 83.0632 3.61279 87.3722 7.92179C91.6812 12.2308 94.5125 20.8798 94.5125 20.8798C94.9259 22.1405 94.5022 22.3988 93.5619 21.4688L73.8252 1.73212Z"
          fill="#A3195B"
        />
        <Path
          d="M78.5475 33.4457C78.1548 34.7167 77.4418 34.7374 76.9665 33.5077L72.7298 22.6164C72.2545 21.3764 72.7298 19.7334 73.8045 18.9584L79.1055 15.1248C80.1698 14.3498 81.6681 14.3394 82.4328 15.0937C83.1871 15.8584 83.4868 17.5117 83.0942 18.7724L78.5475 33.4457Z"
          fill="#A3195B"
        />
        <Path
          d="M66.1269 66.6365C67.4392 66.7915 67.7492 67.6802 66.8192 68.6102L49.4179 86.0115C48.4775 86.9519 47.8989 86.6522 48.1365 85.3502L51.3192 67.3599C51.5569 66.0579 52.8175 65.1175 54.1299 65.2725L66.1269 66.6365Z"
          fill="#D60B52"
        />
        <Path
          d="M5.76985 11.6115C5.07751 11.2188 4.92251 10.3921 5.42884 9.77215C5.42884 9.77215 6.16252 8.86281 7.10285 7.92248C14.8632 0.162143 34.3415 0.89581 34.3415 0.89581C35.1372 0.92681 35.2198 1.27814 34.5275 1.67081L12.6622 14.1535C11.9698 14.5461 10.8435 14.5358 10.1512 14.1432L5.76985 11.6115Z"
          fill="#A3195B"
        />
        <Path
          d="M13.6852 20.0428C13.4579 18.7408 14.2019 17.1391 15.3489 16.4881L33.9902 5.84479C35.1476 5.19379 35.6332 5.63813 35.0855 6.84713L27.7489 22.9361C27.2012 24.1451 25.9819 25.8915 25.0519 26.8318L18.1182 33.7551C17.1882 34.6955 16.2375 34.3855 15.9999 33.0835L13.6852 20.0428Z"
          fill="#D60B52"
        />
        <Path
          d="M67.0878 23.8246C68.1625 23.0496 69.4335 23.4216 69.9088 24.6513L75.1272 38.0743C75.6128 39.3039 75.1582 40.9986 74.1352 41.8253L54.2745 57.8316C53.2412 58.6583 52.4972 58.2553 52.6212 56.9429L54.6052 35.0879C54.7292 33.7756 55.7005 32.0603 56.7752 31.2853L67.0878 23.8246Z"
          fill="#A3195B"
        />
        <Path
          d="M31.1899 30.6858C30.8282 29.4148 31.5929 28.6088 32.8846 28.8982L49.0666 32.5665C50.3582 32.8558 51.3089 34.1682 51.1952 35.4908L49.2319 56.9532C49.1182 58.2758 48.2606 58.5755 47.3409 57.6352L36.9559 47.0022C36.0259 46.0515 34.9822 44.2328 34.6206 42.9618L31.1899 30.6858Z"
          fill="#E80356"
        />
      </G>
    </Svg>
  );
}

export function BackIcon({ size = 24, color = colors.ink }: IconProps) {
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24" fill="none">
      <Path
        d="M15 6L9 12L15 18"
        stroke={color}
        strokeWidth={2}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </Svg>
  );
}

export function ChevronRightIcon({ size = 20, color = colors.muted }: IconProps) {
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24" fill="none">
      <Path
        d="M9 18L15 12L9 6"
        stroke={color}
        strokeWidth={2}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </Svg>
  );
}

export function HeartIcon({
  size = 24,
  color = 'white',
  filled,
  active,
}: IconProps & { filled?: boolean }) {
  const solid = filled || active;
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24" fill="none">
      <Path
        d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"
        fill={solid ? color : 'none'}
        stroke={color}
        strokeWidth={2}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </Svg>
  );
}

export function CloseIcon({ size = 24, color = colors.plum }: IconProps) {
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24" fill="none">
      <Path d="M6 6L18 18M6 18L18 6" stroke={color} strokeWidth={2} strokeLinecap="round" />
    </Svg>
  );
}

export function StarIcon({ size = 24, color = 'white' }: IconProps) {
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24" fill="none">
      <Path
        d="M12 2L14.9 8.6L22 9.3L16.5 14.1L18.2 21.2L12 17.8L5.8 21.2L7.5 14.1L2 9.3L9.1 8.6L12 2Z"
        fill={color}
      />
    </Svg>
  );
}

export function FilterIcon({ size = 24, color = colors.plum }: IconProps) {
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24" fill="none">
      <Path
        d="M4 6H14M10 12H20M6 18H16"
        stroke={color}
        strokeWidth={2}
        strokeLinecap="round"
      />
      <Circle cx="17" cy="6" r="2" stroke={color} strokeWidth={2} />
      <Circle cx="7" cy="12" r="2" stroke={color} strokeWidth={2} />
      <Circle cx="19" cy="18" r="2" stroke={color} strokeWidth={2} />
    </Svg>
  );
}

export function SettingsIcon({ size = 24, color = colors.plum }: IconProps) {
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24" fill="none">
      <Circle cx="12" cy="12" r="3" stroke={color} strokeWidth={2} />
      <Path
        d="M19.4 15A1.65 1.65 0 0021 13.35V10.65A1.65 1.65 0 0019.4 9L18.8 8.8A7.9 7.9 0 0018 7.4L18.3 6.8A1.65 1.65 0 0017.9 4.9L16 3.8A1.65 1.65 0 0014.1 4.2L13.7 4.7A8 8 0 0010.3 4.7L9.9 4.2A1.65 1.65 0 008 3.8L6.1 4.9A1.65 1.65 0 005.7 6.8L6 7.4A7.9 7.9 0 005.2 8.8L4.6 9A1.65 1.65 0 003 10.65V13.35A1.65 1.65 0 004.6 15L5.2 15.2A7.9 7.9 0 006 16.6L5.7 17.2A1.65 1.65 0 006.1 19.1L8 20.2A1.65 1.65 0 009.9 19.8L10.3 19.3A8 8 0 0013.7 19.3L14.1 19.8A1.65 1.65 0 0016 20.2L17.9 19.1A1.65 1.65 0 0018.3 17.2L18 16.6A7.9 7.9 0 0018.8 15.2L19.4 15Z"
        stroke={color}
        strokeWidth={1.6}
        strokeLinejoin="round"
      />
    </Svg>
  );
}

export function CameraIcon({ size = 24, color = colors.plum }: IconProps) {
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24" fill="none">
      <Path
        d="M4 8C4 6.9 4.9 6 6 6H8L9.5 4H14.5L16 6H18C19.1 6 20 6.9 20 8V17C20 18.1 19.1 19 18 19H6C4.9 19 4 18.1 4 17V8Z"
        stroke={color}
        strokeWidth={2}
        strokeLinejoin="round"
      />
      <Circle cx="12" cy="12.5" r="3.5" stroke={color} strokeWidth={2} />
    </Svg>
  );
}

export function PinIcon({ size = 24, color = colors.plum }: IconProps) {
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24" fill="none">
      <Path d="M12 21C12 21 5 14.5 5 9.5C5 5.9 8.1 3 12 3C15.9 3 19 5.9 19 9.5C19 14.5 12 21 12 21Z" stroke={color} strokeWidth={2} />
      <Circle cx="12" cy="9.5" r="2.5" stroke={color} strokeWidth={2} />
    </Svg>
  );
}

export function SearchIcon({ size = 24, color = colors.plum }: IconProps) {
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24" fill="none">
      <Circle cx="11" cy="11" r="7" stroke={color} strokeWidth={2} />
      <Path d="M20 20L16.5 16.5" stroke={color} strokeWidth={2} strokeLinecap="round" />
    </Svg>
  );
}

export function ChevronUpIcon({ size = 20, color = '#fff' }: IconProps) {
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24" fill="none">
      <Path d="M18 15L12 9L6 15" stroke={color} strokeWidth={2.5} strokeLinecap="round" strokeLinejoin="round" />
    </Svg>
  );
}

export function ChevronDownIcon({ size = 20, color = colors.ink }: IconProps) {
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24" fill="none">
      <Path d="M6 9L12 15L18 9" stroke={color} strokeWidth={2.5} strokeLinecap="round" strokeLinejoin="round" />
    </Svg>
  );
}

export function MessagesWatermark({ size = 180, opacity = 0.2 }: { size?: number; opacity?: number }) {
  return (
    <Svg width={size} height={size} viewBox="0 0 180 180" fill="none">
      <G opacity={opacity}>
        <Path
          d="M161.636 144.501L160.745 143.82C172.606 128.246 178.878 109.642 178.878 90.0105C178.878 59.598 163.576 31.6185 137.944 15.1643L138.553 14.2205C164.51 30.8739 180 59.21 180 90.0105C180 109.883 173.644 128.729 161.636 144.501Z"
          fill="white"
        />
        <Path
          d="M90.0052 180C40.3776 180 0 139.625 0 90C0 40.3752 40.3776 0 90.0052 0V1.12211C40.9963 1.12211 1.13267 40.9939 1.13267 89.9895C1.13267 138.996 41.0068 178.857 90.0052 178.857C104.814 178.857 119.476 175.144 132.396 168.118L132.931 169.104C119.843 176.246 104.992 180 90.0052 180Z"
          fill="white"
        />
        <Path
          d="M47.4148 159.278C23.1673 144.344 8.69434 118.441 8.69434 90H10.9492C10.9492 117.654 25.0236 142.834 48.5999 157.358L47.4148 159.278Z"
          fill="white"
        />
        <Path
          d="M90.0057 171.317C81.0912 171.317 72.334 169.88 63.9648 167.059L64.6885 164.93C72.8269 167.678 81.3429 169.072 90.0162 169.072C130.74 169.072 164.563 138.566 168.663 98.1064L170.908 98.3372C166.671 139.929 131.894 171.317 90.0057 171.317Z"
          fill="white"
        />
        <Path
          d="M168.055 77.3737C165.108 59.0318 155.69 42.221 141.521 30.0455C127.205 17.7337 108.904 10.9591 90.0055 10.9591C74.7459 10.9591 59.9373 15.3112 47.1738 23.5541C32.3023 33.1602 20.9546 47.6323 15.2179 64.3068L13.0889 63.5727C18.9829 46.4263 30.6557 31.5452 45.9468 21.6664C59.0773 13.1928 74.3054 8.71484 89.995 8.71484C109.439 8.71484 128.254 15.6887 142.979 28.3466C157.546 40.8682 167.237 58.1614 170.268 77.0276L168.055 77.3737Z"
          fill="white"
        />
        <Path
          d="M90.0054 148.728C57.6195 148.728 31.2744 122.384 31.2744 90.0001C31.2744 76.8912 35.5009 64.4955 43.4821 54.1553L45.265 55.5291C37.588 65.4813 33.5293 77.3946 33.5293 90.0001C33.5293 121.136 58.8675 146.473 90.0054 146.473C95.5324 146.473 100.996 145.676 106.23 144.103L106.88 146.263C101.426 147.91 95.7422 148.728 90.0054 148.728Z"
          fill="white"
        />
        <Path
          d="M129.67 133.312L128.149 131.655C139.801 120.979 146.482 105.804 146.482 90.0106C146.482 78.8943 143.252 68.1345 137.148 58.8954L139.025 57.658C145.381 67.2641 148.737 78.4538 148.737 90.021C148.726 106.433 141.783 122.216 129.67 133.312Z"
          fill="white"
        />
        <Path
          d="M125.139 45.7866C115.06 37.764 102.905 33.5272 90.0049 33.5272C78.6887 33.5272 67.771 36.8621 58.4265 43.1753L57.168 41.3086C66.8796 34.7437 78.2377 31.283 90.0049 31.283C103.429 31.283 116.067 35.6875 126.544 44.0352L125.139 45.7866Z"
          fill="white"
        />
        <Path
          d="M90.0056 138.639C82.0979 138.639 74.2426 136.699 67.2998 133.028L67.8242 132.032C74.6097 135.619 82.2762 137.517 89.9951 137.517C111.317 137.517 130.152 123.181 135.805 102.647L136.886 102.952C131.117 123.968 111.83 138.639 90.0056 138.639Z"
          fill="white"
        />
        <Path
          d="M55.617 124.408C46.4298 115.221 41.3643 103.004 41.3643 90.0104C41.3643 63.1949 63.1786 41.3713 90.0061 41.3713C116.823 41.3713 138.648 63.1949 138.648 90.0104H137.526C137.526 63.8137 116.215 42.5039 90.0166 42.5039C63.8184 42.5039 42.5074 63.8137 42.5074 90.0104C42.5074 102.7 47.4471 114.634 56.435 123.611L55.617 124.408Z"
          fill="white"
        />
        <Path
          d="M90.005 120.255C73.3191 120.255 59.748 106.685 59.748 90.0001C59.748 73.3151 73.3191 59.7449 90.005 59.7449V61.9996C74.5671 61.9996 62.0029 74.5631 62.0029 90.0001C62.0029 105.437 74.5671 118.001 90.005 118.001C105.443 118.001 118.007 105.437 118.007 90.0001H120.262C120.251 106.685 106.68 120.255 90.005 120.255Z"
          fill="white"
        />
        <Path
          d="M90.0061 105.038C81.7104 105.038 74.9668 98.2951 74.9668 89.9999H76.089C76.089 97.6659 82.3291 103.906 89.9956 103.906C97.6621 103.906 103.902 97.6659 103.902 89.9999C103.902 82.3338 97.6621 76.094 89.9956 76.094C85.7376 76.094 81.7733 78.0027 79.1094 81.3375L78.2284 80.6349C81.1021 77.0274 85.3915 74.9614 89.9956 74.9614C98.2914 74.9614 105.035 81.7046 105.035 89.9999C105.035 98.2951 98.2914 105.038 90.0061 105.038Z"
          fill="white"
        />
      </G>
    </Svg>
  );
}

export function MatchHeartIcon({ size = 32, color = '#FFFFFF' }: { size?: number; color?: string }) {
  return (
    <Svg width={size} height={size} viewBox="0 0 32 32" fill="none">
      <Path
        fillRule="evenodd"
        clipRule="evenodd"
        d="M5.07549 8.27513C6.27567 7.07532 7.90324 6.4013 9.60029 6.4013C11.2973 6.4013 12.9249 7.07532 14.1251 8.27513L16.0003 10.1487L17.8755 8.27513C18.4659 7.66387 19.1721 7.1763 19.9529 6.84088C20.7337 6.50547 21.5735 6.32892 22.4233 6.32153C23.2731 6.31415 24.1159 6.47608 24.9024 6.79788C25.6889 7.11967 26.4035 7.59489 27.0044 8.19581C27.6053 8.79672 28.0806 9.51129 28.4024 10.2978C28.7242 11.0844 28.8861 11.9271 28.8787 12.7769C28.8713 13.6267 28.6948 14.4665 28.3593 15.2473C28.0239 16.0281 27.5364 16.7344 26.9251 17.3247L16.0003 28.2511L5.07549 17.3247C3.87568 16.1246 3.20166 14.497 3.20166 12.7999C3.20166 11.1029 3.87568 9.47531 5.07549 8.27513Z"
        fill={color}
      />
    </Svg>
  );
}

export function GoogleIcon({ size = 20 }: { size?: number } = {}) {
  return (
    <Svg width={size} height={size} viewBox="0 0 18 18" fill="none">
      <Path
        d="M16.8758 9.17493C16.8758 8.52743 16.8222 8.05493 16.7061 7.56494H9.1615V10.4874H13.59C13.5008 11.2137 13.0186 12.3074 11.9472 13.0424L11.9322 13.1402L14.3176 14.9513L14.4829 14.9674C16.0007 13.5937 16.8758 11.5724 16.8758 9.17493Z"
        fill="#4285F4"
      />
      <Path
        d="M9.16098 16.8751C11.3306 16.8751 13.152 16.175 14.4824 14.9675L11.9467 13.0425C11.2681 13.5062 10.3574 13.83 9.16098 13.83C7.03601 13.83 5.23246 12.4563 4.58954 10.5575L4.4953 10.5653L2.01486 12.4466L1.98242 12.535C3.30383 15.1075 6.01811 16.8751 9.16098 16.8751Z"
        fill="#34A853"
      />
      <Path
        d="M4.58998 10.5575C4.42034 10.0675 4.32216 9.54245 4.32216 8.99997C4.32216 8.45744 4.42034 7.93246 4.58106 7.44247L4.57656 7.33811L2.06503 5.42664L1.98285 5.46494C1.43824 6.53245 1.12573 7.73123 1.12573 8.99997C1.12573 10.2687 1.43824 11.4674 1.98285 12.5349L4.58998 10.5575Z"
        fill="#FBBC05"
      />
      <Path
        d="M9.16103 4.16998C10.6699 4.16998 11.6878 4.80873 12.2682 5.34251L14.536 3.1725C13.1432 1.90375 11.3306 1.125 9.16103 1.125C6.01814 1.125 3.30384 2.89249 1.98242 5.46497L4.58063 7.44249C5.23248 5.54375 7.03604 4.16998 9.16103 4.16998Z"
        fill="#EB4335"
      />
    </Svg>
  );
}

export function CalendarIcon({ size = 20, color = colors.plum }: { size?: number; color?: string } = {}) {
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24" fill="none">
      <Rect x="3" y="4" width="18" height="18" rx="4" stroke={color} strokeWidth={2} />
      <Path d="M16 2V6" stroke={color} strokeWidth={2} strokeLinecap="round" />
      <Path d="M8 2V6" stroke={color} strokeWidth={2} strokeLinecap="round" />
      <Path d="M3 10H21" stroke={color} strokeWidth={2} />
      <Circle cx="8" cy="14" r="1" fill={color} />
      <Circle cx="12" cy="14" r="1" fill={color} />
      <Circle cx="16" cy="14" r="1" fill={color} />
      <Circle cx="8" cy="18" r="1" fill={color} />
      <Circle cx="12" cy="18" r="1" fill={color} />
      <Circle cx="16" cy="18" r="1" fill={color} />
    </Svg>
  );
}



