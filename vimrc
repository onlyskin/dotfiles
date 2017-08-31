execute pathogen#infect()

filetype plugin indent on

" make nerdtree open automatically
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:auto_save = 1  " enable AutoSave on Vim startup

let mapleader=","
:imap ii <Esc>

" java test
:nmap m :!<Space>gradle<Space>test<Space>--info<CR>
" python test
" :nmap m :!python<SpacE>manage.py<Space>test<CR>

" remap half page up and half page down
:nmap <C-J> <C-D>
:nmap <C-K> <C-U>

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

colorscheme base16-default-dark

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
  call SelectaCommand("find " . a:path . "/* -type f -and -iname '" . a:glob . "' -and -not -iname '*.pyc' -and -not -iname '*.swp' -and -not -iname '*.DS_Store'", "", ":e")
endfunction

nnoremap <leader>f :call SelectaFile(".", "*")<cr>
nnoremap <leader>gt :call SelectaFile("src", "*")<cr>

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
      \ "Rakefile" : {
      \ "app/*.rb" : {"alternate": "spec/{}_spec.rb",
      \               "type": "app"},
      \ "lib/*.rb" : {"alternate": "spec/{}_spec.rb",
      \               "type" : "lib"},
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
      \ "project.clj" : {
      \ "src/*.clj": {"alternate": "spec/{}_spec.clj",
      \               "type": "src"},
      \ "spec/*_spec.clj": {"alternate": "src/{}.clj",
      \                     "type": "spec"}
      \ },
      \ "build.boot" : {
      \ "src/*.cljs": {"alternate": "test/{}_test.cljs",
      \               "type": "src"},
      \ "test/*_test.cljs": {"alternate": "src/{}.cljs",
      \                     "type": "test"}
      \ }
      \ }
