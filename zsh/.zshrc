autoload -Uz compinit promptinit vcs_info
autoload -z edit-command-line
autoload -U +X bashcompinit && bashcompinit

fpath+="$HOME/.local/share/zsh/user-functions"  # Install local completion scripts here
compinit
promptinit

function source_if_exists() {
    if [[ -e "$1" ]]; then
        source "$1"
    fi	       
}

function tmux () {
    if [ "$#" -eq 0 ]; then
        command tat
    else;
        command tmux "$@"
    fi
}

source_if_exists "$HOME/.shellrc" 
source_if_exists '/usr/share/doc/fzf/examples/key-bindings.zsh'
source_if_exists '/usr/share/doc/fzf/examples/completion.zsh'
source_if_exists "$HOME/.cargo/env"

# Case insensitive, unless capital letter used
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select

setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.
setopt LIST_PACKED
setopt LIST_ROWS_FIRST

setopt HIST_SAVE_NO_DUPS    # Only save distinct commands to history
setopt PROMPT_SUBST

bindkey -e   # Emacs movement

# Use C-x C-e to edit current command in $VISUAL
zle -N edit-command-line
bindkey "^X^E" edit-command-line

precmd () { vcs_info }

zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
    '%%F{5}(%F{2}%b%F{5})%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git

PROMPT='%F{3}%3~ ${vcs_info_msg_0_}%f$ '

command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
command -v kubectl > /dev/null && source <(kubectl completion zsh)

complete -o nospace -C /usr/bin/terraform terraform

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# Created by `pipx` on 2024-05-04 03:43:30
export PATH="$PATH:/home/griffin/.local/bin"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Local config
source_if_exists "$HOME/.zshrc.local"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
