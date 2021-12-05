(require 'doom-themes)

;;
;;; Variables

(defgroup doom-vibrant-theme nil
  "Options for the `doom-vibrant' theme."
  :group 'doom-themes)

;;
;;; Theme definition

(def-doom-theme doom-vibrant
  "A dark theme based off of doom-one with more vibrant colors."

  ;; name        gui       256           16
  ((bg         '("#000000" "black"       "black" ))
   (fg         '("#ffffff" "#bfbfbf"     "brightwhite" ))
   (bg-alt     '("#15161d" "black"       "black"       ))
   (fg-alt     '("#fdfdfd" "#5d5d5d"     "white"       ))

   ;; These should represent a spectrum from bg to fg, where base0 is a starker
   ;; bg and base8 is a starker fg. For example, if bg is light grey and fg is
   ;; dark grey, base0 should be white and base8 should be black.
   (base0      '("#15161D" "#101010"     "black"       ))
   (base1      '("#323339" "#1e1e1e"     "brightblack" ))
   (base2      '("#4F5055" "#21212d"     "brightblack" ))
   (base3      '("#6C6D71" "#262626"     "brightblack" ))
   (base4      '("#898A8D" "#5e5e5e"     "brightblack" ))
   (base5      '("#A6A6A9" "#666666"     "brightblack" ))
   (base6      '("#C3C3C5" "#7b7b7b"     "brightblack" ))
   (base7      '("#E0E0E1" "#979797"     "brightblack" ))
   (base8      '("#FDFDFD" "#dfdfdf"     "white"       ))

   (grey       base4)
   (red        '("#ff4971" "#ff6655" "red"             ))
   (orange     '("#ff6e30" "#dd8844" "brightred"       ))
   (green      '("#3dff74" "#99bb66" "green"           ))
   (teal       '("#18e3c8" "#44b9b1" "brightgreen"     ))
   (yellow     '("#fffc3d" "#ECBE7B" "yellow"          ))
   (blue       '("#49b0ff" "#51afef" "brightblue"      ))
   (dark-blue  '("#3b8dcc" "#2257A0" "blue"            ))
   (magenta    '("#ff4aff" "#c678dd" "brightmagenta"   ))
   (violet     '("#b486ff" "#a9a1e1" "magenta"         ))
   (cyan       '("#0fd9fa" "#46D9FF" "brightcyan"      ))
   (dark-cyan  '("#0ba5bd" "#5699AF" "cyan"            ))

   ;; These are the "universal syntax classes" that doom-themes establishes.
   ;; These *must* be included in every doom themes, or your theme will throw an
   ;; error, as they are used in the base theme defined in doom-themes-base.
   (highlight      cyan)
   (vertical-bar   base0)
   (selection      dark-blue)
   (builtin        magenta)
   (comments       base3)
   (doc-comments   base3)
   (constants      violet)
   (functions      teal)
   (keywords       blue)
   (methods        teal)
   (operators      magenta)
   (type           yellow)
   (strings        green)
   (variables      base5)
   (numbers        orange)
   (region         base1)
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    yellow)
   (vc-added       green)
   (vc-deleted     red)

   (modeline-fg-inactive  (doom-blend blue grey 0.2))
   (modeline-bg           `(,(doom-darken (car bg) 0.15) ,@(cdr base1)))
   (modeline-bg-alt       `(,(car bg-alt) ,@(cdr base0)))
  )

  ;; Base theme face overrides
  (
   ;; Line numbers
   ((line-number &override) :foreground base5)
   ((line-number-current-line &override) :foreground cyan :bold bold)

   ;; Search
   (lazy-highlight :background yellow :foreground bg :weight 'bold)
   (evil-snipe-first-match-face :background yellow :foreground bg :weight 'bold)
   (evil-snipe-matches-face :background yellow :foreground bg :weight 'bold)
   ((company-tooltip-selection &override) :background dark-cyan)
   (nav-flash-face :background cyan :foreground bg :weight 'bold)

   ;; modeline
   (mode-line :background "#032D33" :foreground fg)
   (mode-line-inactive :background bg-alt :foreground modeline-fg-inactive)
   (mode-line-emphasis :foreground cyan)

   ;; solaire
   (solaire-mode-line-face :inherit 'mode-line :background modeline-bg-alt)
   (solaire-mode-line-inactive-face :inherit 'mode-line-inactive :background bg)

   ;; Erlang
   ;; TODO

   ;; css / scss
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)

   ;; Magit
   (magit-diff-added :background "#001604" :foreground fg)
   (magit-diff-added-highlight :background "#002403" :foreground fg)
   (diff-refine-added :background "#005510" :foreground fg)
   (magit-diff-removed :background "#240803" :foreground fg)
   (magit-diff-removed-highlight :background "#3a0004" :foreground fg)
   (diff-refine-removed :background "#8b1117" :foreground fg)
   (magit-diff-context :background bg-alt :foreground fg)
   (magit-diff-context-highlight :background bg-alt :foreground fg)
   (magit-diff-hunk-heading :background bg-alt :foreground base3)
   (magit-diff-hunk-heading-highlight :background cyan :foreground bg :weight 'bold)
   (magit-diff-file-heading :foreground yellow :weight 'light)
   (magit-diff-file-heading-highlight :foreground yellow :weight 'bold)
   (magit-diff-file-heading-selection :foreground magenta :weight 'bold)

   ;; Get rid of annoying light grey backgrounds for tables in variety of modes
   (markdown-code-face :background bg-alt :foreground fg-alt)
   (markdown-table-face :background bg-alt :foreground fg-alt)
   (markdown-inline-code-face :background bg :foreground magenta)
   (org-agenda-column-dateline :background bg-alt :foreground fg-alt)
   ((org-block &override) :background bg-alt :foreground fg-alt)
   ((org-verse &override) :background bg-alt :foreground fg-alt)
   ((org-quote &override) :background bg-alt :foreground fg-alt)
   ((org-column &override) :background bg-alt :foreground fg-alt)
   ((org-block-begin-line &override) :background bg-alt :foreground fg-alt)
   ((org-block-end-line &override) :background bg-alt :foreground fg-alt)

   ;; all-the-icons
   ((all-the-icons-dblue &override) :foreground dark-cyan)

   ;; doom-modeline
   (doom-modeline-bar :background  highlight)
   (doom-modeline-buffer-path :foreground blue :bold bold)

   ;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")

   ;; markdown-mode
   (markdown-header-face :inherit 'bold :foreground red)

   ;; whitespace <built-in>
   (whitespace-empty :background red)
  )
)
