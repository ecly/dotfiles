# vim:filetype=i3
# Should you change your keyboard layout some time, delete
# this file and re-run i3-config-wizard(1).

# Expected to be symlinked to ~/.config/i3/config

# i3 config file (v4)
# Please see http://i3wm.org/docs/userguide.html for a complete reference!

###--- Settings---###
set $mod Mod1
set $sup Mod4
set $term urxvt

set $innergap 10
set $outergap 0

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# Almost solely used in case of nagbar
font pango: xos4 Terminus 12

# Do not follow the mouse
focus_follows_mouse no

# Window border
new_window pixel 3
default_border pixel 3

# Setup gaps
gaps inner $innergap
gaps outer $outergap

###--- i3 coloring ---###
# Make it clear when failed using red - otherwise set i3 colors with wal from xresources
set_from_resource $bg           i3wm.color0 #ff0000
set_from_resource $bg-alt       i3wm.color14 #ff0000
set_from_resource $fg           i3wm.color15 #ff0000
set_from_resource $fg-alt       i3wm.color2 #ff0000
set_from_resource $hl           i3wm.color13 #ff0000

# class                 border      backgr. text indicator      child_border
client.focused          $fg-alt     $bg     $hl  $fg-alt        $hl
client.focused_inactive $fg-alt     $bg     $fg  $fg-alt        $fg-alt
client.unfocused        $fg-alt     $bg     $fg  $fg-alt        $fg-alt
client.urgent           $fg-alt     $bg     $fg  $fg-alt        $fg-alt
client.placeholder      $fg-alt     $bg     $fg  $fg-alt        $fg-alt

client.background       $bg

###--- Window bindings / Focus ---###
#Web
assign [class="(?i)firefox"] 1
for_window [class="(?i)firefox"] focus
assign [class="(?i)nightly"] 1
for_window [class="(?i)nightly"] focus

#Enternatain -> music and pdf
for_window [class="Zathura"] focus
assign [class="Zathura"] 3
assign [instance="ncmpcpp"] 3
for_window [instance="ncmpcpp"] focus
assign [instance="dance"] 3
for_window [instance="dance"] focus
assign [instance="cava"] 3
for_window [class="(?i)spotify"] focus
assign [class="(?i)spotify"] 3

# Communication
assign [class="Slack"] 4
for_window [class="Slack"] focus
assign [class="(?i)discord"] 4
for_window [class="(?i)discord"] focus
assign [class="(?i)messenger for desktop"] 4
for_window [class="(?i)messenger for desktop"] focus
assign [instance="mutt"] 4
for_window [instance="mutt"] focus
assign [instance="weechat"] 4
for_window [instance="weechat"] focus

#Video
assign [class="mpv"] 5
for_window [class="mpv"] focus

#Bit
assign [instance="qbittorrent"] 6

# Setup workspaces
workspace 1 output HDMI-0
workspace 2 output DVI-I-1
workspace 3 output DP-0
workspace 4 output DP-0
workspace 5 output HDMI-0

###--- i3 navigation binds ---###
# change focus - vim style
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

# move focused window - vim style
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# split in horizontal orientation
bindsym $mod+backslash split h

# split in vertical orientation
bindsym $mod+BackSpace split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
bindsym $mod+t floating toggle

# toggle / untoggle gaps
# see https://www.reddit.com/r/i3wm/comments/5e593j/script_to_toggle_gaps_on_and_off/
# to make this into a single command
bindsym $mod+Shift+g gaps inner current set 0; gaps outer current set 0
bindsym $mod+g gaps inner current set $innergap; gaps outer current set $outergap

# open an empty container
bindsym $mod+o open

# change focus between tiling / floating windows
bindsym $mod+Shift+t focus mode_toggle

bindsym $mod+Escape		workspace prev
bindsym $mod+Shift+grave exec i3-msg exit

# Kill all focused windows with Control+q
bindsym $mod+q kill

###--- Launch Applications Binds ---###
bindsym $mod+Return exec $term -e tmux
bindsym $mod+Shift+Return exec $term
bindsym $sup+r exec $term -name ranger -e ranger
bindsym $mod+r exec $term -name ranger -e ranger
bindsym $sup+n exec $term -name ncmpcpp -e ncmpcpp; exec --no-startup-id mpc random on; exec --no-startup-id mpc repeat on
bindsym $sup+t exec $term -name gotop -e gotop
bindsym $sup+c exec $term -name cava -e cava
bindsym $sup+b exec firefox
bindsym $sup+Shift+b exec firefox --private-window
bindsym $sup+q exec qbittorrent
bindsym $sup+m exec $term -name mutt -e sh ~/Scripts/mutt.sh
bindsym $sup+s exec slack
bindsym $sup+i exec $term -name weechat -e weechat
bindsym $sup+w exec $term -name nmtui -e nmtui-connect
bindsym $sup+j exec $term -name todo -e nvim ~/Documents/irl/todo.txt

# All in one music bind -> d for dance
bindsym $sup+d exec $term -name dance -e sh ~/Scripts/music_mux.sh

###--- Audo and Music definitions---###
set $pause mpc toggle
set $next mpc next
set $prev mpc prev
set $inc pamixer -i 5
set $dec pamixer -d 5
set $mute pamixer -t

###--- Music/Sound Keybindings ---###
bindsym $sup+Right exec --no-startup-id $next
bindsym $sup+Left exec --no-startup-id $prev
bindsym $sup+p exec --no-startup-id $pause
bindsym $sup+Up exec --no-startup-id mpc volume +5
bindsym $sup+Down exec --no-startup-id mpc volume -5

