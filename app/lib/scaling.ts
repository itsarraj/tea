import { Dimensions } from 'react-native';

const GUIDELINE_BASE_WIDTH = 360;
const GUIDELINE_BASE_HEIGHT = 800;

const { width, height } = Dimensions.get('window');
const [shortDimension, longDimension] =
  width < height ? [width, height] : [height, width];

/** Scale linearly according to device screen width */
export const scale = (size: number): number =>
  (shortDimension / GUIDELINE_BASE_WIDTH) * size;

/** Scale linearly according to device screen height */
export const verticalScale = (size: number): number =>
  (longDimension / GUIDELINE_BASE_HEIGHT) * size;

/**
 * Moderate scale for font sizes and border radii.
 * Factor defaults to 0.5 (dampens aggressive scaling on tablets).
 */
export const moderateScale = (size: number, factor = 0.5): number =>
  size + (scale(size) - size) * factor;

export const moderateVerticalScale = (size: number, factor = 0.5): number =>
  size + (verticalScale(size) - size) * factor;

// Aliases for clean DX
export const s = scale;
export const vs = verticalScale;
export const ms = moderateScale;
export const mvs = moderateVerticalScale;
