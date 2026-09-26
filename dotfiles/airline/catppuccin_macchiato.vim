" Catppuccin Macchiato theme for vim-airline

let s:base      = ['#24273a', 236]
let s:mantle    = ['#1e2030', 235]
let s:crust     = ['#181926', 234]
let s:surface0  = ['#363a4f', 238]
let s:surface1  = ['#494d64', 239]
let s:overlay0  = ['#6e738d', 60]
let s:subtext0  = ['#a5adcb', 146]
let s:text      = ['#cad3f5', 189]
let s:blue      = ['#8aadf4', 111]
let s:green     = ['#a6da95', 150]
let s:yellow    = ['#eed49f', 223]
let s:peach     = ['#f5a97f', 216]
let s:red       = ['#ed8796', 210]
let s:mauve     = ['#c6a0f6', 183]
let s:teal      = ['#8bd5ca', 116]

function! s:Pair(fg, bg) abort
  return [a:fg[0], a:bg[0], a:fg[1], a:bg[1], '']
endfunction

let g:airline#themes#catppuccin_macchiato#palette = {}
let s:palette = g:airline#themes#catppuccin_macchiato#palette

" Section B/C are shared by every mode
let s:B = s:Pair(s:text, s:surface0)
let s:C = s:Pair(s:subtext0, s:mantle)

let s:palette.normal  = airline#themes#generate_color_map(s:Pair(s:crust, s:blue), s:B, s:C)
let s:palette.insert  = airline#themes#generate_color_map(s:Pair(s:crust, s:green), s:B, s:C)
let s:palette.replace = airline#themes#generate_color_map(s:Pair(s:crust, s:red), s:B, s:C)
let s:palette.visual  = airline#themes#generate_color_map(s:Pair(s:crust, s:mauve), s:B, s:C)
let s:palette.terminal = airline#themes#generate_color_map(s:Pair(s:crust, s:teal), s:B, s:C)
let s:palette.commandline = airline#themes#generate_color_map(s:Pair(s:crust, s:peach), s:B, s:C)

let s:palette.inactive = airline#themes#generate_color_map(
      \ s:Pair(s:overlay0, s:mantle), s:Pair(s:overlay0, s:mantle), s:Pair(s:overlay0, s:mantle))

" Modified buffers tint section C yellow
let s:modified = { 'airline_c': s:Pair(s:yellow, s:mantle) }
for s:mode in ['normal', 'insert', 'replace', 'visual', 'terminal', 'commandline', 'inactive']
  let s:palette[s:mode . '_modified'] = copy(s:modified)
endfor
unlet s:mode

let s:palette.insert_paste = { 'airline_a': s:Pair(s:crust, s:teal) }

" Accents
let s:palette.accents = {
      \ 'red': ['#ed8796', '', 210, ''],
      \ }

" Warnings / errors
let s:warning = s:Pair(s:crust, s:yellow)
let s:error   = s:Pair(s:crust, s:red)
for s:mode in ['normal', 'insert', 'replace', 'visual', 'terminal', 'commandline']
  let s:palette[s:mode].airline_warning = s:warning
  let s:palette[s:mode].airline_error = s:error
  let s:palette[s:mode . '_modified'].airline_warning = s:warning
  let s:palette[s:mode . '_modified'].airline_error = s:error
endfor
unlet s:mode

" Tabline
let g:airline#themes#catppuccin_macchiato#palette.tabline = {
      \ 'airline_tab':     s:Pair(s:text, s:surface0),
      \ 'airline_tabsel':  s:Pair(s:crust, s:blue),
      \ 'airline_tabtype': s:Pair(s:crust, s:mauve),
      \ 'airline_tabfill': s:Pair(s:subtext0, s:mantle),
      \ 'airline_tabmod':  s:Pair(s:crust, s:yellow),
      \ 'airline_tabhid':  s:Pair(s:overlay0, s:mantle),
      \ }
