" from http://unix.zentus.com/vimrc.html - 2005-08-12

let c_space_errors = 1 " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
set nocompatible " breaks compatibility with original vi
set backspace=indent,eol,start " allow backspace in insert mode
set visualbell    " blinks instead of beeping
set autoindent    " text indenting
set smartindent   " as above
set expandtab     " always turn tabs into spaces. (you might want smarttab)
set sw=4
set ts=4
set history=100   " lines of command history
set showcmd       " show incomplete commands
set hlsearch      " highlight searched-for phrases
set incsearch     " highlight search as you type
set ruler         " display current line number
set nobackup      " do NOT make backup files
set ignorecase    " easy search
set modeline      " allow footer to tell vim how to configure this file
set textwidth=80  " wrap text after 80th column$
set cc=80         " highlight background of 80th column$
set cino+=(0      " wrap function arguments to align by column of last argument$

" check one time after 4s of inactivity in normal mode
set autoread
au CursorHold * checktime

" show a list when hitting TAB on normal/command mode
set wildmode=list:longest

set runtimepath^=~/.vim/bundle/ctrlp.vim

" line numbers!
set nu

" check for terminal colours then activate syntax highlighting
if &t_Co > 2 || has("gui_running")
  syntax on
endif

if has("autocmd")
  filetype plugin indent on
  autocmd FileType text setlocal textwidth=78

  " always jump to last edit position when opening a file
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
endif

" auto-completion on <tab> keypress
" from: http://vim.sf.net/tips/tip.php?tip_id=102
function InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\"
    else
        return "\"
    endif
endfunction
" inoremap  =InsertTabWrapper()

" Cscope suggested usage from vim's :help cscope-suggestions
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif

"size of gvim
set columns=160
set lines=40

set cscopetag
"map <C-[> :cs find c <cword><CR>
map <C-_> :cstag <C-R>=expand("<cword>")<CR><CR>
map <C-]> :cstag <C-R>=expand("<cword>")<CR><CR>
"map g<C-]> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
"map g<C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space>s :scs find s <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space>g :scs find g <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space>c :scs find c <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space>t :scs find t <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space>e :scs find e <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
"nmap <C-Space>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"nmap <C-Space>d :scs find d <C-R>=expand("<cword>")<CR><CR>

au! BufRead,BufNewFile *.dasc		setfiletype dasc
au! Syntax dasc source $HOME/util/vim-scripts/dasc.vim

" make .ad files to have the syntax highlights of the C language
au! BufRead,BufNewFile *.ad     set syntax=c

hi Search cterm=NONE ctermfg=grey ctermbg=blue

" alias on command mode:
command B :buffers

"
" Vundle configuration
"
" If not installed, run the following:
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
"git interface
Plugin 'tpope/vim-fugitive'
"filesystem
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'

"html
"  isnowfy only compatible with python not python3
"Plugin 'isnowfy/python-vim-instant-markdown'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'suan/vim-instant-markdown'
Plugin 'nelstrom/vim-markdown-preview'
"python sytax checker
Plugin 'nvie/vim-flake8'
"Plugin 'vim-scripts/Pydiction'

Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-syntastic/syntastic'

"auto-completion stuff
"Plugin 'klen/python-mode'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'klen/rope-vim'
"Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
""code folding
Plugin 'tmhedberg/SimpylFold'

"Colors!!!
Plugin 'altercation/vim-colors-solarized'
Plugin 'jnurmine/Zenburn'

" :Search
Plugin 'vim-scripts/MultipleSearch'

" Go
Plugin 'fatih/vim-go'

" Powershell. urgh
Plugin 'PProvost/vim-ps1'

call vundle#end()

filetype plugin indent on    " enables filetype detection
let g:SimpylFold_docstring_preview = 1

"leave code unfolded by default
set foldlevel=99

"autocomplete
let g:ycm_autoclose_preview_window_after_completion=1

"custom keys
let mapleader=" "
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"
call togglebg#map("<F5>")
set background=dark
colorscheme solarized
if &diff
    set cc=
else
    syntax enable
    "let g:solarized_termcolors=256
endif

"set guifont=Monaco:h14

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

"I don't like swap files
set noswapfile

"turn on numbering
set nu

"python with virtualenv support
py3 << EOF
import os.path
import sys
import vim
if 'VIRTUA_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  sys.path.insert(0, project_base_dir)
  activate_this = os.path.join(project_base_dir,'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

"it would be nice to set tag files by the active virtualenv here
":set tags=~/mytags "tags for ctags and taglist
"omnicomplete
autocmd FileType python set omnifunc=pythoncomplete#Complete

" working with go
au BufRead,BufNewFile *.go set textwidth=0
au BufRead,BufNewFile *.go set noexpandtab
au BufRead,BufNewFile *.go set cc=0

" working with json
au BufRead,BufNewFile *.json set cc=0
au BufRead,BufNewFile *.json set textwidth=0
au BufRead,BufNewFile *.json set tabstop=2
au BufRead,BufNewFile *.json set shiftwidth=2
au BufRead,BufNewFile *.json set expandtab
au BufRead,BufNewFile *.json set softtabstop=2

"------------Start Python PEP 8 stuff----------------
" Number of spaces that a pre-existing tab is equal to.
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=2

"spaces for indents
au BufRead,BufNewFile *.py,*pyw set shiftwidth=2
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py set softtabstop=2
au BufRead,BufNewFile *.py set textwidth=79
au BufRead,BufNewFile *.py set cc=79

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Use UNIX (\n) line endings.
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

" Set the default file encoding to UTF-8:
set encoding=utf-8

" For full syntax highlighting:
let python_highlight_all=1
syntax on

" Keep indentation level from previous line:
autocmd FileType python set autoindent

" make backspaces more powerfull
set backspace=indent,eol,start


"Folding based on indentation:
autocmd FileType python set foldmethod=indent
"use space to open folds
"nnoremap <space> za " disabled as I false hit this more often than wanting to
"----------Stop python PEP 8 stuff--------------
