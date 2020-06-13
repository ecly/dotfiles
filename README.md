# Dotfiles for Arch Linux
My checklist file when setting up Arch Linux.  
For management of dotfiles see [this](.config/DOT_MANAGEMENT.md).

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
- **Mail client:** [neomutt](https://github.com/neomutt/neomutt)  
- **System info:** [neofetch](https://github.com/dylanaraps/neofetch)  
- **Screenlocker:** [i3lock](https://github.com/i3/i3lock)  
- **Screenshot utility:** [maim](https://github.com/naelstrof/maim)  
- **Image viewer:** [sxiv](https://github.com/muennich/sxiv)  
- **Browser:** [firefox](https://www.archlinux.org/packages/extra/x86_64/firefox/)  
- **Startpage:** [startpage](https://github.com/ecly/startpage)  
- **IRC Client:** [weechat](https://github.com/weechat/weechat)  
- **Color theme generation:** [pywal](https://github.com/dylanaraps/pywal)  

### Additional dependencies:
- [pulseaudio](https://www.archlinux.org/packages/?name=pulseaudio) & [pulseaudio-alsa](https://www.archlinux.org/packages/extra/any/pulseaudio-alsa/), alsa version is necessary for polybar volume.
- [w3m](http://w3m.sourceforge.net/), for previews in ranger.
- [NetworkManager](https://www.archlinux.org/packages/extra/x86_64/networkmanager/), includes nmtui and connection editor.
- [gotop](https://github.com/cjbassi/gotop) system monitoring with vim binds.
- [pamixer](https://github.com/cdemoulins/pamixer) for volume control binds.
- [pulsemixer](https://github.com/GeorgeFilipkin/pulsemixer) ncurses mixer for pulseaudio.
- [w3m](http://w3m.sourceforge.net/) for ranger previews and html in mutt.
- [urlscan](https://github.com/firecat53/urlscan) extract urls in mutt.
- [plug](https://github.com/junegunn/vim-plug) vim plugin manager.
- [xclip](https://github.com/astrand/xclip) for copying url to clipboard with imgur script.
- [imagemagick](https://github.com/ImageMagick/ImageMagick) For i3lock blur effect and pywal.
- [gnupg](https://www.archlinux.org/packages/core/x86_64/gnupg/) For mutt details.
- [Terminus](https://www.archlinux.org/packages/community/any/terminus-font); [Inconsolata](https://www.archlinux.org/packages/community/any/ttf-inconsolata/); [Noto Sans](https://www.archlinux.org/packages/extra/any/noto-fonts/); [Terminus TTF](https://aur.archlinux.org/packages/terminus-font-ttf/); [Terminess](https://aur.archlinux.org/packages/nerd-fonts-terminus/); Fonts used for basically everything.
- [xbanish](https://github.com/jcs/xbanish) hide cursor when unused.
- [highlight](https://www.archlinux.org/packages/community/i686/highlight/) for highlighting in ranger previews.
- [ffmpegthumbnailer](https://github.com/dirkvdb/ffmpegthumbnailer) for video thumbnails in ranger.
- [redshift](https://www.archlinux.org/packages/community/x86_64/redshift/) easy on the eyes at night.
- [fzf](https://github.com/junegunn/fzf) command line fuzzy finding.
- [ripgrep](https://github.com/BurntSushi/ripgrep) fast search tool.
- [tmuxinator](https://github.com/tmuxinator/tmuxinator) tmux session manager.
- [kbdlight](https://aur.archlinux.org/packages/kbdlight/), adjust keyboard lighting.
- [xbacklight](https://www.archlinux.org/packages/extra/x86_64/xorg-xbacklight/), adjust backlight.
- [mons](https://github.com/Ventto/mons), shell script for external display management.

### Manual setup:
- VPN setup.
- Mutt aliases and .details setup.
- Weechat SASL/Secure setup.
