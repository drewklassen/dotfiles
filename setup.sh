#!/bin/bash
set -o nounset -o errexit -o pipefail

# Utility: setup a single file
function setup() {
    SRC="$1"
    DST="$2"
    echo "Installing $SRC..."

    mkdir -p $(dirname "$DST")
    ln -sfn "$PWD/$SRC" "$DST"
}

# Copy configuration files
setup Xdefaults  "$HOME/.Xdefaults"
setup ackrc      "$HOME/.ackrc"
setup aliases    "$HOME/.aliases"
setup gitconfig  "$HOME/.gitconfig"
setup paths      "$HOME/.paths"
setup ssh-config "$HOME/.ssh/config"
setup vimrc      "$HOME/.vimrc"
setup xmonad.hs  "$HOME/.xmonad/xmonad.hs"
setup zshrc      "$HOME/.zshrc"

# Copy binaries
setup bin/cabal-make "$HOME/.bin/cabal-make"

# Create backup dir for vim
echo 'Creating vim backup dir...'
mkdir -p "$HOME/.vim/backup"

# Install vundle if necessary
echo 'Installing vundle...'
if [[ ! -d "$HOME/.vim/bundle/vundle" ]]; then
    git clone 'https://github.com/gmarik/vundle.git' "$HOME/.vim/bundle/vundle"
    vim -c BundleInstall -c qa # Not sure if this is a nice way to do things
fi
