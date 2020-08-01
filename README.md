# Dotfiles for Arch Linux
My checklist when setting up Arch Linux.  
For management of dotfiles see [this](.config/DOT_MANAGEMENT.md).  
For easy installation of packages see [install.sh](Scripts/install.sh).

**Styling**  
Most applications have styling based on [pywal](https://aur.archlinux.org/packages/nerd-fonts-terminus/).

## Primary setup:
- **Shell:** [zsh](https://github.com/zsh-users/zsh)  
- **Terminal emulator:** [urxvt](https://github.com/exg/rxvt-unicode)  
- **Terminal multiplexer:** [tmux](https://github.com/tmux/tmux)  
- **WM:** [i3-gaps](https://github.com/Airblader/i3)  
- **Bar:** [polybar](https://github.com/jaagr/polybar)  
- **Launcher:** [rofi](https://github.com/DaveDavenport/rofi)  
- **Text editor:** [neovim](https://github.com/neovim/neovim)  
- **Notification daemon:** [dunst](https://github.com/dunst-project/dunst)  
- **File manager:** [ranger](https://github.com/ranger/ranger)  
- **Media player:** [mpv](https://github.com/mpv-player/mpv)  
- **Email client:** [neomutt](https://github.com/neomutt/neomutt)  
- **Screenlocker:** [i3lock](https://github.com/i3/i3lock)  
- **Screenshots:** [maim](https://github.com/naelstrof/maim)  
- **Image viewer:** [sxiv](https://github.com/muennich/sxiv)  
- **Browser:** [firefox](https://www.archlinux.org/packages/extra/x86_64/firefox/)  
- **Color theme generation:** [pywal](https://github.com/dylanaraps/pywal)  

### Additional dependencies:
- [pulseaudio](https://www.archlinux.org/packages/?name=pulseaudio) & [pulseaudio-alsa](https://www.archlinux.org/packages/extra/any/pulseaudio-alsa/) alsa version is necessary for polybar volume.
- [w3m](http://w3m.sourceforge.net/) previews in ranger.
- [NetworkManager](https://www.archlinux.org/packages/extra/x86_64/networkmanager/) includes nmtui and connection editor.
- [gotop](https://github.com/cjbassi/gotop) system monitoring with vim binds.
- [pamixer](https://github.com/cdemoulins/pamixer) volume control binds.
- [pulsemixer](https://github.com/GeorgeFilipkin/pulsemixer) ncurses mixer for pulseaudio.
- [w3m](http://w3m.sourceforge.net/) ranger previews and html in mutt.
- [urlscan](https://github.com/firecat53/urlscan) extract urls in mutt.
- [plug](https://github.com/junegunn/vim-plug) vim plugin manager.
- [xclip](https://github.com/astrand/xclip) managing clipboard from scripts.
- [imagemagick](https://github.com/ImageMagick/ImageMagick) for i3lock blurring.
- [gnupg](https://www.archlinux.org/packages/core/x86_64/gnupg/) encryption.
- [Terminus TTF](https://aur.archlinux.org/packages/terminus-font-ttf/); [Terminess](https://aur.archlinux.org/packages/nerd-fonts-terminus/); [Noto Sans](https://www.archlinux.org/packages/extra/any/noto-fonts/); fonts used for basically everything.
- [xbanish](https://github.com/jcs/xbanish) hide cursor when unused.
- [highlight](https://www.archlinux.org/packages/community/i686/highlight/) highlighting in ranger previews.
- [ffmpegthumbnailer](https://github.com/dirkvdb/ffmpegthumbnailer) video thumbnails in ranger.
- [redshift](https://www.archlinux.org/packages/community/x86_64/redshift/) easy on the eyes at night.
- [fzf](https://github.com/junegunn/fzf) command line fuzzy finding.
- [ripgrep](https://github.com/BurntSushi/ripgrep) faster grep alternative.
- [tmuxinator](https://github.com/tmuxinator/tmuxinator) tmux session manager.
- [kbdlight](https://aur.archlinux.org/packages/kbdlight/) adjust keyboard lighting.
- [xbacklight](https://www.archlinux.org/packages/extra/x86_64/xorg-xbacklight/) adjust backlight.
- [mons](https://github.com/Ventto/mons) shell script for external display management.

### Manual setup:
- VPN setup.
- Mutt aliases and .details setup.
