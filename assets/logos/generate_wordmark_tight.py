import subprocess

LOGOS_DIR = "/home/cesium/personal/apps/tea/assets/logos"

wordmark_tight_svg = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 180" width="540" height="180" fill="none">
  <!-- Left: Scaled Teacup Icon (centered in 180x180) -->
  <g transform="translate(-10, -6) scale(0.38)">
    <!-- Sparkles -->
    <path d="M 414 78 Q 414 114 446 114 Q 414 114 414 150 Q 414 114 382 114 Q 414 114 414 78 Z" 
          fill="#0EA8FF" stroke="#020202" stroke-width="8" stroke-linejoin="round"/>
    <circle cx="452" cy="64" r="8" fill="#FFD166" stroke="#020202" stroke-width="5"/>
    <path d="M 72 108 Q 72 126 88 126 Q 72 126 72 144 Q 72 126 56 126 Q 72 126 72 108 Z" 
          fill="#73BDA8" stroke="#020202" stroke-width="6" stroke-linejoin="round"/>

    <!-- Shadow -->
    <g transform="translate(14, 14)" fill="#020202" stroke="#020202">
      <path d="M 256 62 C 214 6, 134 32, 138 110 C 142 164, 206 208, 256 242 C 306 208, 370 164, 374 110 C 378 32, 298 6, 256 62 Z" stroke-width="14"/>
      <path d="M 330 278 C 426 278 426 380 330 380" fill="none" stroke-width="36" stroke-linecap="round"/>
      <path d="M 142 242 L 156 376 C 158 406 186 420 256 420 C 326 420 354 406 356 376 L 370 242 Z" stroke-width="14"/>
      <path d="M 112 418 C 112 408 150 404 256 404 C 362 404 400 408 400 418 C 400 434 362 444 256 444 C 150 444 112 434 112 418 Z" stroke-width="14"/>
      <rect x="86" y="335" width="46" height="58" rx="8" transform="rotate(-15 109 364)"/>
    </g>

    <!-- Heart Steam -->
    <path d="M 256 62 C 214 6, 134 32, 138 110 C 142 164, 206 208, 256 242 C 306 208, 370 164, 374 110 C 378 32, 298 6, 256 62 Z"
          fill="#EF476F" stroke="#020202" stroke-width="13" stroke-linejoin="round"/>
    <path d="M 256 90 C 226 48, 168 68, 171 124 C 173 160, 218 195, 256 222 C 294 195, 339 160, 341 124 C 344 68, 286 48, 256 90 Z"
          fill="#FF8CA3" opacity="0.6"/>
    <path d="M 212 242 C 196 215, 196 182, 222 162" fill="none" stroke="#FFFFFF" stroke-width="9" stroke-linecap="round"/>
    <path d="M 300 242 C 316 215, 316 182, 290 162" fill="none" stroke="#FFFFFF" stroke-width="9" stroke-linecap="round"/>

    <!-- Saucer Base -->
    <path d="M 112 418 C 112 408 150 404 256 404 C 362 404 400 408 400 418 C 400 434 362 444 256 444 C 150 444 112 434 112 418 Z" 
          fill="#FFFFFF" stroke="#020202" stroke-width="12" stroke-linejoin="round"/>
    <ellipse cx="256" cy="420" rx="118" ry="12" fill="none" stroke="#73BDA8" stroke-width="6"/>

    <!-- Handle -->
    <path d="M 330 278 C 426 278 426 380 330 380" fill="none" stroke="#020202" stroke-width="36" stroke-linecap="round"/>
    <path d="M 330 278 C 426 278 426 380 330 380" fill="none" stroke="#73BDA8" stroke-width="18" stroke-linecap="round"/>

    <!-- Cup Body -->
    <path d="M 142 242 L 156 376 C 158 406 186 420 256 420 C 326 420 354 406 356 376 L 370 242 Z" 
          fill="#73BDA8" stroke="#020202" stroke-width="13" stroke-linejoin="round"/>
    <ellipse cx="256" cy="242" rx="114" ry="24" fill="#020202"/>
    <ellipse cx="256" cy="240" rx="106" ry="17" fill="#CC6B49"/>
    <path d="M 198 242 Q 256 250 314 242" fill="none" stroke="#FFD166" stroke-width="6" stroke-linecap="round"/>

    <!-- Pill Badge -->
    <g transform="translate(256, 335)">
      <rect x="-56" y="-22" width="112" height="44" rx="10" fill="#FFFFFF" stroke="#020202" stroke-width="6"/>
      <path d="M -36 -10 L -18 -10 L -18 -4 L -24 -4 L -24 10 L -30 10 L -30 -4 L -36 -4 Z" fill="#020202"/>
      <path d="M -11 -10 L 7 -10 L 7 -4 L -5 -4 L -5 -2 L 5 -2 L 5 3 L -5 3 L -5 5 L 7 5 L 7 10 L -11 10 Z" fill="#020202"/>
      <path d="M 14 10 L 22 -10 L 29 -10 L 37 10 L 31 10 L 29 4 L 22 4 L 20 10 Z M 23 -1 L 28 -1 L 25.5 -6 Z" fill="#020202"/>
    </g>

    <!-- Tag -->
    <path d="M 180 242 Q 142 254 128 288 Q 118 314 116 340" 
          fill="none" stroke="#020202" stroke-width="6" stroke-dasharray="7 5" stroke-linecap="round"/>
    <g transform="rotate(-15 109 364)">
      <rect x="86" y="335" width="46" height="58" rx="8" fill="#0EA8FF" stroke="#020202" stroke-width="6"/>
      <circle cx="109" cy="345" r="5" fill="#020202"/>
      <path d="M 109 360 C 105 355 98 357 98 363 C 98 369 109 376 109 376 C 109 376 120 369 120 363 C 120 357 113 355 109 360 Z"
            fill="#FFFFFF" stroke="#020202" stroke-width="3" stroke-linejoin="round"/>
    </g>
  </g>

  <!-- Right: Typography "TEA" (Pure Vectors!) + "DATING ADVICE" Pill -->
  <g transform="translate(195, 20)">
    
    <!-- Vector "TEA" Headline -->
    <!-- Hard shadow for TEA letters -->
    <g transform="translate(6, 6)" fill="#020202">
      <!-- T -->
      <path d="M 10 16 L 86 16 L 86 36 L 58 36 L 58 88 L 38 88 L 38 36 L 10 36 Z"/>
      <!-- E -->
      <path d="M 98 16 L 164 16 L 164 36 L 120 36 L 120 44 L 158 44 L 158 60 L 120 60 L 120 68 L 166 68 L 166 88 L 98 88 Z"/>
      <!-- A -->
      <path d="M 194 88 L 218 16 L 246 16 L 270 88 L 248 88 L 243 70 L 221 70 L 216 88 Z M 225 54 L 239 54 L 232 30 Z"/>
    </g>

    <!-- Main Front TEA letters -->
    <g fill="#020202">
      <!-- T -->
      <path d="M 10 16 L 86 16 L 86 36 L 58 36 L 58 88 L 38 88 L 38 36 L 10 36 Z"/>
      <!-- E -->
      <path d="M 98 16 L 164 16 L 164 36 L 120 36 L 120 44 L 158 44 L 158 60 L 120 60 L 120 68 L 166 68 L 166 88 L 98 88 Z"/>
      <!-- A -->
      <path d="M 194 88 L 218 16 L 246 16 L 270 88 L 248 88 L 243 70 L 221 70 L 216 88 Z M 225 54 L 239 54 L 232 30 Z"/>
    </g>

    <!-- Little Heart Accent above the A -->
    <g transform="translate(262, 8)">
      <path d="M 12 0 C 6 -6, -4 -3, -4 4 C -4 10, 6 18, 12 24 C 18 18, 28 10, 28 4 C 28 -3, 18 -6, 12 0 Z" 
            fill="#EF476F" stroke="#020202" stroke-width="3.5" stroke-linejoin="round"/>
    </g>

    <!-- Subtitle Pill: "DATING ADVICE" -->
    <g transform="translate(8, 102)">
      <!-- Hard Shadow -->
      <rect x="5" y="5" width="280" height="38" rx="8" fill="#020202"/>
      <!-- Pill (Mint Accent) -->
      <rect x="0" y="0" width="280" height="38" rx="8" fill="#73BDA8" stroke="#020202" stroke-width="3.5"/>
      <text x="140" y="25" font-family="'Arial Black', Impact, sans-serif" font-size="17" font-weight="900" 
            text-anchor="middle" fill="#020202" letter-spacing="3.5">DATING ADVICE</text>
    </g>

    <!-- Mini Verdict Flags Combo -->
    <g transform="translate(304, 114)">
      <!-- Red Flag -->
      <path d="M 0 0 L 12 -4 L 0 -9 Z" fill="#D72A2A" stroke="#020202" stroke-width="1.5"/>
      <line x1="0" y1="0" x2="0" y2="12" stroke="#020202" stroke-width="2" stroke-linecap="round"/>
      <!-- Green Flag -->
      <path d="M 18 0 L 30 -4 L 18 -9 Z" fill="#06D6A0" stroke="#020202" stroke-width="1.5"/>
      <line x1="18" y1="0" x2="18" y2="12" stroke="#020202" stroke-width="2" stroke-linecap="round"/>
    </g>

  </g>
</svg>
"""

with open(f"{LOGOS_DIR}/tea_logo_wordmark.svg", "w") as f:
    f.write(wordmark_tight_svg)

subprocess.run(["rsvg-convert", "-w", "540", "-h", "180", f"{LOGOS_DIR}/tea_logo_wordmark.svg", "-o", f"{LOGOS_DIR}/tea_logo_wordmark.png"], check=True)
print("Updated wordmark tight successfully!")
