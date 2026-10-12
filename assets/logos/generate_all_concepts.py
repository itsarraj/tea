import subprocess
import os

LOGOS_DIR = "/home/cesium/personal/apps/tea/assets/logos"
os.makedirs(LOGOS_DIR, exist_ok=True)

# -------------------------------------------------------------------------------------
# Concept 1: "The Heart Steam Mug" (Refined Hero)
# Seamless steam rising into a bold graphic heart, neo-brutalist hard shadows, mint & coral
# -------------------------------------------------------------------------------------
c1_svg = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" width="512" height="512">
  <!-- Rounded App Icon Background -->
  <rect x="8" y="8" width="496" height="496" rx="108" fill="#ECE6C2"/>
  <rect x="8" y="8" width="496" height="496" rx="108" fill="none" stroke="#020202" stroke-width="14"/>

  <!-- Accents / Retro Sparkles -->
  <path d="M 408 88 Q 408 122 438 122 Q 408 122 408 156 Q 408 122 378 122 Q 408 122 408 88 Z" 
        fill="#0EA8FF" stroke="#020202" stroke-width="7" stroke-linejoin="round"/>
  <circle cx="448" cy="76" r="6" fill="#FFD166" stroke="#020202" stroke-width="4"/>
  <circle cx="76" cy="190" r="8" fill="#FFD166" stroke="#020202" stroke-width="5"/>
  <path d="M 80 120 Q 80 138 96 138 Q 80 138 80 156 Q 80 138 64 138 Q 80 138 80 120 Z" 
        fill="#73BDA8" stroke="#020202" stroke-width="5" stroke-linejoin="round"/>

  <!-- MAIN ARTWORK GROUP -->
  <g id="artwork">

    <!-- HARD OFFSET SHADOW (All unified offset dx=12, dy=12) -->
    <g transform="translate(12, 12)" fill="#020202" stroke="#020202">
      <!-- Heart Shadow -->
      <path d="M 256 68 
               C 214 12, 136 38, 140 114 
               C 143 166, 206 208, 256 242 
               C 306 208, 369 166, 372 114 
               C 376 38, 298 12, 256 68 Z" stroke-width="14" stroke-linejoin="round"/>
      <!-- Handle Shadow -->
      <path d="M 330 290 C 420 290 420 395 330 395" fill="none" stroke-width="36" stroke-linecap="round"/>
      <!-- Cup Shadow -->
      <path d="M 145 252 L 156 392 C 158 424 190 440 256 440 C 322 440 354 424 356 392 L 367 252 Z" stroke-width="14" stroke-linejoin="round"/>
      <!-- Tag Shadow -->
      <rect x="94" y="348" width="46" height="58" rx="8" transform="rotate(-15 117 377)"/>
    </g>

    <!-- STEAM HEART -->
    <g id="steam-heart">
      <!-- Outer Heart -->
      <path d="M 256 68 
               C 214 12, 136 38, 140 114 
               C 143 166, 206 208, 256 242 
               C 306 208, 369 166, 372 114 
               C 376 38, 298 12, 256 68 Z"
            fill="#EF476F" stroke="#020202" stroke-width="13" stroke-linejoin="round"/>
      
      <!-- Inner Heart Highlight -->
      <path d="M 256 94 
               C 226 52, 168 72, 171 126 
               C 173 162, 218 196, 256 222 
               C 294 196, 339 162, 341 126 
               C 344 72, 286 52, 256 94 Z"
            fill="#FF8CA3" opacity="0.6"/>

      <!-- Rising Steam Curls within and below heart -->
      <path d="M 215 244 C 200 220, 200 190, 222 170" fill="none" stroke="#FFFFFF" stroke-width="8" stroke-linecap="round" opacity="0.8"/>
      <path d="M 295 244 C 310 220, 310 190, 288 170" fill="none" stroke="#FFFFFF" stroke-width="8" stroke-linecap="round" opacity="0.8"/>
    </g>

    <!-- CUP HANDLE -->
    <path d="M 330 290 C 420 290 420 395 330 395" 
          fill="none" stroke="#020202" stroke-width="36" stroke-linecap="round"/>
    <path d="M 330 290 C 420 290 420 395 330 395" 
          fill="none" stroke="#73BDA8" stroke-width="18" stroke-linecap="round"/>

    <!-- CUP BODY -->
    <path d="M 145 252 L 156 392 C 158 424 190 440 256 440 C 322 440 354 424 356 392 L 367 252 Z" 
          fill="#73BDA8" stroke="#020202" stroke-width="13" stroke-linejoin="round"/>

    <!-- Cup Rim & Hot Tea -->
    <ellipse cx="256" cy="252" rx="111" ry="24" fill="#020202"/>
    <ellipse cx="256" cy="250" rx="103" ry="17" fill="#CC6B49"/>
    <!-- Liquid Gold Sheen -->
    <path d="M 200 252 Q 256 260 312 252" fill="none" stroke="#FFD166" stroke-width="5" stroke-linecap="round"/>

    <!-- NEO-BRUTALIST EMBLEM ON CUP: Little dialogue heart badge -->
    <g transform="translate(256, 350)">
      <!-- Pill Badge -->
      <rect x="-48" y="-22" width="96" height="44" rx="22" fill="#FFFFFF" stroke="#020202" stroke-width="6"/>
      <!-- Red Flag & Green Flag / Heart combo -->
      <path d="M -16 2 C -16 -6, -6 -12, 0 -6 C 6 -12, 16 -6, 16 2 C 16 9, 0 16, 0 16 C 0 16, -16 9, -16 2 Z" 
            fill="#EF476F" stroke="#020202" stroke-width="2.5"/>
      <circle cx="-28" cy="2" r="3" fill="#020202"/>
      <circle cx="28" cy="2" r="3" fill="#020202"/>
    </g>

    <!-- TEABAG STRING & DANGLE TAG -->
    <path d="M 185 252 Q 148 266 134 300 Q 124 326 122 352" 
          fill="none" stroke="#020202" stroke-width="5" stroke-dasharray="7 5" stroke-linecap="round"/>

    <!-- Hanging Tag -->
    <g transform="rotate(-15 117 377)">
      <rect x="94" y="348" width="46" height="58" rx="8" 
            fill="#0EA8FF" stroke="#020202" stroke-width="6"/>
      <circle cx="117" cy="358" r="4.5" fill="#020202"/>
      <!-- Stamped heart on tag -->
      <path d="M 117 372 C 113 367 106 369 106 375 C 106 381 117 388 117 388 C 117 388 128 381 128 375 C 128 369 121 367 117 372 Z"
            fill="#FFFFFF" stroke="#020202" stroke-width="3" stroke-linejoin="round"/>
    </g>

  </g>
