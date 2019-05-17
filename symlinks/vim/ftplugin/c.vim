if (&ft != 'c')
    finish
endif
"Run current file
map ® :!clang % -o ____a.out -O2 -Wall -std=c11<Enter>
map <C-R> :!./____a.out <Enter>


let g:syntastic_cpp_compiler = 'clang'
"let g:syntastic_cpp_compiler_options = ' -std=c11'
