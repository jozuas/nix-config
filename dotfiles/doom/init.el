;;; init.el -*- lexical-binding: t; -*-

(doom! :input
       :completion
       company
       vertico

       :ui
       doom
       doom-dashboard
       doom-quit
       modeline
       (emoji +ascii +github +unicode)
       hl-todo
       indent-guides
       nav-flash
       treemacs
       ophints
       (popup +defaults)
       tabs
       vc-gutter
       vi-tilde-fringe
       window-select
       workspaces

       :editor
       (evil +everywhere)
       fold
       format  ;; +onsave provides an exceptionally bad experience as of 14/08/2021

       :emacs
       (dired +ranger +icons)
       electric
       undo
       vc

       :term
       vterm

       :checkers
       syntax
       (spell +flyspell +everywhere)

       :tools
       direnv
       (eval +overlay)
       lookup
       lsp
       magit
       make
       rgb

       :os
       (:if IS-MAC macos)
       tty

       :lang
       rest
       web
       yaml
       emacs-lisp
       nix
       markdown
       (haskell +lsp)
       (erlang +lsp)
       (elixir +lsp)
       (python +lsp +pyright +poetry)
       (json +lsp)

       :config
       (default +bindings +smartparens))
