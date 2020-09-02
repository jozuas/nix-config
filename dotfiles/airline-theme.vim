" Color palette

let s:gui_dark_gray = '#283e33'
let s:cterm_dark_gray = 0
let s:gui_med_gray_hi = '#444444'
let s:cterm_med_gray_hi = 0
let s:gui_med_gray_lo = '#3a3a3a'
let s:cterm_med_gray_lo = 0
let s:gui_light_gray = '#b2b2b2'
let s:cterm_light_gray = 7

let s:gui_black = '#15161d'
let s:cterm_black = 'Black'
let s:gui_red = '#ff4971'
let s:cterm_red = 'Red'
let s:gui_green = '#89ff49'
let s:cterm_green = 'Green'
let s:gui_yellow = '#fffc3d'
let s:cterm_yellow = 'Yellow'
let s:gui_blue = '#49b0ff'
let s:cterm_blue = 'Blue'
let s:gui_magenta = '#ff49cb'
let s:cterm_magenta = 'Magenta'
let s:gui_cyan = '#18e3c8'
let s:cterm_cyan = 'Cyan'
let s:gui_white = '#fdfdfd'
let s:cterm_white = 'White'

let g:airline#themes#airline_theme#palette = {}

" Normal mode
let s:N1 = [s:gui_black, s:gui_cyan, s:cterm_black, s:cterm_cyan]
let s:N2 = [s:gui_white, s:gui_black, s:cterm_white, s:cterm_black]
let s:N3 = [s:gui_white, s:gui_black, s:cterm_white, s:cterm_black]
let g:airline#themes#airline_theme#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#airline_theme#palette.normal_modified = {
      \ 'airline_c': [s:gui_white, s:gui_black, s:cterm_white, s:cterm_black, ''],
      \ }

" Insert mode
let s:I1 = [s:gui_black, s:gui_blue, s:cterm_black, s:cterm_blue]
let s:I3 = [s:gui_white, s:gui_black, s:cterm_white, s:cterm_black]
let g:airline#themes#airline_theme#palette.insert = airline#themes#generate_color_map(s:I1, s:N2, s:I3)
let g:airline#themes#airline_theme#palette.insert_modified = copy(g:airline#themes#airline_theme#palette.normal_modified)
let g:airline#themes#airline_theme#palette.insert_paste = {
      \ 'airline_a': [s:gui_black, s:gui_yellow, s:cterm_black, s:cterm_yellow, ''],
      \ }

" Replace mode
let g:airline#themes#airline_theme#palette.replace = {
      \ 'airline_a': [s:gui_black, s:gui_yellow, s:cterm_black, s:cterm_yellow, ''],
      \ 'airline_c': [s:gui_yellow, s:gui_black, s:cterm_yellow, s:cterm_black, ''],
      \ }
let g:airline#themes#airline_theme#palette.replace_modified = copy(g:airline#themes#airline_theme#palette.insert_modified)

" Visual mode
let s:V1 = [s:gui_black, s:gui_red, s:cterm_black, s:cterm_red]
let s:V3 = [s:gui_white, s:gui_black, s:cterm_white, s:cterm_black]
let g:airline#themes#airline_theme#palette.visual = airline#themes#generate_color_map(s:V1, s:N2, s:V3)
let g:airline#themes#airline_theme#palette.visual_modified = copy(g:airline#themes#airline_theme#palette.insert_modified)

" Inactive window
let s:IA = [s:gui_white, s:gui_black, s:cterm_white, s:cterm_black, '']
let g:airline#themes#airline_theme#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
let g:airline#themes#airline_theme#palette.inactive_modified = {
      \ 'airline_c': [s:gui_white, '', s:cterm_white, '', ''],
      \ }

" Warnings
let g:airline#themes#airline_theme#palette.normal.airline_warning = [
 \ s:gui_black, s:gui_red, s:cterm_black, s:cterm_red
 \ ]
let g:airline#themes#airline_theme#palette.normal_modified.airline_warning =
\ g:airline#themes#airline_theme#palette.normal.airline_warning
let g:airline#themes#airline_theme#palette.insert.airline_warning =
\ g:airline#themes#airline_theme#palette.normal.airline_warning
let g:airline#themes#airline_theme#palette.insert_modified.airline_warning =
\ g:airline#themes#airline_theme#palette.normal.airline_warning
let g:airline#themes#airline_theme#palette.visual.airline_warning =
\ g:airline#themes#airline_theme#palette.normal.airline_warning
let g:airline#themes#airline_theme#palette.visual_modified.airline_warning =
\ g:airline#themes#airline_theme#palette.normal.airline_warning
let g:airline#themes#airline_theme#palette.replace.airline_warning =
\ g:airline#themes#airline_theme#palette.normal.airline_warning
let g:airline#themes#airline_theme#palette.replace_modified.airline_warning =
\ g:airline#themes#airline_theme#palette.normal.airline_warning

" Errors
let g:airline#themes#airline_theme#palette.normal.airline_error = [
 \ s:gui_black, s:gui_red, s:cterm_black, s:cterm_red
 \ ]
let g:airline#themes#airline_theme#palette.normal_modified.airline_error =
\ g:airline#themes#airline_theme#palette.normal.airline_error
let g:airline#themes#airline_theme#palette.insert.airline_error =
\ g:airline#themes#airline_theme#palette.normal.airline_error
let g:airline#themes#airline_theme#palette.insert_modified.airline_error =
\ g:airline#themes#airline_theme#palette.normal.airline_error
let g:airline#themes#airline_theme#palette.visual.airline_error =
\ g:airline#themes#airline_theme#palette.normal.airline_error
let g:airline#themes#airline_theme#palette.visual_modified.airline_error =
\ g:airline#themes#airline_theme#palette.normal.airline_error
let g:airline#themes#airline_theme#palette.replace.airline_error =
\ g:airline#themes#airline_theme#palette.normal.airline_error
let g:airline#themes#airline_theme#palette.replace_modified.airline_error =
\ g:airline#themes#airline_theme#palette.normal.airline_error
