" vimrc
"
set nocompatible
filetype off

let mapleader = ","
let maplocalleader = "\\"

" VUNDLE {{{
let s:bundle_path=$HOME."/.vim/bundle/"
execute "set rtp+=".s:bundle_path."vundle/"
call vundle#rc()

Bundle 'gmarik/vundle'
" }}}

" PACKAGES {{{

" _. General {{{
    Bundle "mileszs/ack.vim"
    nnoremap <leader>a :Ack!<space>

    Bundle 'tpope/vim-surround'
    Bundle 'kana/vim-textobj-user'
    Bundle 'michaeljsmith/vim-indent-object'
    let g:indentobject_meaningful_indentation = ["haml", "sass", "python", "yaml", "markdown"]

    Bundle 'kien/ctrlp.vim'
    let g:ctrlp_working_path_mode = ''

    Bundle 'troydm/easybuffer.vim'
    nmap <leader>be :EasyBufferToggle<enter>
" }}}

" _. Fancy {{{
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    let g:airline_enable_branch     = 1
    let g:airline_enable_syntastic  = 1
    let g:airline_powerline_fonts = 1
    let g:airline_theme = 'bubblegum'
    let g:airline_symbols = {}
    " unicode symbols
"     let g:airline_left_sep = '▙'bubblegum
"     let g:airline_right_sep = '▟'
"     let g:airline_symbols.linenr = '␤'
"     let g:airline_symbols.branch = '⎇'
"     let g:airline_symbols.paste = 'ρ'
"     let g:airline_symbols.whitespace = 'Ξ'
"     let g:airline_symbols.readonly = 'RO'
" }}}

" _. Coding {{{


    autocmd FileType gitcommit set tw=68 spell
    autocmd FileType gitcommit setlocal foldmethod=manual

    " Syntax check
    Bundle 'scrooloose/syntastic'
    let g:syntastic_enable_signs=1
    let g:syntastic_auto_loc_list=1
    let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': ['html', 'slim'] }

" }}}

" _. Python {{{
    Bundle 'klen/python-mode'
    Bundle 'python.vim'
    Bundle 'python_match.vim'
    Bundle 'pythoncomplete'
" }}}

" _. HTML {{{
    Bundle 'tpope/vim-markdown'

    au FileType html setl shiftwidth=2 tabstop=2 softtabstop=2 expandtab
" }}}

" _. JS {{{

    Bundle 'pangloss/vim-javascript'
    Bundle 'jelera/vim-javascript-syntax'
    Bundle 'othree/javascript-libraries-syntax.vim'

    au FileType javascript setl tabstop=2 softtabstop=2 shiftwidth=2 expandtab foldmethod=indent
    au BufNewFile,BufReadPost *.json setl tabstop=2 softtabstop=2 shiftwidth=2 expandtab
" }}}
"
" _. Color {{{
    Bundle 'jpo/vim-railscasts-theme'
    set background=dark
    colorscheme railscasts
" }}}

" _. Go {{{
    Plugin 'fatih/vim-go'
    au FileType go setl shiftwidth=2 tabstop=2 softtabstop=2
" }}}

" }}}

" General {{{
filetype plugin indent on

syntax on

" Set 5 lines to the cursor - when moving vertically
set scrolloff=0

" It defines where to look for the buffer user demanding (current window, all
" windows in other tabs, or nowhere, i.e. open file from scratch every time) and
" how to open the buffer (in the new split, tab, or in the current window).

" This orders Vim to open the buffer.
set switchbuf=useopen

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}

" Mappings {{{

" Yank content in OS's clipboard. `o` stands for "OS's Clipoard".
vnoremap <leader>yo "*y
" Paste content from OS's clipboard
nnoremap <leader>po "*p

" clear highlight after search
noremap <silent><Leader>/ :nohls<CR>

" better ESC
inoremap <C-k> <Esc>

" faster save
inoremap jj <Esc>:w<CR>

" Fast saving and closing current buffer without closing windows displaying the
" buffer
nmap <leader>wq :w!<cr>:Bclose<cr>

" Map F2 to change tab to spaces
map <F2> :set expandtab<CR>:retab<CR>
map <Leader>s :%!git stripspace<CR>
" }}}

