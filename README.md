# Dotfiles for Arch Linux
Basically serves as my checklist when setting up Arch on a new machine.  
Some scripts are modified to behave differently based on hostname for the setup to work more fluently between my machines.  
These may need modifications based on the machin. (.xinit, nvidia.sh, config.i3, wal-set)

Theming based on [wal](https://github.com/dylanaraps/pywal) for automated coloring of everything.  
In ranger use 'mkt' on image to have colorscheme generated and applied to everything.  
Manual firefox restart currently necessary for [userChrome.css](.config/userChrome.css) to be applied after changing colorscheme.

## Primary setup:
**Shell:** [zsh](https://github.com/zsh-users/zsh)  
**Terminal emulator:** [urxvt](https://github.com/exg/rxvt-unicode)  
**Terminal multiplexer:** [tmux](https://github.com/tmux/tmux)  
**WM:** [i3-gaps](https://github.com/Airblader/i3)  
**Bar:** [polybar](https://github.com/jaagr/polybar)  
**Launcher:** [rofi](https://github.com/DaveDavenport/rofi)  
**Text editor:** [vim](https://github.com/vim/vim)  
**Notification daemon:** [dunst](https://github.com/dunst-project/dunst)  
**File manager:** [ranger](https://github.com/ranger/ranger)  
**Media player:** [mpv](https://github.com/mpv-player/mpv)  
**Music:** [mopidy](https://github.com/mopidy/mopidy) with [mopidy-spotify](https://github.com/mopidy/mopidy-spotify) and [ncmpcpp](https://github.com/arybczak/ncmpcpp)  
**Visualizer:** [cava](https://github.com/karlstav/cava)  
**Mail client:** [neomutt](https://github.com/neomutt/neomutt)  
**System info:** [neofetch](https://github.com/dylanaraps/neofetch)  
**Screenlocker:** [i3lock](https://github.com/i3/i3lock)  
**Screenshot utility:** [maim](https://github.com/naelstrof/maim)  
**Background manager:** [nitrogen](https://github.com/l3ib/nitrogen)  
**Image viewer:** [sxiv](https://github.com/muennich/sxiv)  
**Browser:** [firefox](https://www.archlinux.org/packages/extra/x86_64/firefox/)  
**Startpage:** [startpage](https://github.com/ecly/startpage)  
**IRC Client:** [weechat](https://github.com/weechat/weechat)  
**Color theme generation:** [pywal](https://github.com/dylanaraps/pywal)  

**Additional dependencies:**
- [pulseaudio](https://www.archlinux.org/packages/?name=pulseaudio) & [pulseaudio-alsa](https://www.archlinux.org/packages/extra/any/pulseaudio-alsa/), alsa version is necessary for polybar volume.
- [w3m](http://w3m.sourceforge.net/), for previews in ranger.
- [NetworkManager](https://www.archlinux.org/packages/extra/x86_64/networkmanager/),[nm-applet](https://www.archlinux.org/packages/extra/x86_64/network-manager-applet/) and [networkmanager-openvpn](https://www.archlinux.org/packages/extra/i686/networkmanager-openvpn/).
- [htop](https://github.com/hishamhm/htop).
- [pamixer](https://github.com/cdemoulins/pamixer) for volume control binds.
- [w3m](http://w3m.sourceforge.net/) for ranger previews and html in mutt.
- [urlscan](https://github.com/firecat53/urlscan) extract urls in mutt.
- [vundle](https://github.com/VundleVim/Vundle.vim) vim plugin manager.
- [xclip](https://github.com/astrand/xclip) for copying url to clipboard with imgur script.
- [nvidia-settings](https://www.archlinux.org/packages/extra/x86_64/nvidia-settings/) For script setting up multi-head without screen tearing in X.
- [imagemagick](https://github.com/ImageMagick/ImageMagick) For i3lock blur effect.
- [Tamsyn](https://www.archlinux.org/packages/community/any/tamsyn-font/), [Iosevka](https://aur.archlinux.org/packages/ttf-iosevka), [FontAwesome](https://aur.archlinux.org/packages/ttf-font-awesome/), [Inconsolata](https://www.archlinux.org/packages/community/any/ttf-inconsolata/), [Noto Sans](https://www.archlinux.org/packages/extra/any/noto-fonts/),[Terminus](https://www.archlinux.org/packages/community/any/terminus-font), fonts used for basically everything.
- Probably a couple more things found out the hard way.

**Manual setup:**
- Manual symlinking of [userChrome.css](.config/userChrome.css) to Firefox profile.
- Manual clone and setup of [startpage](https://github.com/ecly/startpage) with Firefox.
- Manual OpenVPN VPN setup.
- Mopidy spotify authorization configuration & renaming of config file.
- Mutt cache folders, alises and .personal containing mail info.
- Weechat SASL/Secure setup.
- qBittorrent setup with VPN.
- Symlink ~/.config/i3/config.i3 and modify beforehand if needed for machine (eg. workspace bindings).
- Install Vundle + Plugins -> make vimproc.
