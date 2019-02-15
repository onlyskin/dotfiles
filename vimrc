execute pathogen#infect()

filetype plugin indent on

let mapleader="'"

:nmap <C-J> <C-D>
:nmap <C-K> <C-U>

set tabpagemax=100

" Detect elm files
au BufRead,BufNewFile *.elm set filetype=elm

"infinite undo
set undofile
set undodir=~/.vim/undodir

let base16colorspace=256
set t_Co=256
colorscheme base16-unikitty-dark

"disable arrow keys
" noremap  <Up> ""
" noremap! <Up> <Esc>
" noremap  <Down> ""
" noremap! <Down> <Esc>
" noremap  <Left> ""
" noremap! <Left> <Esc>
" noremap  <Right> ""
" noremap! <Right> <Esc>

set number
syntax on
set autoindent
set shiftwidth=4
set expandtab
set smartindent
set tabstop=4
set guicursor=i:ver25-iCursor
set noswapfile
set colorcolumn=80
set backspace=indent,eol,start

autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
autocmd Filetype json setlocal ts=2 sw=2 expandtab
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype css setlocal ts=2 sw=2 expandtab
autocmd Filetype cpp setlocal ts=2 sw=2 expandtab
autocmd Filetype eruby setlocal ts=2 sw=2 expandtab
autocmd Filetype clojure setlocal lispwords+=describe,it

" MULTIPURPOSE TAB KEY
" source: https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

" source: https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
" to install: brew install selecta (https://github.com/garybernhardt/selecta)
" Selecta Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
    " Escape spaces in the file name. That ensures that it's a single argument
    " when concatenated with vim_command and run with exec.
    let selection = substitute(selection, ' ', '\\ ', "g")
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

function! SelectaFile(path, glob)
  call SelectaCommand("find " . a:path . "/* -type f -and -iname '" . a:glob . "' -and -not -iname '*.pyc' -and -not -iname '*.swp' -and -not -iname '*.DS_Store' -and -not -iname 'node_modules/*'", "", ":e")
endfunction

nnoremap <leader>f :call SelectaFile(".", "*")<cr>

"Fuzzy select
function! SelectaIdentifier()
  " Yank the word under the cursor into the z register
  normal "zyiw
  " Fuzzy match files in the current directory, starting with the word under
  " the cursor
  call SelectaCommand("find * -type f", "-s " . @z, ":e")
endfunction

nnoremap <c-g> :call SelectaIdentifier()<cr>

" PROJECTIONIST HEURISTICS
" source: https://github.com/dirv/dotfiles/blob/master/vimrc
let g:projectionist_heuristics = {
      \ "Gemfile" : {
      \ "app/*.rb" : {"alternate": "spec/{}_spec.rb",
      \               "type": "app"},
      \ "lib/*.rb" : {"alternate": "spec/{}_spec.rb",
      \               "type" : "lib"},
      \ },
      \ "spec/" : {
      \ "spec/controllers/*_spec.rb" : {"alternate": "app/controllers/{}.rb",
      \                                 "type": "cspec"},
      \ "js/*.js" : {"alternate": "spec/{}_spec.js",
      \              "type" : "lib"},
      \ "spec/*_spec.js" : {"alternate": "js/{}.js",
      \                     "type" : "spec"},
      \ "spec/*_spec.rb" : {"alternate": "lib/{}.rb",
      \                     "type" : "spec"},
      \ },
      \ "src/main/java/" : {
      \ "src/main/java/*.java": {"alternate": "src/test/java/{}Test.java",
      \                          "type": "src"},
      \ "src/test/java/*Test.java": {"alternate": "src/main/java/{}.java",
      \                          "type": "spec"},
      \ },
      \ "requirements.txt" : {
      \ "**/src/*.py": {"alternate": "{dirname}/tests/test_{basename}.py",
      \                          "type": "src"},
      \ "**/tests/test_*.py": {"alternate": "{dirname}/src/{basename}.py",
      \                          "type": "spec"},
      \ "lib/*.py": {"alternate": "tests/lib/test_{}.py",
      \                          "type": "src"},
      \ "tests/lib/test_*.py": {"alternate": "lib/{}.py",
      \                          "type": "spec"},
      \ },
      \ "project.clj" : {
      \ "src/*.clj": {"alternate": "spec/{}_spec.clj",
      \               "type": "src"},
      \ "spec/*_spec.clj": {"alternate": "src/{}.clj",
      \                     "type": "spec"},
      \ "src/*.cljs": {"alternate": "spec/{}_spec.cljs",
      \               "type": "src"},
      \ "spec/*_spec.cljs": {"alternate": "src/{}.cljs",
      \                     "type": "test"},
      \ },
      \ "package.json" : {
      \   "src/*.js": {"alternate": "spec/{}_spec.js"},
      \   "spec/*_spec.js": {"alternate": "src/{}.js"}
      \ },
      \ "tsconfig.json" : {
      \   "src/*.ts": {"alternate": "spec/{}_spec.ts"},
      \   "spec/*_spec.ts": {"alternate": "src/{}.ts"}
      \ },
      \ }

" Tmp files go in one place
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
