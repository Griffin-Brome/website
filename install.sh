#! /usr/bin/env bash
# vi: sw=4 sts=4 ai

set -euo pipefail
IFS=$'\n\t'


function __setup_git {
    echo 'Creating new git credentials.'
    local git_username=$1
    local git_email=$2
    read -p "What name would you like to use for git? " git_username 
    read -p "What email would you like to use for git? " git_email
    echo "export GIT_AUTHOR_NAME=$git_username" >> $HOME/.zshenv.local
    echo "export GIT_AUTHOR_EMAIL=$git_email" >> $HOME/.zshenv.local
    echo "Git credentials saved to $HOME/.zshenv.local"
    echo "Source it for them to take effect"
}


function main {
    echo 'Setting up a new machine'
    echo 'Checking for existing git credentials'
    if [ ! -z ${GIT_AUTHOR_NAME} ] && [ ! -z ${GIT_AUTHOR_EMAIL} ]; then
        echo 'Git credentials already found'
    else
        echo 'No git credentials found' 
        while true; do
            local response
            read -p 'Set them up now? (Y/n): ' response
            case "${response:-n}" in
                [Yy]) __setup_git; break ;;
                [Nn]) break ;;
                *) echo "Invalid choice" ;;
            esac
        done
    fi

    ssh_key_name="$HOME/.ssh/id_ed25519"
    if [ ! -e $ssh_key_name ]; then
        echo 'Creating an SSH keypair...'
        ssh-keygen -t ed25519 -C $GIT_USER_EMAIL -f $ssh_key_name -N ''
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
