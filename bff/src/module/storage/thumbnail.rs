use std::io::Cursor;
use fast_image_resize as fr;
use image::{DynamicImage, GenericImageView, ImageFormat};

use crate::error::{AppError, AppResult};

pub struct ProcessedPhoto {
    pub card_webp: Vec<u8>,
    pub full_webp: Vec<u8>,
    pub thumb_webp: Vec<u8>,
}

/// Computes (width, height) to fit inside (max_w, max_h) while preserving aspect ratio.
fn fit_dimensions(orig_w: u32, orig_h: u32, max_w: u32, max_h: u32) -> (u32, u32) {
    if orig_w == 0 || orig_h == 0 {
        return (max_w.max(1), max_h.max(1));
    }
    let ratio = (orig_w as f64) / (orig_h as f64);
    let max_ratio = (max_w as f64) / (max_h as f64);

    if ratio > max_ratio {
        let w = orig_w.min(max_w);
        let h = ((w as f64) / ratio).round() as u32;
        (w.max(1), h.max(1))
    } else {
        let h = orig_h.min(max_h);
        let w = ((h as f64) * ratio).round() as u32;
        (w.max(1), h.max(1))
    }
}

/// Resizes a DynamicImage to target dimensions using SIMD via fast_image_resize.
fn resize_image(src: &DynamicImage, target_w: u32, target_h: u32) -> AppResult<DynamicImage> {
    let (orig_w, orig_h) = src.dimensions();
    if orig_w == target_w && orig_h == target_h {
        return Ok(src.clone());
    }

    let src_rgba = src.to_rgba8();
    let src_image = fr::images::Image::from_vec_u8(
        orig_w,
        orig_h,
        src_rgba.into_raw(),
        fr::PixelType::U8x4,
    )
    .map_err(|e| AppError::internal(format!("fast_image_resize src error: {e}")))?;

    let mut dst_image = fr::images::Image::new(target_w, target_h, fr::PixelType::U8x4);
    let mut resizer = fr::Resizer::new();
    resizer
        .resize(&src_image, &mut dst_image, None)
        .map_err(|e| AppError::internal(format!("fast_image_resize resize error: {e}")))?;

    let dst_rgba = image::RgbaImage::from_raw(target_w, target_h, dst_image.into_vec())
        .ok_or_else(|| AppError::internal("Failed to construct RgbaImage from resized buffer"))?;

    Ok(DynamicImage::ImageRgba8(dst_rgba))
}

/// Encodes DynamicImage into WebP format buffer.
fn encode_webp(img: &DynamicImage) -> AppResult<Vec<u8>> {
    let mut buf = Vec::new();
    img.write_to(&mut Cursor::new(&mut buf), ImageFormat::WebP)
        .map_err(|e| AppError::internal(format!("WebP encoding failed: {e}")))?;
    Ok(buf)
}

/// Processes an uploaded image into 3 optimized WebP variants:
/// 1. Card / Deck view: max 600x800 (~35 KB)
/// 2. Full / Zoom view: max 1200x1600 (~160 KB)
/// 3. Avatar / Thumbnail: max 200x200 (~10 KB)
pub fn process_photo_variants(bytes: &[u8]) -> AppResult<ProcessedPhoto> {
    let img = image::load_from_memory(bytes)
        .map_err(|e| AppError::bad_request(format!("Cannot decode image: {e}")))?;

    let (orig_w, orig_h) = img.dimensions();

    // 1. Full view
    let (full_w, full_h) = fit_dimensions(orig_w, orig_h, 1200, 1600);
    let full_img = resize_image(&img, full_w, full_h)?;
    let full_webp = encode_webp(&full_img)?;

    // 2. Card view (for swipe deck)
    let (card_w, card_h) = fit_dimensions(orig_w, orig_h, 600, 800);
    let card_img = resize_image(&img, card_w, card_h)?;
    let card_webp = encode_webp(&card_img)?;

    // 3. Avatar thumbnail
    let (thumb_w, thumb_h) = fit_dimensions(orig_w, orig_h, 200, 200);
    let thumb_img = resize_image(&img, thumb_w, thumb_h)?;
    let thumb_webp = encode_webp(&thumb_img)?;

    Ok(ProcessedPhoto {
        card_webp,
        full_webp,
        thumb_webp,
    })
}

#[cfg(test)]
mod tests {
    use super::*;
    use image::{Rgba, RgbaImage};

    #[test]
    fn test_process_photo_variants() {
        // Create a 1000x1500 red test image (2:3 aspect ratio)
        let mut img = RgbaImage::new(1000, 1500);
        for pixel in img.pixels_mut() {
            *pixel = Rgba([255, 0, 0, 255]);
        }
        let mut png_bytes = Vec::new();
        DynamicImage::ImageRgba8(img)
            .write_to(&mut Cursor::new(&mut png_bytes), ImageFormat::Png)
            .unwrap();

        let processed = process_photo_variants(&png_bytes).expect("Processing should succeed");
        assert!(!processed.card_webp.is_empty());
        assert!(!processed.full_webp.is_empty());
        assert!(!processed.thumb_webp.is_empty());

        // Check card decoded dimensions: should preserve 2:3 aspect ratio and fit in 600x800 -> 533x800
        let card_img = image::load_from_memory(&processed.card_webp).unwrap();
        assert!(card_img.width() <= 600);
        assert!(card_img.height() <= 800);
        assert_eq!(card_img.height(), 800);
        assert_eq!(card_img.width(), 533);

        // Check thumb decoded dimensions: should fit in 200x200 -> 133x200
        let thumb_img = image::load_from_memory(&processed.thumb_webp).unwrap();
        assert!(thumb_img.width() <= 200);
        assert!(thumb_img.height() <= 200);
    }
}
