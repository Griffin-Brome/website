autoload -Uz compinit promptinit vcs_info
compinit
promptinit

if [[ -a "$HOME/.aliases" ]]; then
	source "$HOME/.aliases"
fi

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias k='kubectl'
alias g='git'

# Case insensitive, unless capital letter used
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

alias pygrep='find . -name "*.py" | xargs grep -n' 
setopt HIST_SAVE_NO_DUPS    # Only save distinct commands to history
setopt PROMPT_SUBST

bindkey -e   # Emacs movement

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

if [[ -a "$HOME/.cargo/env" ]]; then
        source "$HOME/.cargo/env"
fi

# Local config
if [[ -a "$HOME/.zshrc.local" ]]; then
	source "$HOME/.zshrc.local"
fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/griffin/google-cloud-sdk/path.zsh.inc' ]; then . '/home/griffin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/griffin/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/griffin/google-cloud-sdk/completion.zsh.inc'; fi
