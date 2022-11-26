{ pkgs }:

let
  script = pkgs.writeShellScriptBin "disable-mouse-acceleration" ''
    xinput_device_id=$(${pkgs.xorg.xinput}/bin/xinput \
      | grep -E "Microsoft.*Transceiver v9.0 Mouse" \
      | cut -f2 \
      | cut -d= -f2)

    if [ -n "$xinput_device_id" ]; then
      ${pkgs.xorg.xinput}/bin/xinput --set-prop "$xinput_device_id" "libinput Accel Speed" -1
    fi
  '';
in script
