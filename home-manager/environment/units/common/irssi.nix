{ ... }:

let
  variables = import ~/nix-config/variables.nix;
in {
  programs.irssi = {
    enable = true;
    networks = {
      freenode = {
        nick = "noreferences";
        server = {
          address = "chat.freenode.net";
          port = 6697;
          autoConnect = true;
        };
        autoCommands = [
          "/msg NickServ IDENTIFY ${variables.IRSSI_PASSWORD}; wait 6000"
        ];
        channels = {
          nixos.autoJoin = true;
          erlang.autoJoin = true;
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
              name = "#erlang";
              tag = "freenode";
            }
          );
        };
      };
    '';
  };
}
