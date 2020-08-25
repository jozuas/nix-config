{ config, lib, pkgs, ... }:

{
  programs.irssi = {
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
      };
    '';
  };
}
