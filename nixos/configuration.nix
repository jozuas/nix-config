# System-wide configuration

{ config, pkgs, ... }:

{
  # Include the results of the hardware scan.
  imports =
    [ 
      ./hardware-configuration.nix
      ./machine/current.nix
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

    initrd.luks.devices.root = {
      preLVM = true;  # First lukOpen, then LVM scan
      allowDiscards = true;  # Enable TRIM requests
    };

    cleanTmpDir = true;
    kernelPackages = pkgs.linuxPackages_latest;  # Use the latest kernel
  };

  # SSD performance fine-tuning
  fileSystems."/".options = [ "noatime" "nodiratime" "commit=60" ];

  networking = {
    hostName = "nixos";
    tcpcrypt.enable = true;

    networkmanager = {
      enable = true;
      wifi.backend = "wpa_supplicant";
      wifi.powersave = true;
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };

    hosts = {
      "3.11.69.118" = [ "vpn.researchspace.com" ];
    };
  };

  # Localisation
  time.timeZone = "Europe/London";
  location.provider = "geoclue2";
  i18n.defaultLocale = "en_GB.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  fonts.fontconfig = {
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [ "DejaVu Sans Mono" ];
      sansSerif = [ "DejaVu Sans" ];
      serif = [ "DejaVu Serif" ];
    };

    penultimate.enable = true;  # Better fonts
  };

  hardware = {
    acpilight.enable = true;  # Enable the use of xbacklight
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;

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

    bluetooth = {
      enable = true;
      package = pkgs.bluezFull;
    };
  };

  # Misc. hardware settings
  sound.enable = true;
  powerManagement.powertop.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.autoOptimiseStore = true;

  environment = {
    systemPackages = with pkgs; [
      killall
      file
      neovim
      wireshark
      openvpn
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

  programs.zsh = {
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

  services = {
    xserver = {
      # Enable touchpad support.
      libinput.enable = true;

      # Enable the X11 windowing system.
      enable = true;
      layout = "gb";

      # Enable the KDE Desktop Environment.
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;

      # Make CAPS an additional ESC
      xkbOptions = "caps:escape";
    };

    # Enable periodic SSD trimming for sustained long-term SSD performance
    fstrim.enable = true;
    fstrim.interval = "weekly";

    tlp.enable = true;
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
  system.stateVersion = "19.09";  # DO NOT CHANGE, unless NixOS tells you to
}
