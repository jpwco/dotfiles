" :PlugInstall to install
call plug#begin('~/.vim/plugged')
" plugins
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'quanganhdo/grb256'
Plug 'kien/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'guns/vim-clojure-static'
Plug 'csexton/trailertrash.vim'
Plug 'tfnico/vim-gradle'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-commentary'
Plug 'rking/ag.vim'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'xingchaoet/TLAPlus'
Plug 'digitaltoad/vim-jade'
Plug 'derekwyatt/vim-scala'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'lrampa/vim-apib'
Plug 'ebfe/vim-racer'
Plug 'fatih/vim-go'
Plug 'hynek/vim-python-pep8-indent'
Plug 'tmhedberg/SimpylFold'
Plug 'mattn/emmet-vim'
Plug 'tell-k/vim-autopep8'
Plug 'Rykka/riv.vim'
Plug 'pearofducks/ansible-vim'
Plug 'scrooloose/syntastic'
Plug 'majutsushi/tagbar'
Plug 'ervandew/supertab'
Plug 'elzr/vim-json'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-unimpaired'
call plug#end()

" configs
syntax on
colorscheme grb256

"
" sets
"

" save before make
set autowrite

set encoding=utf-8

" word wrap
set textwidth=80
" disabled for now
"set formatoptions+=ta
set formatoptions-=t


" Highlight current line
set cursorline

" mouse scrolling
set mouse=a

" Use system clipboard
set clipboard=unnamed

" line numbering
set number

" Needed for airline to show
set laststatus=2

"
" tabs
"
" insert 4 spaces when hiting tab
set expandtab
set tabstop=4
" number of spaces four indent
set shiftwidth=4

" allow switching buffers with unsaved file
set hidden

" Code folding
set foldmethod=syntax
set nofoldenable
" Set a high fold level so it doesn't fold by default
set foldlevel=10

" Add go linter to runtime path
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim



"
" File type fun
"


au BufRead,BufNewFile *.ftl set filetype=html
au BufRead,BufNewFile *.mdk set filetype=markdown
au BufRead,BufNewFile *.pmd set filetype=markdown


" fold by indent in html
autocmd BufNewFile,BufReadPost *.ftl setl foldmethod=indent nofoldenable
autocmd BufNewFile,BufReadPost *.html setl foldmethod=indent nofoldenable

" xml
au FileType xml setlocal foldmethod=syntax


"
"
"
" http://vim.wikia.com/wiki/Automatically_open_the_quickfix_window_on_:make
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Lint and vet go files on save
" vim go does this already, dont' need to do it explicitly
" autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow

" Jump to the last position in the file
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$")  && expand("%:t") != "COMMIT_EDITMSG" |
    \   exe "normal g`\"" |
    \ endif

" PEP8 settings for Python files
au BufRead,BufNewFile *.py set
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ textwidth=79
    \ expandtab
    \ autoindent
    \ fileformat=unix

" I removed flake8, syntastic should do this instead
" autocmd BufWritePost,FileWritePost *.py call Autopep8() | call Flake8()
" autocmd BufWritePost,FileWritePost *.py call Autopep8()

" make test
au FileType python nmap <leader>t :make test<CR>

" go test
au FileType go nmap <leader>t <Plug>(go-test)


"
" lets
"

let mapleader = ","

" airline
let g:airline_powerline_fonts = 1
" show tabline at the top
let g:airline#extensions#tabline#enabled = 1

" disable mapping of tab and shift-tab in riv
let g:riv_ignored_nmaps = "<Tab>,<S-Tab>"

let &t_te="\<Esc>]50;CursorShape=2\x7"


" https://github.com/kien/ctrlp.vim/issues/273
" https://github.com/kien/ctrlp.vim/issues/174
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

"let g:ctrlp_custom_ignore = {
"   \ 'dir': '\v[\/]build$|venv$|__pycache__$',
"   \ 'file': '\.pyc$'
"   \ }

" Don't show autopep8 diff window
let g:autopep8_disable_show_diff=1

" Long lines are fine
let g:autopep8_ignore="E501"

" goimports instead of gofmt
let g:go_fmt_command = "goimports"

" Run tests in a new terminal
" let g:go_term_enabled = 1

let g:xml_syntax_folding=1

" Disable syntastic on go
" let g:syntastic_mode_map = { 'passive_filetypes': ['go'] }

" This has no effect when go disabled on syntastic
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']

let g:tagbar_left=1

" SuperTab tab completion
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

let g:syntastic_python_checkers = ["flake8"]

" Use QuickFix window instead of location list to avoid conflicts with
" syntastic. For more details, see:
" https://github.com/scrooloose/syntastic/issues/1650
" https://github.com/fatih/vim-go/issues/814
let g:go_list_type = "quickfix"

" Recommended by https://github.com/guns/vim-clojure-static
filetype plugin indent on
"
" remaps
"


" Copy the directory name to clipboard
noremap <leader>d :let @+ = expand("%")<cr>
" Full directory
noremap <leader>D :let @+ = expand("%:p")<cr>

noremap <leader>m :make<cr>
noremap <leader>T :make test<cr>

" Close the buffer
nmap <leader>b :bdelete<CR>

" Cycle through buffers
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>

" jump back to the last buffer
map ,, <C-^>

" toggle relative numbers
nnoremap <leader>n :set relativenumber! relativenumber?<CR>
nnoremap <C-n> :set relativenumber! relativenumber?<CR>

" Jump to ctag
nnoremap <leader>. :CtrlPTag<cr>

" turn off highlight when hitting return
" This interferes with following file names in the mini window thing
" :noremap <CR> :nohlsearch<cr>

"
" commands (?)
"

com! Vimrc tabnew | e ~/.nvimrc
com! Zshrc tabnew | e ~/.zshrc

" Call the script named instance
" See: https://gist.github.com/lorin/0719235506acc6762f30
com! Instance silent !instance > /dev/null

" jsonlint
" npm install jsonlint -g
com! JSON %!jsonlint

"
" abbrevations
"
"

cabbrev vimrc Vimrc
cabbrev nvimrc Vimrc
cabbrev Tr TrailerTrim
cabbrev ag Ag
cabbrev in Instance

"
" Functions
"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
"
" From Gary Bernhardt's vimrc: https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
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



