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

      # Core functionality
      vim-surround
      vim-sneak

      # Functionality
      YouCompleteMe
      vim-polyglot
      ale
      neoformat

      # Language specific
      vim-markdown
    ];
    extraConfig = ''
      set encoding=utf-8
      set number relativenumber  "show the number of lines
      set cursorline             "highlight the line where the cursor is located
      set ruler                  "show additional location information at the bottom right corner
      set wildmenu               "visual autocomplete for command menu
      set lazyredraw             "redraw only when we need to.
      set showmatch              "highlight matching [{()}]
      set incsearch              "search as characters are entered
      set hlsearch               "highlight matches
      set ignorecase             "search for both lower and upper case
      set autoread               "update the file if it has been changed externally
      set scrolloff=5            "show extra lines when scrolling
      set autoindent             "automatic indentation

      syntax enable              "enable syntax processing
      colorscheme vim_theme      "my custom colorscheme
      filetype indent on         "load filetype-specific indent files

      set tabstop=2
      set expandtab
      set shiftwidth=2
      set textwidth=87           "Ensure you never go over 88 characters a line
      set backspace=2            "change backspace behaviour to normal"

      set conceallevel=2         "Conceals formatting, in e.g. Markdown

      set clipboard=unnamedplus  "Linux

      "" Movement
      nnoremap j gj
      nnoremap k gk

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

      let g:ale_linters = {'markdown': [], 'python': ['flake8', 'bandit']}

      let g:ycm_autoclose_preview_window_after_completion = 1
      let g:ycm_autoclose_preview_window_after_insertion = 1

      "" Markdown environment
      let g:vim_markdown_strikethrough = 1
      let g:vim_markdown_folding_disabled = 1
      let g:vim_markdown_no_extensions_in_markdown = 1
      let g:vim_markdown_autowrite = 1
      let g:vim_markdown_new_list_item_indent = 2
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
        autocmd BufEnter *.md          setlocal textwidth=80 wrap
      augroup END

      autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
      autocmd BufEnter,WinEnter * call matchadd("Error", "\\s\\+$", -1)
      autocmd BufRead,BufNewFile * syn match parens /[(){}]/ | hi parens gui=bold ctermfg=red

      "" On leave reset cursor
      autocmd VimLeave * set guicursor=a:ver25
    '';
  };
}
