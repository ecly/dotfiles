!/bin/bash
set -e

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
    antibody \
    python-pip \
    tmux \
    i3-gaps \
    polybar \
    rofi \
    neovim \
    python-pynvim \
    neovim-remote \
    dunst \
    ranger \
    mpv \
    i3lock \
    xss-lock \
    maim \
    sxiv \
    firefox \
    pulseaudio \
    pulseaudio-alsa \
    pulsemixer \
    gotop \
    networkmanager \
    neomutt \
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
    bitwarden-bin \
    fd \
    kbdlight \
    elixir \
    mullvad-vpn-bin \
    ntp \
    alacritty \
    fd \
    zathura \
    zathura-pdf-mupdf \
    wget \
    zip \
    unzip \
    npm \
    nm-connection-editor \
    ctags \
    git-delta \
    xdotool \
    mons \
    sc-im \
    ctop-bin \
    pyenv \
    elixir-ls \
    lua-language-server \
    lua-format \
    terraform-ls \
    ncdu


# Handle Python specific installs with pipx
pyenv install 3.11.5
pyenv global 3.11.5
pyenv shell 3.11.5
pip3 install pipx --user
pipx install "python-lsp-server[all]" \
    && pipx inject python-lsp-server pylsp-mypy pyls-isort python-lsp-black black"
pipx install poetry
pipx install pywal
pipx install vint

# apply theme
wal --theme base16-gruvbox-medium

# start network manager
systemctl enable --now NetworkManager

# ensure time is correct
timedatectl set-ntp true

# additional optional setup
if [ -e "$1" ]; then
    # setup postgres for development
    yay -S --noconfirm \
        spotify \
        noto-fonts-cjk \
        nodejs-neovim \
        ruby-neovim \
        python2-pynvim \
        libreoffice \
        texlive-most \
        biber \
        texlive-lang
fi
