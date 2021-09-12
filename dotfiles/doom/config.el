;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Juozas Norkus")

(if (eq system-type 'darwin)
  (setq user-mail-address "jnorkus@evolution.com")
  (setq user-mail-address "norkus@norkus.net"))

(setq doom-theme 'doom-vibrant)
(setq display-line-numbers-type t)
(if (eq system-type 'darwin)
  (setq doom-font (font-spec
                   :family "Hack Nerd Font Mono"
                   :size 14
                   :weight 'regular))
  (setq doom-font (font-spec
                   :family "Hack Nerd Font Mono"
                   :size 16
                   :weight 'regular)))

(setq org-directory "~/documents/org")
(setq projectile-project-search-path '("~/dev/" "~/dev/dokimoto/"))

(setq treemacs-width-is-initially-locked nil)  ;; TODO: this don't work
(setq treemacs-width 30)

(setq ranger-preview-file t)
(setq ranger-parent-depth 1)
(setq ranger-max-preview-size 10)
(setq ranger-dont-show-binary t)

;; Python
(add-hook 'before-save-hook 'py-isort-before-save)
;; TODO: this don't work, unused functions, vars and classes are not highlighted
(setq lsp-pyright-typechecking-mode "strict")

(with-eval-after-load 'company
  ;; Company
  ;; Prevent suggestions from being triggered automatically. In particular,
  ;; this makes it so that:
  ;; - TAB will always complete the current selection.
  ;; - RET will only complete the current selection if the user has explicitly
  ;;   interacted with Company.
  ;; - SPC will never complete the current selection.
  (dolist (key '("<return>" "RET"))
    ;; Here we are using an advanced feature of define-key that lets
    ;; us pass an "extended menu item" instead of an interactive
    ;; function. Doing this allows RET to regain its usual
    ;; functionality when the user has not explicitly interacted with
    ;; Company.
    (define-key company-active-map (kbd key)
      `(menu-item nil company-complete
                  :filter ,(lambda (cmd)
                             (when (company-explicit-action-p)
                               cmd)))))
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map (kbd "<tab>") #'company-complete-selection)
  (define-key company-active-map (kbd "TAB") #'company-complete-selection)
  (setq company-auto-complete-chars nil))
