
"-----------------------------------------
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/hogehoge/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/hogehoge/.vim/dein/')
  call dein#begin('/home/hogehoge/.vim/dein/')

  " Let dein manage dein
  " Required:
  call dein#add('/home/hogehoge/.vim/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " auto complete
  if has('lua')
    call dein#add('Shougo/neocomplete')
  else
    call dein#add('Shougo/neocomplcache.vim')
  endif

  " utility
  call dein#add('scrooloose/nerdtree')
  call dein#add('nathanaelkane/vim-indent-guides')

  call dein#add('Shougo/unite.vim')
  call dein#add('tsukkee/unite-tag')

  call dein#add('bronson/vim-trailing-whitespace')
  "call dein#add('tpope/vim-pathogen')
  "call dein#add('vim-syntastic/syntastic')
  call dein#add('soramugi/auto-ctags.vim')

  call dein#add('fholgado/minibufexpl.vim')
  call dein#add('junegunn/fzf.vim')

  " status line
  "call dein#add('Lokaltog/vim-powerline')
  "call dein#add('powerline/powerline')
  "call dein#add('itchyny/lightline.vim')
  call dein#add('vim-airline/vim-airline')


  " color scheme
  call dein#add('google/vim-colorscheme-primary')
  call dein#add('tomasr/molokai')
  call dein#add('aereal/vim-colors-japanesque')

  " syntax
  call dein#add('posva/vim-vue')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" If you want delete some plugin, enable the blow.
" and, restart the VIM
" after restarted, exec this command
" :call dein#recache_runtimepath()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------


" load more configs
runtime! plugin_conf/*.vim
runtime! key_bind/*.vim
runtime! ftplugin/man.vim

" auto complete
if has('lua')
  runtime! plugin_conf/neocomp/neocomplete.vim
else
  runtime! plugin_conf/neocomp/neocomplcache.vim
endif

" pathogen
"execute pathogen#infect()

"-----------------------------------------
" Personal Setup
filetype plugin indent on
syntax enable
colorscheme elflord
set path+=**
set encoding=utf-8
set statusline=2
set t_Co=256
set background=dark
set number
set showmatch
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
"set whichwrap=b,s,h,l,<,>,[,]
set list
set listchars=tab:>\ ,trail:~
set ruler
set nowrapscan
set noequalalways
set hlsearch
set incsearch
set ve=block
set colorcolumn=100
set completeopt=menuone

" filetype tab / space setting
if has("autocmd")
    filetype plugin on
    filetype indent on
    autocmd FileType html        setlocal sw=2 sts=2 ts=2 et
    autocmd FileType js          setlocal sw=2 sts=2 ts=2 et
    autocmd FileType python      setlocal sw=4 sts=4 ts=4 et
    autocmd FileType scala       setlocal sw=4 sts=4 ts=4 et
    autocmd FileType json        setlocal sw=2 sts=2 ts=2 et
    autocmd FileType html        setlocal sw=2 sts=2 ts=2 et
    autocmd FileType css         setlocal sw=2 sts=2 ts=2 et
    autocmd FileType scss        setlocal sw=2 sts=2 ts=2 et
    autocmd FileType sass        setlocal sw=2 sts=2 ts=2 et
    autocmd FileType javascript  setlocal sw=2 sts=2 ts=2 et
    autocmd FileType vue         setlocal sw=2 sts=2 ts=2 et
endif

" highlight em space
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif

" auto comment off
augroup auto_comment_off
    autocmd!
    autocmd BUfEnter * setlocal formatoptions-=r
    autocmd BUfEnter * setlocal formatoptions-=o
augroup END

" vim-trailing-whitespace
autocmd BufWritePre * :FixWhitespace

" Highlight trailing spaces
augroup HighlightTrailingSpaces
    autocmd!
    autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
    autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

" vim-airline
"let g:airline_powerline_fonts = 1

" syntax limit for big display
"augroup vimrc-highlight
"    autocmd!
"    autocmd Syntax * if 10000 < line('$') | syntax sync minlines=100 | endif
"augroup END

" vim-vue
" https://qiita.com/nabewata07/items/d92655485622aeb847a8
autocmd FileType vue syntax sync fromstart
let g:ft = ''
function! NERDCommenter_before()
    if &ft == 'vue'
        let g:ft = 'vue'
        let stack = synstack(line('.'), col('.'))
        if len(stack) > 0
            let syn = synIDattr((stack)[0], 'name')
            if len(syn) > 0
                exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
            endif
        endif
    endif
endfunction
function! NERDCommenter_after()
    if g:ft == 'vue'
        setf vue
        let g:ft = ''
    endif
endfunction
