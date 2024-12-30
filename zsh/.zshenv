path=(
	"$HOME/bin"
	"$HOME/.local/bin"
	"$HOME/.pyenv/bin"
	$path
)
fpath=(
	"$HOME/.local/share/zsh/site-functions"  # Install local completion scripts here
	$fpath
)

if [ -x "$(command -v nvim)" ]; then
	export VISUAL='nvim'
	export EDITOR='nvim'
else;
	export VISUAL='vi'
	export EDITOR='vi'
fi

export PYENV_ROOT="$HOME/.pyenv"
export HISTFILE=~/.histfile
export HISTSIZE=1000000000
export SAVEHIST=1000000000
export LESS="-RXF"
export RSYNC_RSH='ssh'
export NEOVIM_PYTHON=0  # This should be overridden locally

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
if [ -x "$(command -v fd)" ]; then
	export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden'
	export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
fi

# Needed to make pipx work with pyenv
# Ref: https://github.com/pypa/pipx/pull/448#issuecomment-657350726
if [ -x "$(command -v pyenv)" ]; then
	export PIPX_DEFAULT_PYTHON="$PYENV_ROOT/shims/python"
	path+="$PYENV_ROOT/bin:$PATH"
fi


if [[ -a "$HOME/.zshenv.local" ]]; then
	source "$HOME/.zshenv.local" 
fi

# Do this after local env, so that local env can modify PATH
export PATH
