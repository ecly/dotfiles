git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# for vm install xf86-video-vmware

yay -Syyu zsh zsh-completions zsh-syntax-highlighting tmux i3-gaps polybar rofi neovim dunst ranger mpv mpd mopidy mopidy-spotify ncmpcpp cava neomutt neofetch i3lock maim nitrogen sxiv firefox weechat python-pywal pulseaudio pulseaudio-alsa gotop networkmanager pamixer ncpamixer w3m urlscan xclip imagemagick gnupg terminus-font terminus-font-ttf highlight ffmpegthumbnailer redshift fzf ripgrep tmuxinator xbanish ttf-inconsolata noto-fonts ttf-font-awesome-4 xorg xorg-xinit zsh-syntax-highlighting zsh-completions openssh rxvt-unicode python-neovim bitwarden-bin fd kbdlight elixir mullvad-vpn xf86-input-keyboard python-pylint ntp python-jedi

wal --theme base16-gruvbox-hard
