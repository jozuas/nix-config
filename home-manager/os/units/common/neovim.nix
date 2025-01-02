{ pkgs, ... }:

let
  auto-dark-mode = pkgs.vimUtils.buildVimPlugin {
    name = "auto-dark-mode";
    src = pkgs.fetchFromGitHub {
      owner = "f-person";
      repo = "auto-dark-mode.nvim";
      rev = "d365beccca05ffcb01e50109f2adca2459c3995a";
      hash = "sha256-pZpFZ5GwVxz74CUDA9v970lcH3NNo5Rvg+9L3/87QV8=";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    coc = {
      enable = true;
      settings = {
        languageserver = {
          nix = {
            command = "nixd";
            filetypes = [ "nix" ];
          };
        };
      };
    };

    plugins = with pkgs.vimPlugins; [
      # Looks
      vim-airline
      vim-airline-themes
      vim-devicons
      catppuccin-nvim
      auto-dark-mode

      # Core functionality
      vim-surround
      vim-sneak

      # Functionality
      vim-polyglot
      neoformat

      # Language specific
      vim-markdown
    ];
    extraConfig = ''
      colorscheme catppuccin-macchiato

      lua << EOF
      local auto_dark_mode = require('auto-dark-mode')

      auto_dark_mode.setup({
        update_interval = 1000,
        set_dark_mode = function()
          vim.api.nvim_set_option_value('background', 'dark', {})
          vim.cmd('colorscheme catppuccin-macchiato')
        end,
        set_light_mode = function()
          vim.api.nvim_set_option_value('background', 'light', {})
          vim.cmd('colorscheme catppuccin-latte')
        end,
      })
      EOF

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
      set nofoldenable           "disable folding

      syntax enable              "enable syntax processing
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
      let g:airline_powerline_fonts = 1
      let g:airline_theme = 'catppuccin'

      "" Markdown environment
      let g:vim_markdown_strikethrough = 1
      let g:vim_markdown_folding_disabled = 1
      let g:vim_markdown_no_extensions_in_markdown = 1
      let g:vim_markdown_autowrite = 1
      let g:vim_markdown_new_list_item_indent = 2
      let g:vim_markdown_edit_url_in = 'tab'

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
    '';
  };
}