" Settings {{{
set autoread
set backspace=indent,eol,start
set binary
set cinoptions=:0,(s,u0,U1,g0,t0
set completeopt=menuone,preview
set encoding=utf-8
set hidden
set history=1000
set incsearch
set laststatus=2
set list

" Don't redraw while executing macros
set nolazyredraw

" Disable the macvim toolbar
set guioptions-=T

set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:␣
set showbreak=↪

set notimeout
set ttimeout
set ttimeoutlen=10

" _ backups {{{
set undodir=~/.vim/tmp/undo//     " undo files
set undofile
set undolevels=3000
set undoreload=10000
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup
set noswapfile
" _ }}}

set modelines=0
set noeol
set relativenumber
set numberwidth=3
set winwidth=83
set ruler
if executable('/bin/zsh')
  set shell=/bin/zsh
endif
set showcmd

set exrc
set secure

set matchtime=2

set completeopt=longest,menuone,preview

" White characters {{{
set autoindent
set tabstop=4
set softtabstop=4
set textwidth=80
set shiftwidth=4
set expandtab
set wrap
set formatoptions=qrn1
set colorcolumn=+1
" }}}

set visualbell

set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc,tmp,*.scssc
set wildmenu

set dictionary=/usr/share/dict/words
" }}}

" Triggers {{{

" Save when losing focus
au FocusLost    * :silent! wall
"
" When vimrc is edited, reload it
autocmd! BufWritePost vimrc source ~/.vimrc

" }}}

" Cursorline {{{
" Only show cursorline in the current window and in normal mode.
augroup cline
    au!
    au WinLeave * set nocursorline
    au WinEnter * set cursorline
    au InsertEnter * set nocursorline
    au InsertLeave * set cursorline
augroup END
" }}}

" Trailing whitespace {{{
" Only shown when not in insert mode so I don't go insane.
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:␣
    au InsertLeave * :set listchars+=trail:␣
augroup END

" Remove trailing whitespaces when saving
" Wanna know more? http://vim.wikia.com/wiki/Remove_unwanted_spaces
" If you want to remove trailing spaces when you want, so not automatically,
" see
" http://vim.wikia.com/wiki/Remove_unwanted_spaces#Display_or_remove_unwanted_whitespace_with_a_script.
autocmd BufWritePre * :%s/\s\+$//e
" }}}

" . searching {{{

" sane regexes
nnoremap / /\v
vnoremap / /\v

set ignorecase
set smartcase
set showmatch
set gdefault
set hlsearch

" clear search matching
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" Don't jump when using * for search
nnoremap * *<c-o>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>? :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Highlight word {{{

nnoremap <silent> <leader>hh :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h1 :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h2 :execute '2match InterestingWord2 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h3 :execute '3match InterestingWord3 /\<<c-r><c-w>\>/'<cr>

" }}}

" }}}

" Navigation & UI {{{

" more natural movement with wrap on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Easy splitted window navigation
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l

" Splits ,v and ,h to open new splits (vertical and horizontal)
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>h <C-w>s<C-w>j

" Bubbling lines
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv

" }}}

" . folding {{{

set nofoldenable    " disable folding
set foldlevelstart=0
set foldmethod=syntax

" Space to toggle folds.
nnoremap <space> za
vnoremap <space> za

" Make zO recursively open whatever top level fold we're in, no matter where the
" cursor happens to be.
nnoremap zO zCzO

" Use ,z to "focus" the current fold.
nnoremap <leader>z zMzvzz

" }}}

" _ Vim {{{
augroup ft_vim
    au!

    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END
" }}}

" EXTENSIONS {{{

" _. Buffer Handling {{{
source ~/.vim/functions/buffer_handling.vim
" }}}

" _. Tab {{{
source ~/.vim/functions/insert_tab_wrapper.vim
" }}}

" _. Text Folding {{{
source ~/.vim/functions/my_fold_text.vim
" }}}

" }}}

" Load addidional configuration (ie to overwrite shorcuts) {{{
if filereadable(expand("~/.vim/after.vimrc"))
  source ~/.vim/after.vimrc
endif
" }}}