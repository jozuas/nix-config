{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      # Looks
      vim-airline
      vim-airline-themes
      vim-devicons

      # Functionality
      youcompleteme
      vim-polyglot
      ale
      neoformat

      # Language specific
      vim-markdown
      limelight-vim
      goyo
    ];
    extraConfig = ''
      set encoding=utf-8
      set number                "show the number of lines
      set cursorline            "highlight the line where the cursor is located
      set ruler                 "show additional location information at the bottom right corner
      set wildmenu              "visual autocomplete for command menu
      set lazyredraw            "redraw only when we need to.
      set showmatch             "highlight matching [{()}]
      set incsearch             "search as characters are entered
      set hlsearch              "highlight matches
      set ignorecase            "search for both lower and upper case
      set autoread              "update the file if it has been changed externally
      set scrolloff=5           "show extra lines when scrolling
      set autoindent            "automatic indentation

      syntax enable             "enable syntax processing
      filetype indent on        "load filetype-specific indent files

      set tabstop=2
      set expandtab
      set shiftwidth=2
      set textwidth=87          "Ensure you never go over 88 characters a line
      set backspace=2           "change backspace behaviour to normal"

      set clipboard=unnamedplus "Linux

      "" Movement
      nnoremap j gj
      nnoremap k gk

      "" Colourscheme settings
      set background=dark

      hi LineNr           ctermfg=cyan
      hi CursorLineNr     cterm=NONE term=bold ctermfg=white
      hi CursorLine       cterm=NONE ctermbg=8
      hi Search           cterm=NONE ctermfg=black ctermbg=blue
      hi Visual           ctermfg=Black ctermbg=Red
      "  Pmenu is tab completion pop-up
      hi Pmenu            cterm=NONE ctermbg=green ctermfg=black
      hi PmenuSel         cterm=NONE ctermbg=black ctermfg=green
      hi SignColumn       cterm=NONE ctermbg=NONE
      hi MatchParen       ctermbg=NONE ctermfg=Green guibg=NONE guifg=#ff49cb cterm=BOLD gui=BOLD
      "" Syntax
      hi Error ctermfg=Red ctermbg=None

      "" General plugin settings
      let g:airline#extensions#tabline#enabled = 1
      let g:airline_theme='airline_theme'
      let g:airline#extensions#ale#enabled = 1
      let g:airline#extensions#branch#enabled = 1
      let g:airline_powerline_fonts = 1

      let g:ale_lint_on_text_changed = 'normal'
      let g:ale_sign_column_always = 1
      let g:ale_sign_error = '>>'
      let g:ale_sign_warning = '--'

      highlight ALEWarning ctermbg=black
      highlight ALEError ctermbg=black

      let g:ale_linters = {'python': ['flake8', 'bandit', 'pylint']}

      let g:ycm_autoclose_preview_window_after_completion = 1
      let g:ycm_autoclose_preview_window_after_insertion = 1

      "" Markdown environment
      let g:vim_markdown_folding_disabled = 1
      let g:vim_markdown_no_extensions_in_markdown = 1
      let g:vim_markdown_autowrite = 1
      let g:vim_markdown_edit_url_in = 'tab'
      let g:limelight_conceal_ctermfg = 'gray'
      let g:limelight_conceal_guifg = 'DarkGray'
      let g:limelight_priority = -1
      let g:goyo_width = '95%'
      let g:goyo_height = '95%'
      autocmd! User GoyoLeave AirlineToggle AirlineToggle
      autocmd! User GoyoEnter Limelight
      autocmd! User GoyoLeave Limelight!

      "" Autoformatters
      nnoremap FF ggVG:Neoformat<CR>
      let g:shfmt_opt="-ci -i 2"

      "" Per filetype settings
      augroup configgroup
        autocmd!
        autocmd BufEnter *.(sh|nix)    setlocal tabstop=2
        autocmd BufEnter *.(sh|nix)    setlocal shiftwidth=2
        autocmd BufEnter *.(sh|nix)    setlocal softtabstop=2
        autocmd BufEnter *.(sh|nix)    setlocal autoindent
        autocmd BufEnter *.(sh|nix)    setlocal expandtab
        autocmd BufEnter *.java        setlocal textwidth=100
        autocmd BufEnter *.md          setlocal textwidth=80 wrap nonumber
      augroup END

      autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
      autocmd BufEnter,WinEnter * call matchadd("Error", "\\s\\+$", -1)
      autocmd BufRead,BufNewFile * syn match parens /[(){}]/ | hi parens gui=bold ctermfg=red

      "" On leave reset cursor
      autocmd VimLeave * set guicursor=a:ver25
    '';
  };
}
