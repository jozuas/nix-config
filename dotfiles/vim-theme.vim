set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "vim_theme"

hi Comment      ctermfg=8
hi Ignore       ctermfg=8
hi Boolean      ctermfg=red
hi Number       ctermfg=red
hi Float        ctermfg=red
hi Character    ctermfg=magenta
hi String       ctermfg=magenta

hi ErrorMsg     ctermbg=black ctermfg=red
hi WarningMsg   ctermbg=black ctermfg=yellow
hi Error        ctermbg=black ctermfg=red
hi Todo         ctermfg=black ctermbg=yellow

hi CursorLine   cterm=NONE
hi CursorLineNr cterm=bold ctermfg=white
hi MatchParen   cterm=BOLD ctermfg=green ctermbg=black
hi Search       cterm=bold ctermfg=black ctermbg=yellow

hi LineNr       ctermfg=8
hi clear Visual
hi Visual       ctermfg=Black ctermbg=Red
hi SignColumn   ctermbg=NONE

"  Pmenu is tab completion pop-up
hi Pmenu        ctermbg=cyan ctermfg=black
hi PmenuSel     ctermbg=black ctermfg=cyan
