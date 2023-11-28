;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! groovy-mode)
(package! rfc-mode)

;; I need ~H sigil support, need to run doom sync -u for this to take into effect
(package! elixir-mode :pin "00d6580a040a750e019218f9392cf9a4c2dac23a")