</svg>
"""

# -------------------------------------------------------------------------------------
# Concept 2: "First Date / Clinking Tea Cups"
# Two teacups clinking together in cheers, creating a heart in the center steam
# -------------------------------------------------------------------------------------
c2_svg = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" width="512" height="512">
  <!-- Rounded App Icon Background -->
  <rect x="8" y="8" width="496" height="496" rx="108" fill="#ECE6C2"/>
  <rect x="8" y="8" width="496" height="496" rx="108" fill="none" stroke="#020202" stroke-width="14"/>

  <!-- Accents -->
  <path d="M 256 36 Q 256 56 274 56 Q 256 56 256 76 Q 256 56 238 56 Q 256 56 256 36 Z" 
        fill="#FFD166" stroke="#020202" stroke-width="5" stroke-linejoin="round"/>
  <circle cx="85" cy="110" r="7" fill="#0EA8FF" stroke="#020202" stroke-width="4"/>
  <circle cx="430" cy="110" r="7" fill="#EF476F" stroke="#020202" stroke-width="4"/>

  <!-- Unified Hard Shadow -->
  <g transform="translate(12, 12)" fill="#020202" stroke="#020202">
    <!-- Heart Steam Shadow -->
    <path d="M 256 90 
             C 220 40, 155 60, 160 130 
             C 163 175, 215 215, 256 245 
             C 297 215, 349 175, 352 130 
             C 357 60, 292 40, 256 90 Z" stroke-width="12"/>
    <!-- Left Cup Shadow -->
    <g transform="rotate(-14 200 340)">
      <path d="M 120 280 C 70 280 70 360 120 360" fill="none" stroke-width="28" stroke-linecap="round"/>
      <rect x="120" y="250" width="120" height="130" rx="20"/>
    </g>
    <!-- Right Cup Shadow -->
    <g transform="rotate(14 312 340)">
      <path d="M 392 280 C 442 280 442 360 392 360" fill="none" stroke-width="28" stroke-linecap="round"/>
      <rect x="272" y="250" width="120" height="130" rx="20"/>
    </g>
  </g>

  <!-- HEART STEAM IN CENTER -->
  <g id="steam-heart">
    <path d="M 256 90 
             C 220 40, 155 60, 160 130 
             C 163 175, 215 215, 256 245 
             C 297 215, 349 175, 352 130 
             C 357 60, 292 40, 256 90 Z"
          fill="#EF476F" stroke="#020202" stroke-width="12" stroke-linejoin="round"/>
    <!-- Inner Heart Glow -->
    <path d="M 256 112 
             C 230 76, 182 92, 185 140 
             C 187 170, 224 200, 256 224 
             C 288 200, 325 170, 327 140 
             C 330 92, 282 76, 256 112 Z"
          fill="#FF8CA3" opacity="0.6"/>
    <!-- Floating steam sparkles -->
    <circle cx="256" cy="155" r="8" fill="#FFFFFF"/>
  </g>

  <!-- LEFT CUP (Mint Green) -->
  <g transform="rotate(-14 200 340)">
    <!-- Handle -->
    <path d="M 120 280 C 70 280 70 360 120 360" fill="none" stroke="#020202" stroke-width="28" stroke-linecap="round"/>
    <path d="M 120 280 C 70 280 70 360 120 360" fill="none" stroke="#73BDA8" stroke-width="14" stroke-linecap="round"/>
    <!-- Cup Body -->
    <rect x="120" y="250" width="120" height="130" rx="22" fill="#73BDA8" stroke="#020202" stroke-width="11"/>
    <!-- Tea Liquid Inside -->
    <ellipse cx="180" cy="254" rx="52" ry="12" fill="#CC6B49" stroke="#020202" stroke-width="5"/>
    <!-- Decorative band -->
    <rect x="135" y="295" width="90" height="36" rx="8" fill="#FFFFFF" stroke="#020202" stroke-width="5"/>
    <text x="180" y="320" font-family="Arial, sans-serif" font-size="16" font-weight="900" text-anchor="middle" fill="#020202">YOU</text>
  </g>

  <!-- RIGHT CUP (Terracotta Coral) -->
  <g transform="rotate(14 312 340)">
    <!-- Handle -->
    <path d="M 392 280 C 442 280 442 360 392 360" fill="none" stroke="#020202" stroke-width="28" stroke-linecap="round"/>
    <path d="M 392 280 C 442 280 442 360 392 360" fill="none" stroke="#CC6B49" stroke-width="14" stroke-linecap="round"/>
    <!-- Cup Body -->
    <rect x="272" y="250" width="120" height="130" rx="22" fill="#CC6B49" stroke="#020202" stroke-width="11"/>
    <!-- Tea Liquid Inside -->
    <ellipse cx="332" cy="254" rx="52" ry="12" fill="#FFD166" stroke="#020202" stroke-width="5"/>
    <!-- Decorative band -->
    <rect x="287" y="295" width="90" height="36" rx="8" fill="#FFFFFF" stroke="#020202" stroke-width="5"/>
    <text x="332" y="320" font-family="Arial, sans-serif" font-size="16" font-weight="900" text-anchor="middle" fill="#020202">DATE</text>
  </g>

  <!-- CLINK / CHEERS SPARK BURST IN CENTER -->
  <g transform="translate(256, 290)">
    <circle cx="0" cy="0" r="14" fill="#FFD166" stroke="#020202" stroke-width="5"/>
    <path d="M -22 -14 L -8 -6 M 22 -14 L 8 -6 M 0 -22 L 0 -10" stroke="#020202" stroke-width="4" stroke-linecap="round"/>
  </g>
</svg>
"""

