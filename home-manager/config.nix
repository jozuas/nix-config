{ ... }:

{
  # Hack for nixpkgs-unstable
  allowUnfree = true;

  # 22.05 has some broken packages
  allowBroken = true;
}
