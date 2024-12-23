#! /usr/bin/env bash


set -euo pipefail
IFS=$'\n\t'

function is_set {
    [ -z ${1+x} ]
}


function main {
    echo 'Setting up a new machine'

    # if [[ "$OSTYPE" == 'linux-gnu'* ]]; then
    #     sudo apt update \
    #         && sudo apt-get upgrade --yes \
    #         && sudo apt-get autoremove --yes

    #     programs=(
    #         'curl'
    #         'git'
    #         'jq'
    #         'stow'
    #         'tlp'
    #         'tmux'
    #         'vim-gtk3'
    #         'zsh'
    #         'zsh-autosuggestions'
    #     )

    #     echo 'Installing programs...'
    #     for prog in ${programs[@]}; do
    #         echo "$prog" 
    #         sudo apt-get install --yes --quiet $prog > /dev/null
    #     done
    #     echo 'Done'
    # fi

    echo 'Setting up git...'
    if [ -z ${GIT_USER_NAME+x} ] \
        || [ -z ${GIT_AUTHOR_NAME+x} ] \
        || [ -z ${GIT_COMMITTER_NAME+x} ] \
        || [ -z ${GIT_USER_EMAIL+x} ] \
        || [ -z ${GIT_AUTHOR_EMAIL+x} ] \
        || [ -z ${GIT_COMMITTER_EMAIL+x} ]
    then
        echo 'No git credentials found. Creating new git credentials.'

        if [ ! -e "$HOME/.zshenv.local" ]; then touch "$HOME/.zshenv.local"; fi

        read -p "What name would you like to use for git? " git_username 
        read -p "What email would you like to use for git? " git_email

        echo "export GIT_USER_NAME=$git_username" >> "$HOME/.zshenv.local"
        echo "export GIT_AUTHOR_NAME=$git_username" >> "$HOME/.zshenv.local"
        echo "export GIT_COMMITTER_NAME=$git_username" >> "$HOME/.zshenv.local"

        echo "export GIT_USER_EMAIL=$git_email" >> "$HOME/.zshenv.local"
        echo "export GIT_AUTHOR_EMAIL=$git_email" >> "$HOME/.zshenv.local"
        echo "export GIT_COMMITTER_EMAIL=$git_email" >> "$HOME/.zshenv.local"

        source "$HOME/.zshenv.local"
    else
        echo 'Existing git credentials already found'
    fi

    ssh_key_name="$HOME/.ssh/$(hostname)_ed25519"
    if [ ! -e $ssh_key_name ]; then
	echo 'Creating an SSH keypair...'
	ssh-keygen -t ed25519 -C $GIT_USER_EMAIL -f $ssh_key_name -N ''
	echo "Generated a new SSH key: $ssh_key_name"
	eval "$(ssh-agent -s)"
	ssh-add $ssh_key_name
    fi

    # Setup symbolic links
    echo 'Linking config files to home directory'
    for dir in */; do stow --verbose $dir; done

    if [ $SHELL != $(which 'zsh') ]; then
        echo 'Setting default shell to zsh'
        chsh -s $(which zsh)
        echo 'Default shell set: log out and back in to apply changes'
    fi

    echo 'Setup complete!'
}

main
