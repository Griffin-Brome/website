autoload -Uz compinit promptinit vcs_info
compinit
promptinit

function source_if_exists() {
	if [[ -e "$1" ]]; then
	       source "$1"
	fi	       
}


# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias k='kubectl'
alias g='git'

source_if_exists "$HOME/.aliases"

# Case insensitive, unless capital letter used
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

alias pygrep='find . -name "*.py" | xargs grep -n' 
setopt HIST_SAVE_NO_DUPS    # Only save distinct commands to history
setopt PROMPT_SUBST

bindkey -e   # Emacs movement

# Use C-x C-e to edit current command in $VISUAL
autoload -z edit-command-line
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

source_if_exists '/usr/share/doc/fzf/examples/key-bindings.zsh'
source_if_exists '/usr/share/doc/fzf/examples/completion.zsh'

source_if_exists "$HOME/.cargo/env"

# Local config
source_if_exists "$HOME/.zshrc.local"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
