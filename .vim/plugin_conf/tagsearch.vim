"For tag-search using quick-fix.
"
"export TagSearch(search_type, search_tag)
"export GetTargetTag(type)
"export GetTagSearchBaseDir()
"

"s:search_result    : tag-search result is put to it.
"s:search_base_dir  : base directory to search a tag
let s:search_result_base="~/.vim"
let s:search_result=s:search_result_base . "/vim_grep.tmp"
let s:search_result="~/.vim/vim_grep.tmp"
let s:search_base_dir="."

"for tag search
function! TagSearch(search_type, search_tag)
    let uname = system('uname')
    if uname =~? 'Linux'
        let fopt = '-nH'
        let trushbox = ''
    else
        let fopt = '-n'
        let trushbox = '/dev/null'
    endif

    if uname =~? 'Linux'
        if a:search_type=='0'
            execute '!find '
                \ . s:search_base_dir
                \ . ' -type f -follow -name "*.[chsyS]" -exec grep ' . fopt . ' "'
                \ . a:search_tag
                \ . '" "{}" ' . trushbox . ' \; '
                \ . ' -o -name "*.cpp" -exec grep ' . fopt . ' "'
                \ . a:search_tag
                \ . '" "{}" ' . trushbox . ' \; '
                \ . ' -o -name "*.rb" -exec grep ' . fopt . ' "'
                \ . a:search_tag
                \ . '" "{}" ' . trushbox . ' \; '
                \ . ' -o -name "*.rhtml" -exec grep ' . fopt . ' "'
                \ . a:search_tag
                \ . '" "{}" ' . trushbox . ' \; '
                \ . ' -o -name "*.vim" -exec grep ' . fopt . ' "'
                \ . a:search_tag
                \ . '" "{}" ' . trushbox . ' \; '
                \ . ' -o -name "*.tcl" -exec grep ' . fopt . ' "'
                \ . a:search_tag
                \ . '" "{}" ' . trushbox . ' \; '
                \ . ' -o -name "*.mk" -exec grep ' . fopt . ' "'
                \ . a:search_tag
                \ . '" "{}" ' . trushbox . ' \; '
                \ . ' -o -name "Makefile" -exec grep ' . fopt . ' "'
                \ . a:search_tag
                \ . '" "{}" ' . trushbox . ' \; '
                \ . ' -o -name "*.txt" -exec grep ' . fopt . ' "'
                \ . a:search_tag
                \ . '" "{}" ' . trushbox . ' \; '
                \ . '| sed "s/:\\([1-9][0-9]*\\):/|\\1| /g" > '
                \ . s:search_result

       elseif a:search_type=='1'
           execute '!find '
               \ . s:search_base_dir
               \ . ' -type f -exec grep ' . fopt . ' "'
               \ . a:search_tag
               \ . '" "{}" ' . trushbox . ' \; | sed "s/:\\([1-9][0-9]*\\):/|\\1| /g" > '
               \ . s:search_result

       elseif a:search_type=='2'
           execute '!grep ' . fopt . ' "'
               \ . a:search_tag
               \ . '" '
               \ . s:search_base_dir . '/* '
               \ . ' | sed "s/:\\([1-9][0-9]*\\):/|\\1| /g" > '
               \ . s:search_result
        endif
    else
        if a:search_type=='0'
            execute '!find '
                \ . s:search_base_dir
                \ . ' -type f -name "*.[chsyS]" -exec grep ' . fopt . ' "'
                \ . a:search_tag
                \ . '" "{}" ' . trushbox . ' \; '
                \ . ' -o -name "*.cpp" -exec grep ' . fopt . ' "'
                \ . a:search_tag
                \ . '" "{}" ' . trushbox . ' \; '
                \ . ' -o -name "*.rb" -exec grep ' . fopt . ' "'
                \ . a:search_tag
                \ . '" "{}" ' . trushbox . ' \; '
                \ . ' -o -name "*.rhtml" -exec grep ' . fopt . ' "'
                \ . a:search_tag
                \ . '" "{}" ' . trushbox . ' \; '
                \ . ' -o -name "*.vim" -exec grep ' . fopt . ' "'
                \ . a:search_tag
                \ . '" "{}" ' . trushbox . ' \; '
                \ . ' -o -name "*.mk" -exec grep ' . fopt . ' "'
                \ . a:search_tag
                \ . '" "{}" ' . trushbox . ' \; '
                \ . ' -o -name "*.txt" -exec grep ' . fopt . ' "'
                \ . a:search_tag
                \ . '" "{}" ' . trushbox . ' \; '
                \ . '| sed "s/:\\([1-9][0-9]*\\):/|\\1| /g" > '
                \ . s:search_result

       elseif a:search_type=='1'
           execute '!find '
               \ . s:search_base_dir
               \ . ' -type f -exec grep ' . fopt . ' "'
               \ . a:search_tag
               \ . '" "{}"' . trushbox . ' \; | sed "s/:\\([1-9][0-9]*\\):/|\\1| /g" > '
               \ . s:search_result

       elseif a:search_type=='2'
           execute '!grep ' . fopt . ' "'
               \ . a:search_tag
               \ . '" '
               \ . s:search_base_dir . '/* '
               \ . ' | sed "s/:\\([1-9][0-9]*\\):/|\\1| /g" > '
               \ . s:search_result
        endif
    endif
    unlet uname
    silent execute "cf " . s:search_result
endfunction

function! GetTargetTag(type)
    if(a:type=='0')
        let l:search_tag = expand("<cword>")
        echo "tag : " . l:search_tag
    elseif(a:type=='1')
        let l:search_tag=input("tag : ")
    elseif(a:type=='2')
        let content=input("tag : ")
        let l:search_tag = '.*'. content . '.*'
    endif
    return l:search_tag
endfunction

function! GetTagSearchBaseDir()
    let l:search_base_dir=input("base_dir : ")
    if(isdirectory(l:search_base_dir))
        let s:search_base_dir=l:search_base_dir
    else
        let s:search_base_dir="."
    endif
endfunction
