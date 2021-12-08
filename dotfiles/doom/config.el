;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Juozas Norkus")

(if (eq system-type 'darwin)
    (setq user-mail-address "jnorkus@evolution.com")
  (setq user-mail-address "norkus@norkus.net"))

(setq doom-theme 'doom-vibrant)
(setq display-line-numbers-type 'relative)
(setq doom-font (font-spec
                 :family "Hack Nerd Font Mono"
                 :size (if (eq system-type 'darwin) 13 16)
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

(define-key flyspell-mode-map (kbd "C-;") 'flyspell-correct-wrapper)

;; TODO: does not work properly, need to follow
;; https://magit.vc/manual/ghub/Getting-Started.html for user and token setup
;; Configure Forge repositories
;; (add-to-list
;;  'forge-alist
;;  '("gitlab.evolution.com"
;;    "gitlab.evolution.com/api/v4"
;;    "gitlab.evolution.com"
;;    forge-gitlab-repository))

;; Config for all LSPs
(setq lsp-ui-doc-enable nil)  ;; Do not show documentation popups

;; Erlang
(map! :leader
      (:prefix ("e" . "erlang")
       :desc "Jump back within func"
       "b" #'erlang-beginning-of-function))
(map! :leader
      (:prefix ("e" . "erlang")
       :desc "Jump forward within func"
       "f" #'erlang-end-of-function))
(map! :leader
      (:prefix ("e" . "erlang")
       :desc "Manual for under cursor"
       "s" #'erlang-man-function-no-prompt))
(map! :leader
      (:prefix ("e" . "erlang")
       :desc "Manual for module"
       "m" #'erlang-man-module))

;; Python
(add-hook 'before-save-hook 'py-isort-before-save)
(setq lsp-pyright-typechecking-mode "strict")

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
