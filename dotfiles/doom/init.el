;;; init.el -*- lexical-binding: t; -*-

(doom! :input
       :completion
       company            ;; Autocomplete
       vertico            ;; Search and completion engine

       :ui
       doom               ;; Doom Emacs Themes
       doom-dashboard     ;; Doom startup screen
       doom-quit          ;; Quit confirmation
       modeline
       hl-todo
       nav-flash          ;; Flash cursor after significant motion
       ophints            ;; Visual feedback on operations, e.g. yank
       (popup +defaults)  ;; Make new temp buffers significantly less intrusive
       vc-gutter          ;; Show VC changes next to line numbers
       window-select      ;; Switch to window by letter
       workspaces         ;; Isolated buffer groups
       (treemacs +lsp)    ;; Project structure view

       :editor
       (evil +everywhere) ;; Vim mode
       format             ;; Enable code formatting via LSP

       :emacs
       (dired +ranger +icons)  ;; Like Ranger, but for Emacs
       undo                    ;; Smarted undo history
       vc                      ;; Git conveniences

       :term
       vterm              ;; More performant terminal emulator

       :os
       (:if IS-MAC macos)
       tty

       :checkers
       syntax
       (spell +flyspell +everywhere)

       :tools
       direnv
       lookup
       lsp
       (magit +forge)
       make
       rgb

       :lang
       rest
       yaml
       json
       emacs-lisp
       nix
       markdown
       web
       (zig +lsp)
       (javascript +lsp)
       (erlang +lsp)
       (elixir +lsp)
       (cc +lsp)
       (python +lsp +pyright)

       :config
       (default +bindings +smartparens))
