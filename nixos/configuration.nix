# Core System-wide configuration.

{ pkgs, ... }:

let home = "/home/juozas";
in {
  imports = [
    ./cachix.nix
    ./state-version.nix
    ./hardware-configuration.nix
    ./machine/t480s.nix
    ./desktop/i3.nix

    <home-manager/nixos>
  ];

  boot = {
    kernel.sysctl = {
      "vm.swappiness" = 1;
      "net.core.default_qdisc" = "cake";
      "net.ipv4.tcp_congestion_control" = "bbr";
    };

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };

      timeout = 3;
      efi.canTouchEfiVariables = true;
    };

    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    hostName = "nixos";

    firewall = {
      enable = true;
      allowedTCPPorts = [ 2200 ];
      allowedUDPPorts = [ 51820 ];
    };
  };

  # Localisation
  time.timeZone = "Europe/Lisbon";
  location.provider = "geoclue2";
  i18n.defaultLocale = "en_GB.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  fonts = {
    packages = with pkgs; [ dejavu_fonts ubuntu_font_family corefonts nerdfonts ];
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
        #vaapiIntel broken right now
        vaapiVdpau
        libvdpau-va-gl
      ];
    };

    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
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

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

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
      nix-index
    ];
  };

  programs = {
    zsh = { enable = true; };
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
  };

  services = {
    # Support for most mice and keyboards
    libinput.enable = true;

    xserver = {

      # Enable the X11 windowing system.
      enable = true;

      xkb = {
        layout = "gb";
        options = "compose:ralt,caps:escape,grp:switch,grp:alt_space_toggle";
      };
    };

    openssh = {
      enable = true;
      ports = [ 2200 ];
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };

  system.autoUpgrade.enable = true;

  users.defaultUserShell = pkgs.zsh;
  users.users.juozas = {
    isNormalUser = true;
    extraGroups = [ "wheel" "wireshark" "networkmanager" "video" "vboxusers" ];
    home = home;
  };

  # Setup home-manager
  home-manager.users.juozas = (import "${home}/.config/nixpkgs/home.nix");
}
