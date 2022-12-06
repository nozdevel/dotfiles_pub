" ctags
"export DTags(type)
"export DTagsBaseDirSet()

"       execute '!(cd ' . s:ctags_base_dir .
"                    \ ';armtags.sh -R ' . s:ctags_base_dir .
"                    \ ';ftags.sh -a '   . s:ctags_base_dir .
"                    \ ';ctags -a -R '   . s:ctags_base_dir .
"                    \ ')'

function! DTags(...)
    if(a:0==0 || a:1=='0')
        execute '!(cd ' . s:ctags_base_dir .
              \'  ;ctags -R --extras=+q --languages=C,C++,Python ' .
              \     s:ctags_base_dir . ';' .
              \'  ~/.vim/bin/ftags.sh -a -e unit_test ' . s:ctags_base_dir . ')'
    else
        execute '!ctags -Rn ' . s:ctags_base_dir
    endif
endfunction

function! DTagsBaseDirSet(ctags_base_dir)
    let l:ctags_base_dir=fnamemodify(a:ctags_base_dir, ":p")
    if(isdirectory(l:ctags_base_dir))
        let s:ctags_base_dir=l:ctags_base_dir
    else
        let s:ctags_base_dir="."
    endif

    let &tags="./tags, " . s:ctags_base_dir . "/tags"
"   echo &tags
endfunction

function! DTagsBaseDirSetAtCurrentPosition()
    let l:path="."
    echo l:path
    call DTagsBaseDirSet(l:path)
endfunction

function! DTagsBaseDirShow()
    echo s:ctags_base_dir
endfunction

command! -nargs=1 -complete=file DtagsBaseDir call DTagsBaseDirSet(<f-args>)
command! -nargs=* Dtags call DTags(<f-args>)
command! -nargs=* DtagsBaseDirShow call DTagsBaseDirShow()

call DTagsBaseDirSet(".")