# Sound
bindsym $mod+i exec --no-startup-id sh ~/Scripts/movesinks.sh 1
bindsym $mod+Shift+i exec --no-startup-id sh ~/Scripts/movesinks.sh 0
bindsym $mod+p exec --no-startup-id $mute
bindsym $mod+Up exec --no-startup-id $inc
bindsym $mod+Down exec --no-startup-id $dec

###--- Command Keybindings ---###
# focus the parent container
bindsym $mod+a focus parent

#switch to workspace
bindsym $mod+1 workspace 1
bindsym $mod+2 workspace 2
bindsym $mod+3 workspace 3
bindsym $mod+4 workspace 4
bindsym $mod+5 workspace 5
bindsym $mod+6 workspace 6
bindsym $mod+7 workspace 7
bindsym $mod+8 workspace 8
bindsym $mod+9 workspace 9
bindsym $mod+0 workspace 10

#move focused container to workspace
bindsym $mod+Shift+1 move container to workspace 1
bindsym $mod+Shift+2 move container to workspace 2
bindsym $mod+Shift+3 move container to workspace 3
bindsym $mod+Shift+4 move container to workspace 4
bindsym $mod+Shift+5 move container to workspace 5
bindsym $mod+Shift+6 move container to workspace 6
bindsym $mod+Shift+7 move container to workspace 7
bindsym $mod+Shift+8 move container to workspace 8
bindsym $mod+Shift+9 move container to workspace 9
bindsym $mod+Shift+0 move container to workspace 10

# reload the configuration file
bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart

# Resize keybinds
bindsym $mod+plus resize grow width 10 px or 10 ppt
bindsym $mod+Shift+plus resize grow height 10 px or 10 ppt
bindsym $mod+minus resize shrink width 10 px or 10 ppt
bindsym $mod+Shift+minus resize shrink height 10 px or 10 ppt

# Screenshot region/monitor and uniquely identify in picture folder
bindsym $mod+z exec --no-startup-id sh ~/Scripts/screenshot_region.sh
bindsym $mod+Shift+z exec --no-startup-id sh ~/Scripts/screenshot_monitor.sh

# Rofi keybinds
bindsym $mod+m exec sh ~/Scripts/rofi.sh run
bindsym $mod+Shift+m exec sh ~/Scripts/rofi.sh window

# Lock screen
bindsym $sup+l exec --no-startup-id sh ~/Scripts/lock.sh

###--- scripts ran at start ---###
# Setup triple monitor setup
#exec --no-startup-id xrandr --auto --output DVI-I-1 --mode 1920x1080 --rate 144 --auto --output HDMI-0 --mode 1920x1080 --rate 60 --left-of DVI-I-1 --auto --output DP-0 --mode 1920x1080 --rate 60 --right-of DVI-I-1 --rotate right

# Merged nvidia monitor setup with nitrogen as nitrogen won't restore properly till screens are setup
# Nvidia setup instead of xrandr is to include fix for screen tearing with X and Nvidia proprietary driver
exec --no-startup-id sh ~/Scripts/nvidia.sh; nitrogen --restore

# Restore wallpaper setup
#exec --no-startup-id nitrogen --restore

# Wal, dunst and polybar combined - waiting for wal values first
# Currently wait a bit before executing due to a known bug
# https://bbs.archlinux.org/viewtopic.php?id=200797
# Modify sleep time from machine to machine
exec --no-startup-id sleep 2; sh ~/Scripts/beautify.sh

###--- Launch Applications/Daemons At Start ---###

# Setup NetworkManager
exec --no-startup-id nm-applet

# Start Mopidy Server
exec --no-startup-id mopidy

# Save the eyes with redshift
exec --no-startup-id redshift -l 59.334591:18.063240

###--- Input settings (mouse/keyboard) ---####
# Reduce mouse speed by 0%
exec --no-startup-id xinput --set-prop 9 'libinput Accel Speed' 0
#exec --no-startup-id xinput --set-prop 9 'libinput Accel Speed' -0.25

# Map Caps Lock to Esc
# Allow keyboard toggling using alt + space
exec --no-startup-id sh ~/Scripts/keymap.sh

# Start unclutter to hide mouse-pointer when unused
exec --no-startup-id unclutter

# Start xss-lock to handle screenlocking on systemd-events
exec --no-startup-id xss-lock -l -- sh ~/Scripts/lock.sh

###--- Scratchpad terminal setup ---###
for_window [instance="scratch"] floating enable
for_window [instance="scratch"] resize set 625 400
for_window [instance="scratch"] move position center
for_window [instance="scratch"] move scratchpad
exec --no-startup-id $term -name scratch -e tmux

bindsym $mod+u [instance="scratch"] scratchpad show; move position center

for_window [instance="(?i)bitwarden"] floating enable
for_window [instance="(?i)bitwarden"] resize set 1366 768
for_window [instance="(?i)bitwarden"] move position center
for_window [instance="(?i)bitwarden"] move scratchpad
exec --no-startup-id bitwarden-bin -name password

bindsym $mod+Shift+u [instance="(?i)bitwarden"] scratchpad show; move position center

###--- Media key bindings ---###
bindsym XF86AudioMute		    exec $mute
bindsym XF86AudioLowerVolume	exec $dec
bindsym XF86AudioRaiseVolume    exec $inc
bindsym XF86MonBrightnessDown	exec --no-startup-id xbacklight -dec 15
bindsym XF86MonBrightnessUp     exec --no-startup-id xbacklight -inc 15
bindsym XF86KbdBrightnessDown	exec --no-startup-id kbdlight down
bindsym XF86KbdBrightnessUp     exec --no-startup-id kbdlight up
bindsym XF86AudioNext		    exec $next
bindsym XF86AudioPlay		    exec $pause
bindsym XF86AudioPrev           exec $prev
