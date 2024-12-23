" Flake8 compiler plugin

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif
CompilerSet errorformat="%f:%l:%c: %m"
CompilerSet makeprg=flake8
