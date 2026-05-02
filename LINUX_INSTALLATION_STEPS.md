# Manual steps for NixOS setup

### Boot

1. Download NixOS `.iso` and the `sha256` of the iso from [nixos.org](https://nixos.org/download.html)
2. Compare `.iso` integrity with
   ```bash
   shasum -a 256 -c <checksum-filename>.iso.sha256 <filename>.iso
   ```
3. Create a live USB with
   ```bash
   dd if=<filename>.iso of=/dev/<usb-drive> status=progress
   ```
4. Boot the live USB


### UEFI partitioning and formatting

#### Partitioning:
```bash
# Create a GPT partition table, example <dev> is sda
parted /dev/<dev> -- mklabel gpt

# EFI in front, rest is LUKS encrypted partition
parted /dev/<dev> -- mkpart primary 512MiB 100%

# Create the boot partition.
parted /dev/<dev> -- mkpart ESP fat32 1MiB 512MiB
parted /dev/<dev> -- set 2 boot on
```

#### Formatting, LVM and dm-crypt
```bash
mkfs.fat -F 32 -n boot /dev/<dev><efi-partition>

cryptsetup -v luksFormat /dev/<dev><luks-partition>
cryptsetup luksOpen /dev/<dev><luks-partition> luks

pvcreate /dev/mapper/luks
vgcreate vg0 /dev/mapper/luks
lvcreate -L 4G vg0 -n swap
lvcreate -l +100%FREE vg0 -n root

mkfs.ext4 /dev/mapper/vg0-root
mkswap /dev/mapper/vg0-swap
```

#### Mounting
```bash
mount /dev/mapper/vg0-root /mnt
swapon /dev/mapper/vg0-swap

mkdir -p /mnt/boot
mount /dev/<dev><efi-partition> /mnt/boot
```

### Installation

Generate initial configuration with
```bash
nixos-generate-config --root /mnt
```

Find the UUID of Linux LVM with `sudo blkid`. The entry should have
TYPE="crypto_LUKS". This UUID will be required in the next step.

Add the following temporary options to `/mnt/etc/nixos/configuration.nix` so
the live system can boot, connect to wifi, and unlock the LUKS volume:
```nix
networking.hostName = "nixos";
networking.wireless.enable = true;
networking.wireless.networks = {
  "TODO-SSID" = {
    psk = "TODO-PASSWORD";
  };
};

boot.initrd.luks.devices.root = {
  device = "/dev/disk/by-uuid/<TODO-uuid-from-above>";
};

environment.systemPackages = with pkgs; [
  vim
  git
];

users.users.juozas = {
  isNormalUser = true;
  extraGroups = [ "wheel" ];
  home = "/home/juozas";
};
```

Do the installation
```bash
nixos-install

reboot
```

### Configuration

1. On boot, login via TTY as `root`.
2. Change the password for the user `juozas` with `passwd juozas`.
3. `su -l juozas`.
4. Git clone this repo in `/home/juozas`.
5. Move `system.stateVersion` declaration into a new file called
   `state-version.nix` in `~/nix-config/nixos/` (gitignored, per-machine):
   ```nix
   { ... }:
   {
     system.stateVersion = "19.09"; # DO NOT CHANGE, unless NixOS tells you to
   }
   ```
6. Copy `/etc/nixos/hardware-configuration.nix` into `~/nix-config/nixos/`
   (also gitignored, per-machine).
7. Move `networking.interfaces.*` and `boot.initrd.luks.devices.root` config
   into the appropriate machine file under `~/nix-config/nixos/machine/`
   (e.g. `t480s.nix`).
8. Create `variables.nix` in `~/nix-config/home-manager/` with
   `OPENWEATHER_API_KEY` and `GITHUB_TOKEN` vars.
9. Build and switch to the flake configuration:
   ```bash
   sudo nixos-rebuild switch --flake ~/nix-config#t480s
   ```
   Replace `t480s` with the appropriate `nixosConfigurations.<name>` entry
   from `flake.nix` if setting up a different machine.

Subsequent updates are `nix flake update` (in `~/nix-config`) followed by the
same `nixos-rebuild switch --flake` command.


### Other manual configuration

- Generate a GPG Key with `gpg --full-generate-key`. Put the signature into the
  machine git config as all commits will be signed with this key.
- Generate an SSH Key with `ssh-keygen -t rsa -b 4096 -C "j@norkus.net"`
  and run `ssh-add ~/.ssh/id_rsa` to add the key into the keychain.
- Set `layers.acceleration.force-enabled` to `true` to get rid of screen tearing on Firefox.
- Create a keyring named `login` with Seahorse. Password must be the same as the login password.
- Import manual backups from ~/nix-config/backups
- Create password store with `pass init GPG-KEY-ID`
