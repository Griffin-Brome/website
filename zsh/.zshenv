path+=(
	"$HOME/bin"
)

export HISTFILE=~/.histfile
export HISTSIZE=1000000000
export SAVEHIST=1000000000

if [[ -a "$HOME/.zshenv.local" ]]; then
	source "$HOME/.zshenv.local" 
fi

# Do this after local env, so that local env can modify PATH
export PATH
