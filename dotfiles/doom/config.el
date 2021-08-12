;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Juozas Norkus"
      user-mail-address "norkus@norkus.net")

(setq doom-theme 'doom-vibrant)
(setq display-line-numbers-type t)
(setq doom-font (font-spec
                 :family "Hack Nerd Font Mono"
                 :size 18
                 :weight 'regular))

(setq org-directory "~/documents/org")
(setq projectile-project-search-path '("~/dev/" "~/dev/dokimoto/"))

(setq treemacs-width-is-initially-locked nil)  ;; TODO: this don't work
(setq treemacs-width 25)

(setq ranger-preview-file t)
(setq ranger-parent-depth 1)
(setq ranger-max-preview-size 10)
(setq ranger-dont-show-binary t)

(setq lsp-python-ms-executable (executable-find "python-language-server"))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To see the docs for these functions/macros,
;; move the cursor over the highlighted symbol at press 'K'
