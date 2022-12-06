" window control

nnoremap ;     <C-W>+
nnoremap -     <C-W>-
nnoremap >     <C-W>>
nnoremap <     <C-W><
nnoremap <C-k> <C-W>k
nnoremap <C-j> <C-W>j
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap <C-q> <C-W>q
nnoremap <C-p> <C-W>p

" next/prev file
nnoremap <C-n>   :bn<CR>
nnoremap <S-C-n> :bp<CR>

" tag search
noremap <F12> <F1>
nnoremap <F1> :let g:search_tag=GetTargetTag(0)<CR>
nnoremap <F2> :call TagSearch(0, "\\<" . g:search_tag . "\\>")<CR>
nnoremap <F3> :cn<CR>
nnoremap <F4> :cp<CR>

" syntax switch
noremap <silent> ,f :if exists("g:syntax_on")\|syntax off\|else\|syntax enable\|endif<CR>
noremap <silent> <F9> :if exists("g:syntax_on")\|syntax off\|else\|syntax enable\|endif<CR>
