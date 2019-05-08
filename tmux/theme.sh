#### COLOUR

tm_color_active=colour32
tm_color_inactive=colour241
tm_color_feature=colour206
tm_color_music=colour215
tm_active_border_color=colour240
tm_color_white=colour231

# separators
tm_separator_left_bold="◀"
tm_separator_left_thin="❮"
tm_separator_right_bold="▶"
tm_separator_right_thin="❯"

set -g status-left-length 32
set -g status-right-length 150
set -g status-interval 5

# default statusbar colors
# set-option -g status-bg colour129
set-option -g status-fg $tm_color_active
set-option -g status-bg default
set-option -g status-attr default

# default window title colors
set-window-option -g window-status-fg $tm_color_inactive
set-window-option -g window-status-bg default
set -g window-status-format "#I #W"

# active window title colors
set-window-option -g window-status-current-fg $tm_color_active
set-window-option -g window-status-current-bg default
set-window-option -g  window-status-current-format "#[bold]#I #W"

# pane border
set-option -g pane-border-fg $tm_color_inactive
set-option -g pane-active-border-fg $tm_active_border_color

# message text
set-option -g message-bg default
set-option -g message-fg $tm_color_active

# pane number display
set-option -g display-panes-active-colour $tm_color_active
set-option -g display-panes-colour $tm_color_inactive

# clock
set-window-option -g clock-mode-colour $tm_color_active

#Battery
set -g @batt_remain_short true

tm_date_utc="#(date --utc +%Y-%m-%dT%%H:%%M:%%SZ)"
tm_date_ist="#(TZ=Asia/Kolkata date +%d/%m/%Y,' '%%H:%%M:%%S) IST ::"
tm_date="#[fg=$tm_color_white] $tm_date_ist $tm_date_utc"

tm_host="#[fg=$tm_color_feature,bold]#h"
tm_session_name="#[fg=$tm_color_feature,bold]#S"

tm_cpu="#{cpu_fg_color}CPU: #{cpu_icon} #{cpu_percentage} |"
tm_battery="#{battery_status_fg}Batt: #{battery_icon} #{battery_percentage} #{battery_remain} |"
tm_current_path="#[fg=$tm_color_music]#{pane_current_path} |"

set -g status-left $tm_session_name' '
set -g status-right $tm_cpu' '$tm_battery' '$tm_date' '
