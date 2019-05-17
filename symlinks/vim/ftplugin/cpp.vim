"Run current file
map ® :!clang++ % -o ____a.out -O2 -Wall -std=c++11 -isystem /usr/local/include<Enter>
map <C-R> :!./____a.out <Enter>


let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -isystem /usr/local/include'
