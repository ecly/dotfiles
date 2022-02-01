export PATH="$HOME/.cargo/bin:$PATH"

# Used as directory for binaries for vim go plugin
export GOPATH="${HOME}/.local/share/go"
export GOBIN="${GOPATH}/bin"
export PATH=$GOBIN:$PATH
export PATH=~/.local/bin:$PATH
export PATH=~/.local/share/tresorit:$PATH

# Stop the lag in vi mode
export KEYTIMEOUT=1

# Set vim as editor, less as pager.
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

# Don't log duplicate commands.
export HISTCONTROL=ignoredups

# node/npm settings
export NODE_ENV="development"
export NPM_PACKAGES="${HOME}/.node"
export NODE_PATH="$HOME/.node/lib/node_modules:$NODE_PATH"
export PATH="$NPM_PACKAGES/bin:$PATH"
export MANPATH="$NPM_PACKAGES/share/man:$MANPATH"

# nltk data directory
export NLTK_DATA="$HOME/.local/share/nltk_data"

# enable iex history
export ERL_AFLAGS="-kernel shell_history enabled"

# MT installation locations
export BEERHOME="$HOME/.local/share/beer_2.0/"
export MMTHOME="$HOME/Programming/work/modernmt/"

# disable dotnet telemtry
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Clean up for home directory, based heavily on:
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
export AIRFLOW_HOME="$HOME/.local/share/airflow"
export ZDOTDIR="$HOME/.config/zsh"
export RUSTUP_HOME="$HOME/.config/rustup"
export PYLINTHOME="$HOME/.cache/pylint"
export IPYTHONDIR="$HOME/.config/jupyter"
export JUPYTER_CONFIG_DIR="$HOME/.config/jupyter"
export DOCKER_CONFIG="$HOME/.config/docker"
export LESSHISTFILE=-
export MYSQL_HISTFILE="$HOME/.cache/mysql_history"
# ensure creation of necessary folders for config
mkdir -p "$HOME/.config/pg" && mkdir -p "$HOME/.cache/pg"
export PSQL_HISTORY="$HOME/.cache/pg/psql_history"
export PGPASSFILE="$HOME/.config/pg/pgpass"
export PGSERVICEFILE="$HOME/.config/pg/pg_service.conf"
export GRIPHOME="$HOME/.config/grip"
export CARGO_HOME="$HOME/.local/share/cargo"
export WEECHAT_HOME="$HOME/.config/weechat"
export PYTHONSTARTUP="$HOME/.config/pythonrc"

# Add pyenv specific ENVVARs following documentation
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx "$HOME/.config/X11/xinitrc"
fi
