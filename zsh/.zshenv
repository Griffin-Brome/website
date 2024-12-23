export VISUAL="vim"
export EDITOR="vim"
export HISTFILE=~/.histfile
export HISTSIZE=1000000000
export SAVEHIST=1000000000
export PYENV_ROOT="$HOME/.pyenv"
export PIP_REQUIRE_VIRTUALENV=true  # Don't allow pip install outside of a venv
# Needed to make pipx work with pyenv - https://github.com/pypa/pipx/pull/448#issuecomment-657350726
export PIPX_DEFAULT_PYTHON="$PYENV_ROOT/shims/python"
export LESS="--incsearch --ignore-case --mouse --wheel-lines=5 -R"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'

if [[ -a "$HOME/.zshenv.local" ]]; then
	source "$HOME/.zshenv.local" 
fi
