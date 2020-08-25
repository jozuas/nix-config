{ config, lib, pkgs, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        # <http://developer.gnome.org/pango/stable/PangoMarkupFormat.html>.
        markup = "yes";
        plain_text = "no";
        # The format of the message.  Possible variables are:
        #   %a  appname
        #   %s  summary
        #   %b  body
        #   %i  iconname (including its path)
        #   %I  iconname (without its path)
        #   %p  progress value if set ([  0%] to [100%]) or nothing
        # Markup is allowed
        format = "%s\n%b";
        frame_width = 1;
        # By urgency
        sort = "no";
        # Show number of hidden messages
        indicate_hidden = "yes";
        # Text alignment
        alignment = "center";
        bounce_freq = "0";
        show_age_threshold = "-1";
        word_wrap = "yes";
        ignore_newline = "no";
        stack_duplicates = "yes";
        hide_duplicates_count = "yes";
        geometry = "373-10+40";
        shrink = "no";
        transparency = "5";
        idle_threshold = "0";
        monitor = "0";
        follow = "none";
        sticky_history = "yes";
        history_length = "15";
        # Display indicators for URLs (U) and actions (A).
        show_indicators = "no";
        # The height of a single line.  If the height is smaller than the
        # font height, it will get raised to the font height.
        # This adds empty space above and under the text.
        line_height = "3";
        # Draw a line of "separator_height" pixel height between two
        # notifications.
        # Set to 0 to disable.
        separator_height = "2";
        # Padding between text and separator.
        padding = "6";
        # Horizontal padding.
        horizontal_padding = "6";
        # Define a color for the separator.
        # possible values are:
        #  * auto: dunst tries to find a color fitting to the background;
        #  * foreground: use the same color as the foreground;
        #  * frame: use the same color as the frame;
        #  * anything else will be interpreted as a X color.
        separator_color = "frame";
        startup_notification = "false";

        # Browser for opening urls in context menu.
        browser = "${pkgs.firefox-devedition-bin}/bin/firefox-devedition -new-tab";

        # Align icons left/right/off
        icon_position = "off";
        max_icon_size = "80";
      };
      shortcuts = {
        close_all = "mod1+space";
        history = "ctrl+mod4+h";
      };
      urgency_low = {
        frame_color = "#fdfdfd";
        foreground = "#fdfdfd";
        background = "#15161d";
        timeout = "5";
      };
      urgency_normal = {
        frame_color = "#fdfdfd";
        foreground = "#fdfdfd";
        background = "#15161d";
        timeout = "0";
      };
      urgency_critical = {
        frame_color = "#fdfdfd";
        foreground = "#fdfdfd";
        background = "#15161d";
        timeout = "0";
      };
      Notify-Send = {
        appname = "notify-send";
        timeout = "1";
      };
      Wifi = {
        appname = "NetworkManager";
        timeout = "3";
      };
    };
  };
}
