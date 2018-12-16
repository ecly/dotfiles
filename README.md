# Dotfiles for Arch Linux
Checklist file for setting up Arch.  
For management of dotfiles see [this](.config/DOT_MANAGEMENT.md).


**Styling**  
In ranger use 'mkt' on image to have colorscheme generated and applied to everything.  
Manual firefox restart currently necessary for [userChrome.css](.config/userChrome.css) to be applied after changing colorscheme.

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
- **Music:** [mopidy](https://github.com/mopidy/mopidy) with [mopidy-spotify](https://github.com/mopidy/mopidy-spotify) and [ncmpcpp](https://github.com/arybczak/ncmpcpp)  
- **Visualizer:** [cava](https://github.com/karlstav/cava)  
- **Mail client:** [neomutt](https://github.com/neomutt/neomutt)  
- **System info:** [neofetch](https://github.com/dylanaraps/neofetch)  
- **Screenlocker:** [i3lock](https://github.com/i3/i3lock)  
- **Screenshot utility:** [maim](https://github.com/naelstrof/maim)  
- **Background manager:** [nitrogen](https://github.com/l3ib/nitrogen)  
- **Image viewer:** [sxiv](https://github.com/muennich/sxiv)  
- **Browser:** [firefox](https://www.archlinux.org/packages/extra/x86_64/firefox/)  
- **Startpage:** [startpage](https://github.com/ecly/startpage)  
- **IRC Client:** [weechat](https://github.com/weechat/weechat)  
- **Color theme generation:** [pywal](https://github.com/dylanaraps/pywal)  

### Additional dependencies:
- [pulseaudio](https://www.archlinux.org/packages/?name=pulseaudio) & [pulseaudio-alsa](https://www.archlinux.org/packages/extra/any/pulseaudio-alsa/), alsa version is necessary for polybar volume.
- [w3m](http://w3m.sourceforge.net/), for previews in ranger.
- [NetworkManager](https://www.archlinux.org/packages/extra/x86_64/networkmanager/),[nm-applet](https://www.archlinux.org/packages/extra/x86_64/network-manager-applet/) and [networkmanager-openvpn](https://www.archlinux.org/packages/extra/i686/networkmanager-openvpn/).
- [gotop](https://github.com/cjbassi/gotop) system monitoring with vim binds.
- [pamixer](https://github.com/cdemoulins/pamixer) for volume control binds.
- [ncpamixer](https://github.com/fulhax/ncpamixer) ncurses mixer for pulseaudio.
- [w3m](http://w3m.sourceforge.net/) for ranger previews and html in mutt.
- [urlscan](https://github.com/firecat53/urlscan) extract urls in mutt.
- [plug](https://github.com/junegunn/vim-plug) vim plugin manager.
- [xclip](https://github.com/astrand/xclip) for copying url to clipboard with imgur script.
- [nvidia-settings](https://www.archlinux.org/packages/extra/x86_64/nvidia-settings/) For script setting up multi-head without screen tearing in X.
- [wal_steam](https://github.com/kotajacob/wal_steam), styling steam based on wal colors.
- [imagemagick](https://github.com/ImageMagick/ImageMagick) For i3lock blur effect and pywal.
- [gnupg](https://www.archlinux.org/packages/core/x86_64/gnupg/) For mutt details.
- [Terminus](https://www.archlinux.org/packages/community/any/terminus-font); [FontAwesome](https://aur.archlinux.org/packages/ttf-font-awesome/); [Inconsolata](https://www.archlinux.org/packages/community/any/ttf-inconsolata/); [Noto Sans](https://www.archlinux.org/packages/extra/any/noto-fonts/); Fonts used for basically everything.
- [unclutter-xfixes](https://github.com/Airblader/unclutter-xfixes) hide cursor when unused.
- [highlight](https://www.archlinux.org/packages/community/i686/highlight/) for highlighting in ranger previews.
- [ffmpegthumbnailer](https://github.com/dirkvdb/ffmpegthumbnailer) for video thumbnails in ranger.
- [redshift](https://www.archlinux.org/packages/community/x86_64/redshift/) easy on the eyes at night.
- [cht.sh](https://github.com/chubin/cheat.sh#command-line-client-chtsh) easy cheat sheet access.
- [fzf](https://github.com/junegunn/fzf) command line fuzzy finding.
- [ripgrep](https://github.com/BurntSushi/ripgrep) fast search tool.
- [urlscan](https://aur.archlinux.org/packages/urlscan-git/) url selection in mutt.
- Probably a couple more things found out the hard way.

### Laptop only dependencies:
- [kbdlight](https://aur.archlinux.org/packages/kbdlight/), adjust keyboard lighting.
- [xbacklight](https://www.archlinux.org/packages/extra/x86_64/xorg-xbacklight/), adjust backlight.
- [mons](https://github.com/Ventto/mons), shell script for external display management.

### Manual setup:
- Manual symlinking of [userChrome.css](.config/userChromeNightly.css) to Firefox profile.
- Manual clone and setup of [startpage](https://github.com/ecly/startpage) with Firefox.
- VPN setup.
- Mopidy spotify authorization configuration & renaming of config file.
- Mutt aliases and .details setup.
- Weechat SASL/Secure setup.
- qBittorrent setup with VPN.
- Symlink ~/.config/i3/config.i3 and modify beforehand if needed for machine (eg. workspace bindings).
