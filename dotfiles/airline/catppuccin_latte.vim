" Catppuccin Latte theme for vim-airline

let s:base      = ['#eff1f5', 255]
let s:mantle    = ['#e6e9ef', 254]
let s:crust     = ['#dce0e8', 253]
let s:surface0  = ['#ccd0da', 252]
let s:surface1  = ['#bcc0cc', 250]
let s:overlay0  = ['#9ca0b0', 247]
let s:subtext0  = ['#6c6f85', 242]
let s:text      = ['#4c4f69', 59]
let s:blue      = ['#1e66f5', 33]
let s:green     = ['#40a02b', 64]
let s:yellow    = ['#df8e1d', 172]
let s:peach     = ['#fe640b', 208]
let s:red       = ['#d20f39', 160]
let s:mauve     = ['#8839ef', 93]
let s:teal      = ['#179299', 30]

function! s:Pair(fg, bg) abort
  return [a:fg[0], a:bg[0], a:fg[1], a:bg[1], '']
endfunction

let g:airline#themes#catppuccin_latte#palette = {}
let s:palette = g:airline#themes#catppuccin_latte#palette

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
      \ 'red': ['#d20f39', '', 160, ''],
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
let g:airline#themes#catppuccin_latte#palette.tabline = {
      \ 'airline_tab':     s:Pair(s:text, s:surface0),
      \ 'airline_tabsel':  s:Pair(s:crust, s:blue),
      \ 'airline_tabtype': s:Pair(s:crust, s:mauve),
      \ 'airline_tabfill': s:Pair(s:subtext0, s:mantle),
      \ 'airline_tabmod':  s:Pair(s:crust, s:yellow),
      \ 'airline_tabhid':  s:Pair(s:overlay0, s:mantle),
      \ }
