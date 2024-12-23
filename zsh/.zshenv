export VISUAL="vim"
export EDITOR="vim"
export HISTFILE=~/.histfile
export HISTSIZE=1000000000
export SAVEHIST=1000000000
export PYENV_ROOT="$HOME/.pyenv"

if [[ -a "$HOME/.zshenv.local" ]]; then
	source "$HOME/.zshenv.local" 
fi
