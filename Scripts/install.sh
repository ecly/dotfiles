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
    nodejs-neovim \
    ruby-neovim \
    python2-pynvim \
    python-pynvim \
    neovim-remote \
    dunst \
    ranger \
    mpv \
    neomutt \
    i3lock \
    xss-lock \
    maim \
    sxiv \
    firefox \
    python-pip \
    python-pywal \
    python-jedi \
    python-pylint \
    pulseaudio \
    pulseaudio-alsa \
    pulsemixer \
    gotop \
    networkmanager \
    w3m \
    urlscan \
    xclip \
    imagemagick \
    gnupg \
    noto-fonts \
    terminus-font-ttf \
    nerd-fonts-terminus \
    highlight \
    ffmpegthumbnailer \
    redshift \
    fzf \
    ripgrep \
    tmuxinator \
    xbanish \
    xorg \
    xorg-xinit \
    openssh \
    rxvt-unicode \
    bitwarden-bin \
    fd \
    kbdlight \
    elixir \
    mullvad-vpn \
    ntp \
    urxvt-resize-font \
    fd \
    zathura \
    zathura-pdf-mupdf \
    libreoffice \
    wget \
    zip \
    unzip \
    texlive-most \
    biber \
    texlive-lang \
    npm \
    yarn \
    nm-connection-editor \
    ctags \
    oh-my-zsh-git \
    git-delta \
    mons

# apply theme
wal --theme base16-gruvbox-hard

# start network manager
systemctl enable --now NetworkManager

# ensure time is correct
timedatectl set-ntp true

# additional optional setup
if [ -e "$1" ]; then
    # setup postgres for development
    yay -S --noconfirm \
        postgresql \
        spotify \
        noto-fonts-cjk \
        dbeaver

    runuser -l postgres -c 'initdb -D /var/lib/postgres/data'
    systemctl enable --now postgresql
fi
