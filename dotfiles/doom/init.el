;;; init.el -*- lexical-binding: t; -*-

(doom! :input
       :completion
       company            ;; Autocomplete
       vertico            ;; Jump/Search project, file, directory, ...

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

       ;; Slow, but sexy, lets see if I can live without
       ;; tabs             
       ;; indent-guides

       :editor
       (evil +everywhere)      ;; Vim mode
       format                  ;; Enable code formatting via LSP

       :emacs
       (dired +ranger +icons)  ;; Like Ranger, but for Emacs
       electric                ;; TODO: what on Earth does this do?
       undo                    ;; Smarted undo history
       vc                      ;; Git conveniences

       :term
       vterm                   ;; More performant terminal emulator

       :os
       (:if IS-MAC macos)
       tty

       :checkers
       syntax
       (spell +flyspell +everywhere)
       ;; Todo consider - grammar

       :tools
       direnv
       (eval +overlay)
       lookup
       lsp
       magit
       make
       rgb

       :lang
       rest
       web
       yaml
       emacs-lisp
       nix
       markdown
       (erlang +lsp)
       (elixir +lsp)
       (python +lsp +pyright +poetry)
       (json +lsp)

       :config
       (default +bindings +smartparens))
