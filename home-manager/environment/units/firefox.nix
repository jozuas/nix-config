{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition-bin;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      decentraleyes
      vimium
      bitwarden
      facebook-container
      react-devtools
      leechblock-ng
      greasemonkey
    ];
  };
}
