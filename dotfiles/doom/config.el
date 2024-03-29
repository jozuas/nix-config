;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Juozas Norkus")

(setq user-mail-address "norkus@norkus.net")

(setq doom-theme 'doom-vibrant)
(setq display-line-numbers-type 'relative)
(setq doom-font (font-spec
                 :family "DejaVuSansM Nerd Font Mono"
                 :size (if (eq system-type 'darwin) 14 16)
                 :weight 'regular))

(setq-default tab-width 4)

(tool-bar-mode -1)

;; Evil mode
(setq evil-shift-width 2)
(setq global-evil-surround-mode 1)
(evil-ex-define-cmd "quit" 'evil-quit)
(evil-ex-define-cmd "q" 'kill-this-buffer)
(evil-ex-define-cmd "wq" 'doom/save-and-kill-buffer)
(define-key evil-window-map "-" '+evil/window-split-and-follow)
(define-key evil-window-map "|" '+evil/window-vsplit-and-follow)
(define-key evil-window-map "s" 'ace-swap-window)
(define-key evil-window-map "e" 'doom/window-enlargen)
(define-key evil-window-map "u" nil)
(define-key evil-window-map "o" nil)
(define-key evil-window-map "t" nil)
(define-key evil-window-map "p" nil)
(define-key evil-window-map "c" nil)
(define-key evil-window-map "b" nil)
(define-key evil-window-map "n" nil)
(define-key evil-window-map "S" nil)
(define-key evil-window-map "v" nil)
(define-key evil-window-map "V" nil)
(define-key evil-window-map "_" nil)
(define-key evil-window-map "+" nil)
(define-key evil-window-map ">" nil)
(define-key evil-window-map "<" nil)
(define-key evil-window-map "\C-b" nil)
(define-key evil-window-map "\C-c" nil)
(define-key evil-window-map "\C-f" nil)
(define-key evil-window-map "\C-_" nil)
(define-key evil-window-map "\C-h" nil)
(define-key evil-window-map "\C-j" nil)
(define-key evil-window-map "\C-k" nil)
(define-key evil-window-map "\C-l" nil)
(define-key evil-window-map "\C-n" nil)
(define-key evil-window-map "\C-o" nil)
(define-key evil-window-map "\C-p" nil)
(define-key evil-window-map "\C-r" nil)
(define-key evil-window-map "\C-s" nil)
(define-key evil-window-map "\C-t" nil)
(define-key evil-window-map "\C-u" nil)
(define-key evil-window-map "\C-v" nil)

;; Easy window resizing with CTRL + arrow keys
(global-set-key (kbd "C-<down>") 'enlarge-window)
(global-set-key (kbd "C-<up>") 'shrink-window)
(global-set-key (kbd "C-<left>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-<right>") 'shrink-window-horizontally)

(setq projectile-project-search-path '("~/dev/"))
(setq projectile-indexing-method 'alien)
(after! projectile
  (add-to-list 'projectile-globally-ignored-directories "node-modules") ;; JS
  (add-to-list 'projectile-globally-ignored-directories "*dist") ;; JS
  (add-to-list 'projectile-globally-ignored-directories "*.yarn") ;; JS
  (add-to-list 'projectile-globally-ignored-directories "*_build") ;; Erlang/Elixir
  (add-to-list 'projectile-globally-ignored-directories "*deps") ;; Elixir
  (add-to-list 'projectile-globally-ignored-directories "*.direnv") ;; Nix
  (add-to-list 'projectile-globally-ignored-directories "*.devenv") ;; Devenv
  )

;; Config for all LSPs
;; (setq lsp-ui-doc-enable nil)  ;; Do not show documentation popups

;; rfc-mode
(setq rfc-mode-directory (expand-file-name "~/.rfc/"))

;; Web mode
(with-eval-after-load 'web-mode
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-attr-indent-offset 2)
  (setq web-mode-style-padding 2)
  (setq web-mode-script-padding 2)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-current-column-highlight t)
  )

(with-eval-after-load 'company
  ;; Company
  ;; Prevent suggestions from being triggered automatically. In particular,
  ;; this makes it so that:
  ;; - TAB will always complete the current selection.
  ;; - RET will only complete the current selection if the user has explicitly
  ;;   interacted with Company.
  (dolist (key '("<return>" "RET"))
    ;; Here we are using an advanced feature of define-key that lets
    ;; us pass an "extended menu item" instead of an interactive
    ;; function. Doing this allows RET to regain its usual functionality
    ;; when the user has not explicitly interacted with Company.
    (define-key company-active-map (kbd key)
      `(menu-item nil company-complete
        :filter ,(lambda (cmd)
                   (when (company-explicit-action-p)
                     cmd)))))
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map (kbd "<tab>") #'company-complete-selection)
  (define-key company-active-map (kbd "TAB") #'company-complete-selection)
  (setq company-auto-complete-chars nil)
  )
