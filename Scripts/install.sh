#!/bin/bash
set -e


if [ "$(uname)" == "Darwin" ]; then
    echo "Installing for macOS"

    if ! command -v brew > /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        source ~/.zprofile
    fi

    brew install koekeishiya/formulae/skhd

    brew install antidote
    brew install betterdisplay
    brew install bitwarden
    brew install ca-certificates
    brew install cmake
    brew install direnv
    brew install discord
    brew install --cask docker
    brew install docker-completion
    brew install docker-compose
    brew install fd
    brew install firefox
    brew install fzf
    brew install git-delta
    brew install gnu-sed
    brew install ncdu
    brew install neovim
    brew install neovim-remote
    brew install nvm
    brew install protobuf
    brew install pyenv
    brew install ripgrep
    brew install signal
    brew install spotify
    brew install tmux
    brew install tmuxinator
    brew install tree-sitter
    brew install --cask tresorit
    brew install universal-ctags
    brew install unnaturalscrollwheels
    brew install wezterm
    brew install wget

    # set up docker compose symlins (as suggested by brew)
    mkdir -p ~/.docker/cli-plugins
    ln -sfn /opt/homebrew/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose
else
    echo "Installing for macOS"

    # install yay if not already installed
    if ! command -v yay > /dev/null; then
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si
        cd ..
        rm -rf yay
    fi


    yay -Syyu --noconfirm \
        alacritty \
        antibody \
        bitwarden-bin \
        ctags \
        ctop-bin \
        dunst \
        elixir \
        elixir-ls \
        fd \
        ffmpegthumbnailer \
        firefox \
        fzf \
        git-delta \
        gnupg \
        gotop \
        highlight \
        i3-gaps \
        i3lock \
        imagemagick \
        kbdlight \
        lua-format \
        lua-language-server \
        maim \
        mons \
        mpv \
        mullvad-vpn-bin \
        ncdu
        neomutt \
        neovim \
        neovim-remote \
        nerd-fonts-terminus \
        networkmanager \
        nm-connection-editor \
        noto-fonts \
        npm \
        ntp \
        openssh \
        polybar \
        pulseaudio \
        pulseaudio-alsa \
        pulsemixer \
        pyenv \
        python-pip \
        python-pynvim \
        ranger \
        redshift \
        ripgrep \
        rofi \
        sc-im \
        sxiv \
        terminus-font-ttf \
        terraform-ls \
        tmux \
        tmuxinator \
        unzip \
        urlscan \
        w3m \
        wget \
        xbanish \
        xclip \
        xdotool \
        xorg \
        xorg-xinit \
        xss-lock \
        zathura \
        zathura-pdf-mupdf \
        zip \
        zsh
fi


# Handle Python specific installs with pipx
pyenv install 3.11.5
pyenv global 3.11.5
pyenv shell 3.11.5
pip3 install pipx --user
pipx install poetry
pipx install pywal
pipx install vint
pipx install pywal

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
        texlive
fi

mkdir -p ~/.cache/zsh
touch ~/.cache/zsh/history
