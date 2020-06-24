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
    neomutt \
    neofetch \
    i3lock \
    maim \
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
    ttf-inconsolata \
    xorg \
    xorg-xinit \
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
    speedtest-cli \
    pulsemixer \
    python-pip \
    python-regex \
    python-tqdm \
    zathura \
    zathura-pdf-mupdf \
    libreoffice \
    wget \
    zip \
    unzip \
    nodejs-neovim \
    ruby-neovim \
    texlive-most \
    biber \
    texlive-lang \
    neovim-remote \
    python2-pynvim \
    npm \
    yarn \
    nm-connection-editor \
    ctags \
    oh-my-zsh-git \
    xss-lock \
    git-delta

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
