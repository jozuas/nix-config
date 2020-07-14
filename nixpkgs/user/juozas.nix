{ config, lib, pkgs, ... }:

let
  background = "0x15161d";
  foreground = "0xfdfdfd";

  black = "0x15161d";
  red = "0xff4971";
  green = "0x89ff49";
  yellow = "0xfffc3d";
  blue = "0x49b0ff";
  magenta = "0xff49cb";
  cyan = "0x18e3c8";
  white = "0xaeb7f5";

  brightBlack = "0x4b4f69";
  brightRed = "0xff4971";
  brightGreen = "0x89ff49";
  brightYellow = "0xfffc3d";
  brightBlue = "0x49b0ff";
  brightMagenta = "0xff49cb";
  brightCyan = "0x18e3c8";
  brightWhite = "0xfdfdfd";
in {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  home.packages = with pkgs; [
    gnome3.cheese  # TODO

    nerdfonts

    # TODO: i3wm specific
    polybarFull
    xss-lock
    lightlocker
    networkmanagerapplet
    redshift
    unclutter
    copyq
    arandr
    feh
    copyq
    playerctl
    pavucontrol

    # CLI Tools
    ranger
    neofetch
    htop
    tldr
    maim
    jq

    # Networking
    traceroute
    nmap
    whois
    speedtest-cli
    curl

    # Dev
    jetbrains.idea-ultimate
    vscodium

    # RSpace TODO: lorri
    jdk11
    maven
    liquibase
    geckodriver

    # Extra Browsers
    chromium
    tor-browser-bundle-bin

    # Social
    tdesktop
    skypeforlinux
    discord
    zoom-us
    teamviewer
    spotify

    # GUI Utilities
    zathura
    notable
    bitwarden
    android-file-transfer

    # CLI Utilities
    xorg.xev
    xorg.xrandr
    xorg.xmodmap
    zip
    unzip
    xclip
    nix-prefetch-git
    python38
    python38Packages.bpython

    # TODO: Should be desktop specific
    xcalib
    kdeFrameworks.kirigami2
  ];

  programs = {
    direnv.enable = true;
    alacritty = {
      enable = true;
      settings = {
        window = {
          padding = {
            x = 4;
            y = 5;
          };
          title = "Terminal";
        };
        font = {
          family = "DejaVuSansMono Nerd";
          style = "Book";
          bold_style = "Bold";
          italic_style = "Italic";
          offset = {
            x = 0;
            y = 0;
          };
        };
        colors = {
          primary = {
            background = background;
            foreground = foreground;
          };
          normal = {
            black = black;
            red = red;
            green = green;
            yellow = yellow;
            blue = blue;
            magenta = magenta;
            cyan = cyan;
            white = white;
          };
          bright = {
            black = brightBlack;
            red = brightRed;
            green = brightGreen;
            yellow = brightYellow;
            blue = brightBlue;
            magenta = brightMagenta;
            cyan = brightCyan;
            white = brightWhite;
          };
        };
        visual_bell = {
          animation = "EaseOutExpo";
          color = "0xffffff";
          duration = 0;
        };
        cursor = {
          style = "Beam";
          unfocused_hollow = true;
        };
        selection.semantic_escape_chars = ",│`|:\"' ()[]{}<>";
        background_opacity = 1.0;
        scrolling.history = 10000;
        live_config_reload = true;
        mouse.url.launcher = "xdg-open";
        draw_bold_text_with_bright_colors = true;
      };
    };
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-airline
        youcompleteme
        vim-polyglot
        ale
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
        set shiftwidth=2
        set textwidth=87          "Ensure you never go over 88 characters a line
        set backspace=2           "change backspace behaviour to normal"

        set clipboard=unnamedplus "Linux

        "" Movement
        nnoremap j gj
        nnoremap k gk

        "" Colourscheme settings
        set background=dark
        "colorscheme hybrid
        "let g:hybrid_custom_term_colors = 1

        hi LineNr           ctermfg=GreeN
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

        "" Plugin settings
        let g:airline#extensions#tabline#enabled = 1
        let g:airline_theme='angr'
        let g:airline#extensions#ale#enabled = 1
        let g:airline#extensions#branch#enabled = 1
        "let g:airline_powerline_fonts = 1

        let g:ale_lint_on_text_changed = 'normal'
        let g:ale_sign_column_always = 1
        let g:ale_sign_error = '>>'
        let g:ale_sign_warning = '--'
        let g:ale_python_auto_pipenv = 1

        highlight ALEWarning ctermbg=black
        highlight ALEError ctermbg=black

        let g:ycm_autoclose_preview_window_after_completion = 1
        let g:ycm_autoclose_preview_window_after_insertion = 1

        "" Per filetype settings
        augroup configgroup
          autocmd!
          autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
          autocmd BufEnter *.(sh|nix)    setlocal tabstop=2
          autocmd BufEnter *.(sh|nix)    setlocal shiftwidth=2
          autocmd BufEnter *.(sh|nix)    setlocal softtabstop=2
          autocmd BufEnter *.(sh|nix)    setlocal autoindent
          autocmd BufEnter *.(sh|nix)    setlocal expandtab
          autocmd BufEnter *.java        setlocal textwidth=100
          autocmd BufEnter,WinEnter * call matchadd("Error", "\\s\\+$", -1)
          autocmd BufRead,BufNewFile * syn match parens /[(){}]/ | hi parens gui=bold ctermfg=red
        augroup END
      '';
    };
    zsh = {
      enable = true;
      defaultKeymap = "emacs";
      shellAliases = {
        cd = ">/dev/null cd";
        gg = "git ack";
        ggn = "git ack --no-index";
      };
      sessionVariables = {
        BROWSER = "firefox-devedition";
        TERMINAL = "alacritty";
        DIRENV_LOG_FORMAT= "";
        CDPATH = ".:~:~/dev:~/documents";  # TODO: doesn't work
      };
      initExtra = ''
        function ranger-cd {
          tempfile=$(mktemp -t tmp.XXXXXX)
          /home/juozas/.nix-profile/bin/ranger --choosedir="$tempfile" "$(pwd)"
          test -f "$tempfile" &&
          if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
              cd -- "$(cat "$tempfile")"
          fi
          rm -f -- "$tempfile"
        }
        bindkey -s "^O" "ranger-cd\n"

        eval "$(direnv hook zsh)"
      '';
    };
    tmux = {
      enable = true;
      shortcut = "SPACE";
      terminal = "screen-256color";
      keyMode = "vi";
      customPaneNavigationAndResize = true;
      disableConfirmationPrompt = true;
      newSession = true;
      aggressiveResize = true;
      plugins = with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      } ];
      extraConfig = ''
        # Functionality
        bind | split-window -h
        bind - split-window -v
        bind r source-file ~/.tmux.conf \; display "Reloaded!"
        set -g mouse on
        set-window-option -g automatic-rename off
        set-option -g allow-rename off
        setw -g monitor-activity on
        set -g visual-activity on
        set -g base-index 1
        setw -g pane-base-index 1

        # VI-like tmux selection
        set-window-option -g mode-keys vi
        bind Escape copy-mode-vi
        unbind p
        bind p paste-buffer
        unbind-key -T copy-mode-vi v
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle \; send -X begin-selection
        bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -in -selection clipboard"

        # Styling
        setw -g window-status-current-style fg=black,bg=red
        setw -g window-status-activity-style fg=cyan,bg=black
        set -g status-style fg=black,bg=cyan
        set -g message-style fg=black,bg=red
        set-window-option -g window-status-current-format '#I:#W'
        set-window-option -g window-status-format '#I:#W'
      '';
    };
    irssi = {
      enable = true;
      networks = {
        freenode = {
          nick = "jnorkus";
          server = {
            address = "chat.freenode.net";
            port = 6697;
            autoConnect = true;
          };
          channels = {
            nixos.autoJoin = true;
            xmonad.autoJoin = true;
          };
        };
      };
      extraConfig = ''
        ignores = ({ level = "JOINS PARTS QUITS NICKS"; });
        keyboard = (
          { key = "meta-j"; id = "scroll_forward"; }
          { key = "meta-k"; id = "scroll_backward"; }
        );
        windows = {
          1 = { immortal = "yes"; name = "(status)"; level = "ALL"; };
          2 = {
            items = (
              {
                type = "CHANNEL";
                chat_type = "IRC";
                name = "#nixos";
                tag = "freenode";
              }
            );
          };
          3 = {
            items = (
              {
                type = "CHANNEL";
                chat_type = "IRC";
                name = "#haskell-beginners";
                tag = "freenode";
              }
            );
          };
          4 = {
            items = (
              {
                type = "CHANNEL";
                chat_type = "IRC";
                name = "#xmonad";
                tag = "freenode";
              }
            );
          };
        };
      '';
    };
    firefox = {
      enable = true;
      package = pkgs.firefox-devedition-bin;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        decentraleyes
        vimium
        bitwarden
        facebook-container
        react-devtools
      ];
    };
    git = {
      enable = true;
      userEmail = "norkus@norkus.net";
      userName = "Juozas Norkus";
      signing.key = "6D11AC468819E2EA41232CB52FE519DA622AF155";
      signing.signByDefault = true;
      aliases = {
        "ack" = "-c color.grep.linenumber=\"bold yellow\" \
                 -c color.grep.filename=\"bold green\" \
                 -c color.grep.match=\"reverse yellow\" \
                 grep --break --heading --line-number";
      };
      ignores = [ "*.swp" ];
      extraConfig = {
        core = {
          editor = "nvim";
          pager = "less -x1,3";
        };
        grep = {
          lineNumber = true;
          extendRegexp = true;
        };
        merge = {
          tool = "vimdiff";
        };
        mergetool = {
          prompt = false;
        };
        "mergetool \"vimdiff\"" = {
          cmd = "nvim -d $BASE $LOCAL $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";
          keepBackup = false;
          trustExitCode = false;
        };
      };
    };
    rofi = {
      enable = true;
      fullscreen = true;
      font = "DejaVu Sans Mono Book 14";
      terminal = "~/.nix-profile/bin/alacritty";
      theme = "~/.nix-config/dotfiles/rofi-theme.rasi";
    };
    gpg.enable = true;
  };

  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };
    lorri.enable = true;
  };

  xdg.userDirs = {
    download = "\$HOME/downloads";
    documents = "\$HOME/documents";
    pictures = "\$HOME/pictures";
    videos = "\$HOME/videos";
    music = "\$HOME/music";
  };

  # TODO: sync-up with let-in at the start of the file
  xresources.properties = {
    "*.foreground" = "#fdfdfd";
    "*.background" = "#15161d";
    "*.cursorColor" = "#fdfdfd";
    "*.color0" = "#15161d";
    "*.color8" = "#1b1c24";
    "*.color1" = "#ff4971";
    "*.color9" = "#ff4971";
    "*.color2" = "#18e3c8";
    "*.color10" = "#18e3c8";
    "*.color3" = "#89ff49";
    "*.color11" = "#89ff49";
    "*.color4" = "#49b0ff";
    "*.color12" = "#49b0ff";
    "*.color5" = "#ff49cb";
    "*.color13" = "#ff49cb";
    "*.color6" = "#3fecee";
    "*.color14" = "#3fecee";
    "*.color7" = "#bebec1";
    "*.color15" = "#fdfdfd";
  };
}
