;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they load
;; in. Remember to run 'doom sync' after modifying it!

;; NOTE Press 'SPC h d h' (or 'C-h d h' for non-vim users) to access Doom's
;;      documentation. There you'll find a "Module Index" link where you'll find
;;      a comprehensive list of Doom's modules and what flags they support.

;; NOTE Move your cursor over a module's name (or its flags) and press 'K' (or
;;      'C-c c k' for non-vim users) to view its documentation. This works on
;;      flags as well (those symbols that start with a plus).
;;
;;      Alternatively, press 'gd' (or 'C-c c d') on a module to browse its
;;      directory (for easy access to its source code).

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
       (format +onsave)

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
       emacs-lisp
       nix
       markdown
       (erlang +lsp)
       (python +lsp +poetry)

       :config
       (default +bindings +smartparens))
