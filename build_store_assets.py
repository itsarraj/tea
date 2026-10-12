import os
from PIL import Image, ImageDraw, ImageFont, ImageFilter

OUTPUT_DIR = "/home/cesium/personal/apps/tea/store-assets"
os.makedirs(OUTPUT_DIR, exist_ok=True)

FONT_BOLD = "/usr/share/fonts/liberation/LiberationSans-Bold.ttf"
FONT_REGULAR = "/usr/share/fonts/liberation/LiberationSans-Regular.ttf"

CANVAS_WIDTH = 1080
CANVAS_HEIGHT = 1920

def create_gradient(width, height, top_color, mid_color, bottom_color):
    img = Image.new("RGB", (width, height))
    draw = ImageDraw.Draw(img)
    mid_y = int(height * 0.45)
    
    # Top to Mid
    for y in range(mid_y):
        ratio = y / float(mid_y)
        r = int(top_color[0] * (1 - ratio) + mid_color[0] * ratio)
        g = int(top_color[1] * (1 - ratio) + mid_color[1] * ratio)
        b = int(top_color[2] * (1 - ratio) + mid_color[2] * ratio)
        draw.line([(0, y), (width, y)], fill=(r, g, b))
        
    # Mid to Bottom
    for y in range(mid_y, height):
        ratio = (y - mid_y) / float(height - mid_y)
        r = int(mid_color[0] * (1 - ratio) + bottom_color[0] * ratio)
        g = int(mid_color[1] * (1 - ratio) + bottom_color[1] * ratio)
        b = int(mid_color[2] * (1 - ratio) + bottom_color[2] * ratio)
        draw.line([(0, y), (width, y)], fill=(r, g, b))
        
    return img

