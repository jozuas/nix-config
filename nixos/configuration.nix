# Core System-wide configuration.
# Machine and desktop specific settings are pointed by current.nix symlinks.

{ pkgs, ... }:

{
  imports =
    [
      ./state-version.nix
      ./hardware-configuration.nix
      ./machine/current.nix
      ./desktop/current.nix
    ];

  boot = {
    kernel.sysctl = {
      "vm.swappiness" = 1;
    };

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };

      timeout = 3;
      efi.canTouchEfiVariables = true;
    };

    cleanTmpDir = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    hostName = "nixos";
    tcpcrypt.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [8000];
      allowedUDPPorts = [];
    };

    hosts = {
      "3.11.69.118" = [ "vpn.researchspace.com" ];
      "192.168.1.42" = [ "pi" ];
    };
  };

  # Localisation
  time.timeZone = "Europe/Vilnius";
  location.provider = "geoclue2";
  i18n.defaultLocale = "en_GB.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  fonts = {
    fonts = with pkgs; [
      dejavu_fonts
      ubuntu_font_family
      corefonts
      nerdfonts
    ];
    fontconfig = {
     defaultFonts = {
       emoji = [ "Noto Color Emoji" ];
       monospace = [ "DejaVu Sans Mono" ];
       sansSerif = [ "DejaVu Sans" ];
       serif = [ "DejaVu Serif" ];
     };
    };
  };

  hardware = {
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-ocl
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };


    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
      daemon.config = {
        default-sample-format = "float32le";
        default-sample-rate = "48000";
        alternate-sample-rate = "44100";
        default-sample-channels = "2";
        default-channel-map = "front-left,front-right";
        default-fragments = "2";
        default-fragment-size-msec = "125";
        resample-method = "soxr-vhq";
        enable-lfe-remixing = "no";
        high-priority = "yes";
        nice-level = "-11";
        realtime-scheduling = "yes";
        realtime-priority = "9";
        rlimit-rtprio = "9";
        daemonize = "no";
      };
    };
  };

  sound.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.autoOptimiseStore = true;

  environment = {
    systemPackages = with pkgs; [
      neovim
      inotify-tools
      killall
      file
      traceroute
      htop
      openvpn
      zip
      unzip
      binutils
      whois
      curl
    ];
    shellAliases = {
      ls = "ls -h --color=auto";
      grep = "grep --color=auto";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";
      vim = "nvim";
      vi = "nvim";
    };
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  programs = {
    zsh = {
      enable = true;
      autosuggestions = {
        enable = true;
        extraConfig = {
          "ZSH_AUTOSUGGEST_USE_ASYNC" = "true";
        };
      };
      syntaxHighlighting = {
        enable = true;
        highlighters = [ "main" "brackets" "pattern" "cursor" "line" ];
      };
      vteIntegration = true;
      shellInit = ''
        bindkey -e
      '';
    };
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
  };

  services = {
    xserver = {
      # Support for most mice and keyboards
      libinput.enable = true;

      # Enable the X11 windowing system.
      enable = true;
      layout = "gb,ru";
      xkbVariant = ",phonetic_winkeys";

      xkbOptions = "caps:escape,grp:switch,grp:alt_space_toggle";
    };
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.juozas = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "wireshark"
      "networkmanager"
      "docker"
      "video"
      "vboxusers"
    ];
    home = "/home/juozas";
  };

  virtualisation.docker.enable = true;

  system.autoUpgrade.enable = true;
}
