export VISUAL="vim"
export EDITOR="vim"
export HISTFILE=~/.histfile
export HISTSIZE=1000000000
export SAVEHIST=1000000000
export PYENV_ROOT="$HOME/.pyenv"
export LESS="--incsearch --ignore-case --mouse --wheel-lines=5 -R"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'

if [[ -a "$HOME/.zshenv.local" ]]; then
	source "$HOME/.zshenv.local" 
fi