def add_glow(base_img, cx, cy, radius, color, opacity=0.35):
    glow = Image.new("RGBA", base_img.size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(glow)
    r, g, b = color
    alpha = int(255 * opacity)
    draw.ellipse([cx - radius, cy - radius, cx + radius, cy + radius], fill=(r, g, b, alpha))
    glow = glow.filter(ImageFilter.GaussianBlur(radius // 2))
    base_rgba = base_img.convert("RGBA")
    combined = Image.alpha_composite(base_rgba, glow)
    return combined.convert("RGB")

def round_corners(image, radius):
    mask = Image.new("L", image.size, 0)
    draw = ImageDraw.Draw(mask)
    draw.rounded_rectangle([(0, 0), image.size], radius=radius, fill=255)
    result = image.copy().convert("RGBA")
    result.putalpha(mask)
    return result

def patch_s1_prompt(img):
    s = img.copy()
    # Replace test placeholder "gsjjsjns" with a natural clean prompt
    clean_bg = s.crop((260, 920, 420, 975))
    s.paste(clean_bg, (80, 920))
    region = s.crop((75, 915, 300, 980)).filter(ImageFilter.GaussianBlur(2))
    s.paste(region, (75, 915))
    
    draw = ImageDraw.Draw(s)
    font_q = ImageFont.truetype(FONT_BOLD, 36)
    q1 = "Weekend pickup match"
    q2 = "or morning coffee?"
    
    draw.text((85, 905), q1, fill=(0, 0, 0), font=font_q)
    draw.text((84, 904), q1, fill=(255, 255, 255), font=font_q)
    draw.text((85, 946), q2, fill=(0, 0, 0), font=font_q)
    draw.text((84, 945), q2, fill=(255, 255, 255), font=font_q)
    return s

def build_card(screenshot_path, badge_text, title_text, subtitle_text, top_color, mid_color, bot_color, glow_color, output_filename, crop_box=None, patch_fn=None):
    canvas = create_gradient(CANVAS_WIDTH, CANVAS_HEIGHT, top_color, mid_color, bot_color)
    canvas = add_glow(canvas, 180, 220, 300, glow_color, opacity=0.38)
    canvas = add_glow(canvas, 920, 420, 380, glow_color, opacity=0.28)
    canvas = canvas.convert("RGBA")
    
    # Fonts
    font_badge = ImageFont.truetype(FONT_BOLD, 22)
    font_title = ImageFont.truetype(FONT_BOLD, 64)
    font_sub = ImageFont.truetype(FONT_REGULAR, 28)
    
    # 1. Badge Pill
    badge_bbox = font_badge.getbbox(badge_text)
    badge_w = badge_bbox[2] - badge_bbox[0]
    badge_h = badge_bbox[3] - badge_bbox[1]
    pad_x, pad_y = 28, 12
    pill_w = badge_w + pad_x * 2
    pill_h = badge_h + pad_y * 2
    pill_x = (CANVAS_WIDTH - pill_w) // 2
    pill_y = 80
    
    pill_overlay = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
    p_draw = ImageDraw.Draw(pill_overlay)
    p_draw.rounded_rectangle([(pill_x, pill_y), (pill_x + pill_w, pill_y + pill_h)], radius=22, fill=(255, 255, 255, 45), outline=(255, 255, 255, 80), width=1)
    canvas = Image.alpha_composite(canvas, pill_overlay)
    
    draw = ImageDraw.Draw(canvas)
    draw.text((pill_x + pad_x, pill_y + pad_y - 2), badge_text, fill=(250, 210, 245, 255), font=font_badge)
    
    # 2. Main Title
    title_bbox = font_title.getbbox(title_text)
    title_w = title_bbox[2] - title_bbox[0]
    title_x = (CANVAS_WIDTH - title_w) // 2
    title_y = pill_y + pill_h + 22
    
    draw.text((title_x, title_y + 3), title_text, fill=(0, 0, 0, 110), font=font_title)
    draw.text((title_x, title_y), title_text, fill=(255, 255, 255, 255), font=font_title)
    
    # 3. Subtitle
    sub_bbox = font_sub.getbbox(subtitle_text)
    sub_w = sub_bbox[2] - sub_bbox[0]
    sub_x = (CANVAS_WIDTH - sub_w) // 2
    sub_y = title_y + 84
    draw.text((sub_x, sub_y), subtitle_text, fill=(242, 222, 242, 225), font=font_sub)
    
    # 4. Process Screenshot
    screen_raw = Image.open(screenshot_path)
    if crop_box:
        screen_raw = screen_raw.crop(crop_box)
    if patch_fn:
        screen_raw = patch_fn(screen_raw)
        
    target_screen_w = 840
    aspect = screen_raw.height / float(screen_raw.width)
    target_screen_h = int(target_screen_w * aspect)
    screen_scaled = screen_raw.resize((target_screen_w, target_screen_h), Image.Resampling.LANCZOS)
    
    bezel_radius = 48
    screen_rounded = round_corners(screen_scaled, bezel_radius)
    
    device_x = (CANVAS_WIDTH - target_screen_w) // 2
    device_y = 390
    
    # Realistic soft multi-layer shadow
    shadow_layer = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
    s_draw = ImageDraw.Draw(shadow_layer)
    s_draw.rounded_rectangle([(device_x - 12, device_y + 16), (device_x + target_screen_w + 12, device_y + target_screen_h + 10)], radius=bezel_radius + 4, fill=(0, 0, 0, 185))
    shadow_layer = shadow_layer.filter(ImageFilter.GaussianBlur(38))
    canvas = Image.alpha_composite(canvas, shadow_layer)
    
    # Inner Phone Canvas
    canvas.alpha_composite(screen_rounded, (device_x, device_y))
    
    # Modern camera punch hole (subtle pinhole at top center of device)
    punch_x = CANVAS_WIDTH // 2
    punch_y = device_y + 18
    p_radius = 8
    punch_layer = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
    punch_draw = ImageDraw.Draw(punch_layer)
    punch_draw.ellipse([(punch_x - p_radius, punch_y - p_radius), (punch_x + p_radius, punch_y + p_radius)], fill=(20, 20, 24, 255), outline=(50, 50, 60, 200), width=1)
    canvas = Image.alpha_composite(canvas, punch_layer)
    
    # Sleek border outline
    rim_layer = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
    r_draw = ImageDraw.Draw(rim_layer)
    r_draw.rounded_rectangle([(device_x, device_y), (device_x + target_screen_w, device_y + target_screen_h)], radius=bezel_radius, outline=(255, 255, 255, 80), width=3)
    canvas = Image.alpha_composite(canvas, rim_layer)
    
    # Export 24-bit PNG
    out_final = canvas.convert("RGB")
    out_path = os.path.join(OUTPUT_DIR, output_filename)
    out_final.save(out_path, format="PNG", optimize=True)
    print(f"Generated: {out_path} ({out_final.size})")

# 1. Clean patched version (Recommended for Play Store submission)
build_card(
    screenshot_path="/home/cesium/personal/apps/palora/Screenshot_20260929-145147_1.png",
    badge_text="PALORA COMMUNITY",
    title_text="Make Real Friends",
    subtitle_text="Break the ice with community questions & stories",
    top_color=(68, 18, 70),
    mid_color=(42, 10, 44),
    bot_color=(18, 5, 20),
    glow_color=(221, 136, 207),
    output_filename="01_make_friends.png",
    patch_fn=patch_s1_prompt
)

# 1b. Raw version (preserving original "gsjjsjns")
build_card(
    screenshot_path="/home/cesium/personal/apps/palora/Screenshot_20260929-145147_1.png",
    badge_text="PALORA COMMUNITY",
    title_text="Make Real Friends",
    subtitle_text="Break the ice with community questions & stories",
    top_color=(68, 18, 70),
    mid_color=(42, 10, 44),
    bot_color=(18, 5, 20),
    glow_color=(221, 136, 207),
    output_filename="01_make_friends_raw.png"
)

# 2. Dating / Match Swipe Deck
build_card(
    screenshot_path="/home/cesium/personal/apps/palora/Screenshot_20260929-145252_1.png",
    badge_text="INTENTIONAL DATING",
    title_text="Find Your Match",
    subtitle_text="Swipe, match, and connect with people near you",
    top_color=(84, 22, 68),
    mid_color=(54, 12, 45),
    bot_color=(24, 6, 22),
    glow_color=(235, 110, 185),
    output_filename="02_find_matches.png"
)

# 3. Icebreakers & Conversation Starters
build_card(
    screenshot_path="/home/cesium/personal/apps/palora/Screenshot_20260929-145317.png",
    badge_text="CONVERSATION STARTERS",
    title_text="Skip Small Talk",
    subtitle_text="Answer thought-provoking prompts that spark chemistry",
    top_color=(48, 18, 72),
    mid_color=(32, 10, 48),
    bot_color=(16, 5, 24),
    glow_color=(185, 115, 235),
    output_filename="03_conversation_starters.png",
    crop_box=(0, 76, 720, 76 + 1480)
)
