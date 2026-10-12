import subprocess
import os

LOGOS_DIR = "/home/cesium/personal/apps/tea/assets/logos"
os.makedirs(LOGOS_DIR, exist_ok=True)

# Concept 1: The Iconic "Heart-Steam Mug" (Spill The Tea)
# Bold neo-brutalist mug, radiant heart steam cloud, tea bag tag with heart, retro sparkle
svg_c1 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" width="512" height="512">
  <defs>
    <filter id="shadow" x="-5%" y="-5%" width="120%" height="120%">
      <feDropShadow dx="10" dy="10" stdDeviation="0" flood-color="#020202" flood-opacity="1"/>
    </filter>
  </defs>

  <!-- Neo-brutalist Canvas Background (Soft Parchment) -->
  <rect width="512" height="512" rx="100" fill="#ECE6C2"/>
  <rect width="512" height="512" rx="100" fill="none" stroke="#020202" stroke-width="14"/>

  <!-- Subtly tilted backing card for extra brutalist energy -->
  <g transform="translate(4, 4)">
    
    <!-- 4-point Retro Sparkle Stars -->
    <!-- Top Right Sparkle -->
    <path d="M 405 95 Q 405 130 435 130 Q 405 130 405 165 Q 405 130 375 130 Q 405 130 405 95 Z" 
          fill="#0EA8FF" stroke="#020202" stroke-width="8" stroke-linejoin="round"/>
    <!-- Small accent dot -->
    <circle cx="445" cy="85" r="7" fill="#FFD166" stroke="#020202" stroke-width="5"/>
    <circle cx="95" cy="180" r="9" fill="#0EA8FF" stroke="#020202" stroke-width="6"/>

    <!-- STEAM HEART -->
    <!-- Steam Heart Shadow -->
    <path d="M 252 82 
             C 212 28, 138 52, 142 124 
             C 145 174, 206 218, 252 248 
             C 298 218, 359 174, 362 124 
             C 366 52, 292 28, 252 82 Z"
          transform="translate(10, 10)" fill="#020202"/>

    <!-- Steam Heart Main Body (Vibrant Coral Red / Terracotta) -->
    <path d="M 252 82 
             C 212 28, 138 52, 142 124 
             C 145 174, 206 218, 252 248 
             C 298 218, 359 174, 362 124 
             C 366 52, 292 28, 252 82 Z"
          fill="#EF476F" stroke="#020202" stroke-width="12" stroke-linejoin="round"/>

    <!-- Inner Heart Highlight / Glow Layer -->
    <path d="M 252 110 
             C 224 72, 172 90, 175 138 
             C 177 172, 220 202, 252 225 
             C 284 202, 327 172, 329 138 
             C 332 90, 280 72, 252 110 Z"
          fill="#FF7597" stroke="none" opacity="0.6"/>

    <!-- Gentle steam wisps rising into the heart -->
    <path d="M 205 255 Q 190 235 210 215" fill="none" stroke="#020202" stroke-width="8" stroke-linecap="round"/>
    <path d="M 295 255 Q 310 235 290 215" fill="none" stroke="#020202" stroke-width="8" stroke-linecap="round"/>

    <!-- MUG GROUP -->
    <!-- Handle Shadow -->
    <path d="M 345 285 C 415 285 435 385 345 385" 
          transform="translate(10, 10)" fill="none" stroke="#020202" stroke-width="40" stroke-linecap="round"/>
    <!-- Handle Outer -->
    <path d="M 345 285 C 415 285 435 385 345 385" 
          fill="none" stroke="#020202" stroke-width="40" stroke-linecap="round"/>
    <!-- Handle Inner Fill (Mint) -->
    <path d="M 345 285 C 415 285 435 385 345 385" 
          fill="none" stroke="#73BDA8" stroke-width="20" stroke-linecap="round"/>

    <!-- Cup Body Shadow -->
    <path d="M 148 250 L 158 390 C 160 422 188 436 250 436 C 312 436 340 422 342 390 L 352 250 Z" 
          transform="translate(10, 10)" fill="#020202"/>

    <!-- Cup Body (Mint Accent #73BDA8) -->
    <path d="M 148 250 L 158 390 C 160 422 188 436 250 436 C 312 436 340 422 342 390 L 352 250 Z" 
          fill="#73BDA8" stroke="#020202" stroke-width="12" stroke-linejoin="round"/>

    <!-- Cup Rim Ellipse (Hot Tea Surface Inside) -->
    <ellipse cx="250" cy="250" rx="102" ry="24" fill="#020202"/>
    <ellipse cx="250" cy="248" rx="94" ry="18" fill="#CC6B49" stroke="#020202" stroke-width="6"/>
    <!-- Liquid Reflection -->
    <path d="M 210 252 Q 250 258 290 252" fill="none" stroke="#FFD166" stroke-width="6" stroke-linecap="round"/>

    <!-- Neo-Brutalist Graphic on the Cup: "TEA" or Heart Badge -->
    <g transform="translate(250, 345)">
      <!-- Mini Brutalist Stamp -->
      <rect x="-42" y="-24" width="84" height="48" rx="8" fill="#FFFFFF" stroke="#020202" stroke-width="6"/>
      <text x="0" y="8" font-family="Arial, Helvetica, sans-serif" font-size="22" font-weight="900" 
            text-anchor="middle" fill="#020202" letter-spacing="3">TEA</text>
    </g>

    <!-- TEABAG STRING & HEART TAG -->
    <!-- Teabag string draping over the left rim -->
    <path d="M 190 250 Q 155 260 140 295 Q 128 325 125 350" 
          fill="none" stroke="#020202" stroke-width="6" stroke-linecap="round" stroke-dasharray="8 6"/>

    <!-- Hanging Tag Shadow -->
    <g transform="translate(10, 10)">
      <rect x="98" y="348" width="46" height="56" rx="8" 
            transform="rotate(-15 121 376)" fill="#020202"/>
    </g>
    <!-- Hanging Tag (Electric Blue) -->
    <g>
      <rect x="98" y="348" width="46" height="56" rx="8" 
            transform="rotate(-15 121 376)" fill="#0EA8FF" stroke="#020202" stroke-width="6"/>
      <!-- Hole at top of tag -->
      <circle cx="121" cy="358" r="4" fill="#020202"/>
      <!-- Heart stamped on tag -->
      <path d="M 121 372 C 117 367 110 370 110 375 C 110 380 121 387 121 387 C 121 387 132 380 132 375 C 132 370 125 367 121 372 Z"
            fill="#FFFFFF" stroke="#020202" stroke-width="3"/>
    </g>

  </g>
</svg>
"""

with open(f"{LOGOS_DIR}/concept1_heart_mug.svg", "w") as f:
    f.write(svg_c1)

subprocess.run(["rsvg-convert", "-w", "512", "-h", "512", f"{LOGOS_DIR}/concept1_heart_mug.svg", "-o", f"{LOGOS_DIR}/concept1_heart_mug.png"], check=True)
print("Concept 1 generated successfully!")
