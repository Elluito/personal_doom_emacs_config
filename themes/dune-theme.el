;;; doom-dune-theme.el --- Dune-inspired Doom theme
(require 'doom-themes)

(def-doom-theme dune
  "A Dune (Frank Herbert) inspired dark theme."

  ;; Name    GUI            256-color      16-color
  ((bg         '("#1e1a16" "black"        "black"        ))  ; Arrakis Sand
   (bg-alt     '("#292421" "brightblack"  "brightblack"  ))  ; Slightly lighter sand
   (base0      '("#20201d" "black"        "black"        ))
   (base1      '("#292824" "brightblack"  "brightblack"  ))
   (base2      '("#6e6b5e" "brightblack"  "brightblack"  ))
   (base3      '("#999580" "brightblack"  "brightblack"  ))
   (base4      '("#a6a28c" "brightblack"  "brightblack"  ))
   (base5      '("#e8e4cf" "white"        "white"        ))
   (base6      '("#fefbec" "white"        "white"        ))
   (base7      '("#ffffff" "white"        "white"        ))
   (fg         '("#d7a54d" "yellow"       "yellow"       ))  ; Melange Glow
   (fg-alt     '("#c0c0c0" "white"        "white"        ))  ; Crysknife Silver

   ;; Standard colors
   (red        '("#d73737" "red"          "red"          ))
   (orange     '("#b65611" "brightred"    "brightred"    ))
   (yellow     '("#d7a54d" "yellow"       "yellow"       ))
   (green      '("#60ac39" "green"        "green"        ))
   (teal       '("#1fad83" "cyan"         "cyan"         ))
   (blue       '("#6684e1" "blue"         "blue"         ))
   (dark-blue  '("#4f6f94" "blue"         "blue"         ))
   (magenta    '("#b854d4" "magenta"      "magenta"      ))
   (violet     '("#d43552" "magenta"      "magenta"      ))
   (cyan       '("#8cd0d3" "cyan"         "cyan"         ))
   (dark-cyan  '("#1fad83" "cyan"         "cyan"         ))

   ;; Extra teal and orange if needed
   (teal-green '("#60ac39" "green"        "green"        ))
   (red-alt    '("#d43552" "red"          "red"          ))

   ;; Common additional colors
   (grey       '("#7d7a68" "brightblack"  "brightblack"  ))
   (base-blue  '("#6684e1" "blue"         "blue"         ))

   (border     bg))

  ;; --- Face overrides ---
  (
   (cursor :background "#c0c0c0" :foreground "#1e1a16")  ; Crysknife cursor on Arrakis
   (region :background "#494438")                       ; Dark sand selection
   (font-lock-comment-face
    :foreground "#999580" :slant 'italic)               ; Fremen carved text
   (font-lock-comment-delimiter-face
    :foreground "#999580" :slant 'italic))

  ;; No additional variables
  )

