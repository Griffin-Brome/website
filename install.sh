#! /usr/bin/env bash
# vi: sw=4 sts=4 ai

set -euo pipefail
IFS=$'\n\t'

function main {
    echo 'Setting up a new machine'
    ssh_key_name="$HOME/.ssh/id_ed25519"
    if [ ! -e $ssh_key_name ]; then
        echo 'Creating an SSH keypair...'
	ssh-keygen -t ed25519 -C "$(git config user.email)" -f $ssh_key_name -N ''
        echo "Generated a new SSH key: $ssh_key_name"
        eval "$(ssh-agent -s)"
        ssh-add $ssh_key_name
    fi

    # Setup symbolic links
    echo 'Linking config files to home directory:'
    echo '====================================================================='
    for dir in */; do
        for subdir in $(find "$dir" -mindepth 1 -type d); do
            mkdir -pv "$HOME/${subdir#*/}"
        done
        for file in $(find "$dir" -mindepth 1 -type f); do
            ln -svf "$PWD/$file" "$HOME/${file#*/}" 
        done
    done
    echo '====================================================================='

    if [ $SHELL != $(which 'zsh') ] && $(command -v zsh &>/dev/null); then
        echo 'Setting default shell to zsh'
        chsh -s $(which zsh)
        echo 'Default shell set'
        echo 'Logout and login, or run `exec $SHELL` to apply it'
    fi

    echo 'Setup complete!'
}

main