# -------------------------------------------------------------------------------------
# Concept 3: "The Neo-Brutalist Tea Bag of Hearts"
# Geometric tea bag silhouette, punched heart window, tea droplets, highly legible icon
# -------------------------------------------------------------------------------------
c3_svg = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" width="512" height="512">
  <!-- Rounded App Icon Background -->
  <rect x="8" y="8" width="496" height="496" rx="108" fill="#ECE6C2"/>
  <rect x="8" y="8" width="496" height="496" rx="108" fill="none" stroke="#020202" stroke-width="14"/>

  <!-- Accents -->
  <path d="M 410 100 Q 410 130 435 130 Q 410 130 410 160 Q 410 130 385 130 Q 410 130 410 100 Z" 
        fill="#FFD166" stroke="#020202" stroke-width="6" stroke-linejoin="round"/>
  <circle cx="90" cy="140" r="8" fill="#0EA8FF" stroke="#020202" stroke-width="5"/>

  <!-- TEA STRING & TOP TAG -->
  <!-- String Path -->
  <path d="M 256 160 C 256 100, 320 80, 320 50" fill="none" stroke="#020202" stroke-width="6" stroke-dasharray="8 6"/>

  <!-- Hard Shadow -->
  <g transform="translate(12, 12)" fill="#020202" stroke="#020202">
    <!-- Top Tag Shadow -->
    <rect x="290" y="24" width="60" height="40" rx="8" transform="rotate(12 320 44)"/>
    <!-- Teabag Shadow -->
    <path d="M 190 160 L 322 160 L 372 210 L 372 410 C 372 426, 358 440, 342 440 L 170 440 C 154 440, 140 426, 140 410 L 140 210 Z" stroke-width="12"/>
  </g>

  <!-- TOP TAG (Electric Blue) -->
  <g transform="rotate(12 320 44)">
    <rect x="290" y="24" width="60" height="40" rx="8" fill="#0EA8FF" stroke="#020202" stroke-width="6"/>
    <circle cx="320" cy="36" r="4" fill="#020202"/>
    <text x="320" y="56" font-family="Arial, sans-serif" font-size="14" font-weight="900" text-anchor="middle" fill="#FFFFFF">TEA</text>
  </g>

  <!-- TEABAG BODY (Mint Background with Crisp White Card) -->
  <path d="M 190 160 L 322 160 L 372 210 L 372 410 C 372 426, 358 440, 342 440 L 170 440 C 154 440, 140 426, 140 410 L 140 210 Z" 
        fill="#FFFFFF" stroke="#020202" stroke-width="13" stroke-linejoin="round"/>

  <!-- Fold stitch line at top -->
  <line x1="190" y1="210" x2="322" y2="210" stroke="#020202" stroke-width="4" stroke-dasharray="6 4"/>

  <!-- PUNCHED HEART EMBLEM IN CENTER (Vibrant Coral Red) -->
  <path d="M 256 250 
           C 224 210, 175 228, 178 278 
           C 180 312, 222 344, 256 368 
           C 290 344, 332 312, 334 278 
           C 337 228, 288 210, 256 250 Z"
        fill="#EF476F" stroke="#020202" stroke-width="9" stroke-linejoin="round"/>
  <!-- Inner heart shine -->
  <path d="M 256 268 
           C 238 238, 202 250, 204 286 
           C 205 308, 234 330, 256 348 
           C 278 330, 307 308, 308 286 
           C 310 250, 274 238, 256 268 Z"
        fill="#FF8CA3" opacity="0.6"/>

  <!-- TEA DROPLET RIPPLE AT BOTTOM -->
  <g transform="translate(256, 400)">
    <!-- Droplet -->
    <path d="M 0 0 C -12 16, -12 28, 0 32 C 12 28, 12 16, 0 0 Z" fill="#FFD166" stroke="#020202" stroke-width="4"/>
  </g>
