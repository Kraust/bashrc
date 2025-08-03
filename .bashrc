#!/usr/bin/env bash

export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

if [ "$Path" != "" ]; then
    # Windows
    export OPT_BASH_PLATFORM="windows"
    export Path="$Path;$SCRIPT_DIR/azt"
    export Path="$Path;$HOME/.cargo/bin"
    export Path="$Path;$HOME/.config/bin"
    export Path="$Path;$HOME/bin"
else
    # Posix
    export OPT_BASH_PLATFORM="posix"
    export PATH="$PATH:$HOME/.cargo/bin"
    export PATH="$PATH:$HOME/.goenv/bin"
    export PATH="$PATH:$HOME/.pyenv/bin"
    export PATH="$PATH:$HOME/.rbenv/bin"
    export PATH="$PATH:$HOME/.nodenv/bin"
    export PATH="$PATH:$HOME/.config/bin"
    export PATH="$PATH:$HOME/bin"
fi

eval "$(starship init bash)"

# https://github.com/reubeno/brush/issues/380
# eval "$(fzf --bash)"

eval "$(goenv init -)"
eval "$(pyenv init -)"
eval "$(rbenv init -)"
eval "$(nodenv init -)"

WORK_ENV="$HOME/work/scripts/env.sh"
if [ -f "$WORK_ENV" ]; then
    source "$WORK_ENV"
else
    echo "$WORK_ENV not found. Skipping."
fi
