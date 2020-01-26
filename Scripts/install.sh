# install yay if not already installed
if ! command -v yay > /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
fi

yay -Syyu --noconfirm \
    zsh \
    zsh-completions \
    zsh-syntax-highlighting \
    tmux \
    i3-gaps \
    polybar \
    rofi \
    neovim \
    dunst \
    ranger \
    mpv \
    mpd \
    mopidy \
    mopidy-spotify \
    ncmpcpp \
    cava \
    neomutt \
    neofetch \
    i3lock \
    maim \
    nitrogen \
    sxiv \
    firefox \
    weechat \
    python-pywal \
    pulseaudio \
    pulseaudio-alsa \
    gotop \
    networkmanager \
    pamixer \
    w3m \
    urlscan \
    xclip \
    imagemagick \
    gnupg \
    terminus-font \
    terminus-font-ttf \
    highlight \
    ffmpegthumbnailer \
    redshift \
    fzf \
    ripgrep \
    tmuxinator \
    xbanish \
    ttf-inconsolata \
    noto-fonts \
    ttf-font-awesome-4 \
    xorg \
    xorg-xinit \
    zsh-syntax-highlighting \
    zsh-completions \
    openssh \
    rxvt-unicode \
    python-pynvim \
    bitwarden-bin \
    fd \
    kbdlight \
    elixir \
    mullvad-vpn \
    python-pylint \
    ntp \
    python-jedi \
    urxvt-resize-font \
    fd \
    feh \
    speedtest-cli \
    pacmixer \
    python-pip \
    python-regex \
    python-tqdm \
    zathura \
    zathura-pdf-mupdf \
    libreoffice \
    wget \
    unzip \
    nodejs-neovim \
    ruby-neovim \
    texlive-most \
    biber \
    texlive-lang \
    neovim-remote \
    python2-pynvim

# apply theme
wal --theme base16-gruvbox-hard

# start network manager
systemctl enable --now NetworkManager

# ensure time is correct
timedatectl set-ntp true

# additional optional setup
if [ -e "$1" ]; then
    yay -S postgresql
    runuser -l postgres -c 'initdb -D /var/lib/postgres/data'
    systemctl enable --now postgresql
fi
