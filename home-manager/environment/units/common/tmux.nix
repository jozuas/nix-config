{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "SPACE";
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

      # Styling
      setw -g window-status-current-style fg=black,bg=red
      setw -g window-status-activity-style fg=cyan,bg=black
      set -g status-style fg=black,bg=cyan
      set -g message-style fg=black,bg=red
      set-window-option -g window-status-current-format '#I:#W'
      set-window-option -g window-status-format '#I:#W'

      # Hide status bar if only 1 window is present
      if -F "#{==:#{session_windows},1}" "set -g status off" "set -g status on"
      set-hook -g window-linked 'if -F "#{==:#{session_windows},1}" "set -g status off" "set -g status on"'
      set-hook -g window-unlinked 'if -F "#{==:#{session_windows},1}" "set -g status off" "set -g status on"'

      # Destroy sessions that are not explicitly deattached
      set-option destroy-unattached
    '';
  };
}
