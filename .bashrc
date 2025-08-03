#!/usr/bin/env bash

export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

if [ "$Path" != "" ]; then
    # Windows
    export OPT_BASH_PLATFORM="windows"
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

RUST_COREUTILS="[ b2sum b3sum base32 base64 basename basenc cat cksum comm cp csplit cut date dd df dir dircolors dirname du echo env expand expr factor false fmt fold hashsum head join link ln ls md5sum mkdir mktemp more mv nl numfmt od paste pr printenv printf ptx pwd readlink realpath rm rmdir seq sha1sum sha224sum sha256sum sha3-224sum sha3-256sum sha3-384sum sha3-512sum sha384sum sha3sum sha512sum shake128sum shake256sum shred shuf sleep sort split sum tac tail tee test touch tr true truncate tsort unexpand uniq unlink vdir wc yes"
for core in "${RUST_COREUTILS[@]}"; do
    alias "$core"="coreutils $core"
done
