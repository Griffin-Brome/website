set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
let g:python3_host_prog = $NEOVIM_PYTHON
source ~/.vim/vimrc

set number relativenumber
set cursorline

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = {
    "python",
    "yaml",
    "vim",
    "vimdoc",
    "sql",
    "markdown",
    "markdown_inline",
    "tmux",
    "bash",
    "dockerfile",
    "terraform"
  },
  highlight = { enable = true },
  indent = { enable = true }
}
EOF
