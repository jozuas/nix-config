;; doom-vibrant-theme.el --- a more vibrant version of doom-one -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Copyright (C) 2016-2021 Henrik Lissner
;;
;; Author: Henrik Lissner <https://github.com/hlissner>
;; Created: December 6, 2020
;; Version: 2.0.0
;; Keywords: custom themes, faces
;; Homepage: https://github.com/hlissner/emacs-doom-themes
;; Package-Requires: ((emacs "25.1") (cl-lib "0.5") (doom-themes "2.2.1"))
;;
;;; Commentary:
;;
;; A version of `doom-one' that uses more vibrant colors.
;;
;;; Code:

(require 'doom-themes)


;;
;;; Variables

(defgroup doom-vibrant-theme nil
  "Options for the `doom-vibrant' theme."
  :group 'doom-themes)

(defcustom doom-vibrant-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-vibrant-theme
  :type 'boolean)

(defcustom doom-vibrant-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-vibrant-theme
  :type 'boolean)

(defcustom doom-vibrant-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-vibrant-theme
  :type '(choice integer boolean))


;;
;;; Theme definition

(def-doom-theme doom-vibrant
  "A dark theme based off of doom-one with more vibrant colors."

  ;; name        gui       256           16
  ((bg         '("#000000" "black"       "black" ))
   (fg         '("#ffffff" "#bfbfbf"     "brightwhite" ))

   ;; These are off-color variants of bg/fg, used primarily for `solaire-mode',
   ;; but can also be useful as a basis for subtle highlights (e.g. for hl-line
   ;; or region), especially when paired with the `doom-darken', `doom-lighten',
   ;; and `doom-blend' helper functions.
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
   (dark-cyan  '("#96D2FF" "#5699AF" "cyan"            ))

   ;; These are the "universal syntax classes" that doom-themes establishes.
   ;; These *must* be included in every doom themes, or your theme will throw an
   ;; error, as they are used in the base theme defined in doom-themes-base.
   (highlight      blue)
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

   ;; These are extra color variables used only in this theme; i.e. they aren't
   ;; mandatory for derived themes.
   (modeline-fg             fg)
   (modeline-fg-inactive    (doom-blend blue grey (if doom-vibrant-brighter-modeline 0.9 0.2)))
   (modeline-bg             (if doom-vibrant-brighter-modeline
                                `("#383f58" ,@(cdr base1))
                              `(,(doom-darken (car bg) 0.15) ,@(cdr base1))))
   (modeline-bg-alt         (if doom-vibrant-brighter-modeline
                                modeline-bg
                              `(,(car bg-alt) ,@(cdr base0))))
   (modeline-bg-inactive     `(,(doom-darken (car bg-alt) 0.2) ,@(cdr base0)))
   (modeline-bg-alt-inactive (doom-darken bg 0.25))

   (-modeline-pad
    (when doom-vibrant-padded-modeline
      (if (integerp doom-vibrant-padded-modeline) doom-vibrant-padded-modeline 4))))


  ;;;; Base theme face overrides
  (((font-lock-comment-face &override)
    :background (if doom-vibrant-brighter-comments (doom-darken bg-alt 0.095)))
   ((line-number &override) :foreground base5)
   ((line-number-current-line &override) :foreground blue :bold bold)
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-inactive
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if doom-vibrant-brighter-modeline base8 highlight))
   (org-block :background (doom-darken base3 0.1))

   ;;;; all-the-icons
   ((all-the-icons-dblue &override) :foreground dark-cyan)
   ;;;; centaur-tabs
   (centaur-tabs-unselected :background bg-alt :foreground base6)
   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)
   ;;;; doom-modeline
   (doom-modeline-bar
    :background (if doom-vibrant-brighter-modeline modeline-bg highlight))
   (doom-modeline-buffer-path
    :foreground (if doom-vibrant-brighter-modeline base8 blue) :bold bold)
   ;;;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   ;;;; markdown-mode
   (markdown-header-face :inherit 'bold :foreground red)
   ;;;; solaire-mode
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-alt-inactive
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt-inactive)))
   ;;;; whitespace <built-in>
   (whitespace-empty :background base2))

  ;;;; Base theme variable overrides
  ;; ()
  )

;;; doom-vibrant-theme.el ends here
