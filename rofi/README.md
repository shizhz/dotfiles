# Configure rofi

Copy or link current directory to `~/.config/rofi`. 
- `config`: rofi config file. 

  **Note:**The theme file location(`rofi.theme`) need to be configured with absolute path, please change to your path.
- `*.sh files`: scripts integrated with rofi to do customized tasks. e.g. google from rofi.
- `themes`: rofi theme files' location.

# Configure hotkeys in i3
Add the following lines to i3 config file `~/.config/i3/config`:

  ```
  bindsym $mod+d exec "rofi -show-icons -modi run,drun,ssh -show combi"
  bindsym $mod+p exec "rofi -show-icons -modi window,Google:$HOME/.config/rofi/rofi_google.sh -show window"
  bindsym $mod+g exec "rofi -show-icons -modi window,Google:$HOME/.config/rofi/rofi_google.sh -show Google"
  ```
or change the hotkeys to your preferences.
