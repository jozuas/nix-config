{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "w";
    terminal = "screen-256color";
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    newSession = true;
    aggressiveResize = true;
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "macchiato"
          set -g @catppuccin_window_status_style "rounded"
        '';
      }
    ];
    extraConfig = ''
      # Functionality
      bind | split-window -h
      bind - split-window -v
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"
      set -g mouse on
      set-window-option -g automatic-rename off
      set-option -g allow-rename off
      setw -g monitor-activity on
      set -g visual-activity on
      set -g base-index 1
      setw -g pane-base-index 1
      set -g history-limit 10000

      bind-key c new-window -n 'window'

      # VI-like tmux selection
      set-window-option -g mode-keys vi
      unbind p
      bind p paste-buffer
      unbind-key -T copy-mode-vi v
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle \; send -X begin-selection
      # <C-w-w> for jumping between recent windows
      bind -r w select-pane -l

      # Make the status line pretty and remove catppuccin modules
      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left ""
      set -g status-right ""

      # Destroy sessions that are not explicitly deattached
      set-option destroy-unattached

      set -gu default-command
      set -g default-shell $SHELL
    '';
  };
}
