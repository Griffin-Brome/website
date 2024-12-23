set expandtab
set shiftwidth=4
set softtabstop=4

let g:python_indent = {}
let g:python_indent.open_paren = 'shiftwidth()'
let g:python_indent.nested_paren = '0'
let g:python_indent.continue = 'shiftwidth()'
let g:python_indent.closed_paren_align_last_line = v:false


compiler flake8