</svg>
"""

# -------------------------------------------------------------------------------------
# Concept 4: "Spill The Dilemma / Speech Mug"
# Teacup where the steam is a speech/advice bubble with a heart and verdict flag
# -------------------------------------------------------------------------------------
c4_svg = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" width="512" height="512">
  <!-- Rounded App Icon Background -->
  <rect x="8" y="8" width="496" height="496" rx="108" fill="#ECE6C2"/>
  <rect x="8" y="8" width="496" height="496" rx="108" fill="none" stroke="#020202" stroke-width="14"/>

  <!-- Accents -->
  <circle cx="85" cy="95" r="8" fill="#FFD166" stroke="#020202" stroke-width="5"/>
  <path d="M 425 80 Q 425 105 445 105 Q 425 105 425 130 Q 425 105 405 105 Q 425 105 425 80 Z" 
        fill="#0EA8FF" stroke="#020202" stroke-width="5" stroke-linejoin="round"/>

  <!-- Unified Hard Shadow -->
  <g transform="translate(12, 12)" fill="#020202" stroke="#020202">
    <!-- Speech Bubble Shadow -->
    <path d="M 140 70 L 372 70 C 400 70, 420 90, 420 118 L 420 182 C 420 210, 400 230, 372 230 L 270 230 L 220 270 L 230 230 L 140 230 C 112 230, 92 210, 92 182 L 92 118 C 92 90, 112 70, 140 70 Z" stroke-width="12"/>
    <!-- Handle Shadow -->
    <path d="M 330 310 C 415 310 415 400 330 400" fill="none" stroke-width="32" stroke-linecap="round"/>
    <!-- Cup Shadow -->
    <path d="M 150 280 L 160 400 C 162 430 190 445 256 445 C 322 445 350 430 352 400 L 362 280 Z" stroke-width="12"/>
  </g>

  <!-- SPEECH BUBBLE STEAM ("Spilling Tea" / Dating Dilemma Advice) -->
  <path d="M 140 70 L 372 70 C 400 70, 420 90, 420 118 L 420 182 C 420 210, 400 230, 372 230 L 270 230 L 220 270 L 230 230 L 140 230 C 112 230, 92 210, 92 182 L 92 118 C 92 90, 112 70, 140 70 Z" 
        fill="#FFFFFF" stroke="#020202" stroke-width="12" stroke-linejoin="round"/>

  <!-- Content inside speech bubble: Heart + Dialogue dots -->
  <g transform="translate(256, 150)">
    <!-- Big romantic heart in speech bubble -->
    <path d="M 0 -36 
             C -24 -62, -62 -48, -58 -10 
             C -55 20, -18 46, 0 64 
             C 18 46, 55 20, 58 -10 
             C 62 -48, 24 -62, 0 -36 Z"
          fill="#EF476F" stroke="#020202" stroke-width="7" stroke-linejoin="round"/>
    <circle cx="-85" cy="0" r="10" fill="#73BDA8" stroke="#020202" stroke-width="5"/>
    <circle cx="85" cy="0" r="10" fill="#0EA8FF" stroke="#020202" stroke-width="5"/>
  </g>

  <!-- CUP HANDLE -->
  <path d="M 330 310 C 415 310 415 400 330 400" fill="none" stroke="#020202" stroke-width="32" stroke-linecap="round"/>
  <path d="M 330 310 C 415 310 415 400 330 400" fill="none" stroke="#73BDA8" stroke-width="16" stroke-linecap="round"/>

  <!-- CUP BODY -->
  <path d="M 150 280 L 160 400 C 162 430 190 445 256 445 C 322 445 350 430 352 400 L 362 280 Z" 
        fill="#73BDA8" stroke="#020202" stroke-width="12" stroke-linejoin="round"/>

  <!-- Cup Rim -->
  <ellipse cx="256" cy="280" rx="106" ry="22" fill="#020202"/>
  <ellipse cx="256" cy="278" rx="98" ry="16" fill="#CC6B49"/>

  <!-- Cup Graphic: "SPILL IT" Pill -->
  <g transform="translate(256, 362)">
    <rect x="-56" y="-20" width="112" height="40" rx="20" fill="#FFFFFF" stroke="#020202" stroke-width="5"/>
    <text x="0" y="7" font-family="Arial, sans-serif" font-size="16" font-weight="900" text-anchor="middle" fill="#020202" letter-spacing="1">SPILL IT</text>
  </g>
</svg>
"""

concepts = [
    ("concept1_heart_mug", c1_svg),
    ("concept2_clinking_cups", c2_svg),
    ("concept3_heart_teabag", c3_svg),
    ("concept4_speech_mug", c4_svg)
]

for name, svg in concepts:
    svg_path = f"{LOGOS_DIR}/{name}.svg"
    png_path = f"{LOGOS_DIR}/{name}.png"
    with open(svg_path, "w") as f:
        f.write(svg)
    subprocess.run(["rsvg-convert", "-w", "512", "-h", "512", svg_path, "-o", png_path], check=True)
    print(f"Generated {name}!")

print("All concepts generated successfully.")
