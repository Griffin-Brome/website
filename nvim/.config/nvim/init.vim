let mapleader = ' '

filetype plugin indent on
syntax on

set showcmd
set hidden
set wildoptions=pum             " Use popup for command line completion
set hlsearch incsearch          " Highlight as you search
set ignorecase smartcase        " Case insensitive search, unless a capital letter is used
set splitright splitbelow       " Splits same as tmux
set softtabstop=-1              " Use value of 'shiftwidth' to determine indent size
set path=.
set path+=**
set background=dark             " Make sure colours aren't weird when using a dark terminal theme
set mouse=nv                    " No mouse in insert mode 
set noswapfile


nnoremap Y y$
nnoremap <silent> g/ :nohlsearch<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap j gj
nnoremap k gk

nnoremap <C-p> :Files<Cr>
nnoremap <C-g> :Git<Cr>
nnoremap gb :Buffers<Cr>

" Use ripgrep for searching files
" ref: https://github.com/BurntSushi/ripgrep/issues/425#issuecomment-1299001166
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat+=%f:%l:%c:%m
endif

" Netrw (file browser)
let g:netrw_liststyle=3   " Tree style

" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'ibhagwan/fzf-lua'
Plug 'neovim/nvim-lspconfig', Cond(has('nvim'))
Plug 'nvim-treesitter/nvim-treesitter', Cond(has('nvim'), { 'do': ':TSUpdate' })
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'zbirenbaum/copilot.lua'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

augroup Resize
  autocmd!
  autocmd VimResized * wincmd =
augroup END

let g:python3_host_prog = $NEOVIM_PYTHON
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0

set number relativenumber
set cursorline
colorscheme catppuccin

lua << EOF
require'lspconfig'.pylsp.setup{}
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = "all",
  highlight = { enable = true },
  indent = { enable = true }
}
require("copilot").setup({
  suggestion = {
    auto_trigger = true,
    keymap = {
      accept = "<C-o>"
    }
  }
})
require'fzf-lua'.setup({'fzf-vim'})
EOF
