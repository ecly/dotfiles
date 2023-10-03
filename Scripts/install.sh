!/bin/bash
set -e


if [[ "$OSTYPE" == "darwin"* ]]; then

    if ! command -v brew > /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        source ~/.zprofile
    fi

    python

    brew install koekeishiya/formulae/skhd

    brew install \
        antidote \
        betterdisplay \
        bitwarden \
        ca-certificates \
        cmake \
        universal-ctags \
        discord \
        docker \
        docker-completion \
        docker-compose \
        fd \
        firefox \
        fzf \
        git-delta \
        gnu-sed \
        ncdu \
        neovim \
        neovim-remote \
        nvm \
        protobuf \
        pyenv \
        ripgrep \
        signal \
        spotify \
        tmux \
        tmuxinator \
        tree-sitter \
        tresort \
        unnaturalscrollwheels \
        wezterm \
        wget \


else
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
        zsh \
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
        texlive-most \
        biber \
        texlive-lang
fi

mkdir -p ~/.cache/zsh
touch ~/.cache/zsh/history
