" from http://unix.zentus.com/vimrc.html - 2005-08-12

let c_space_errors = 1 " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
set nocompatible " breaks compatibility with original vi
set backspace=indent,eol,start " allow backspace in insert mode
set visualbell    " blinks instead of beeping
set autoindent    " text indenting
set smartindent   " as above
if 0 "luajit
  set tabstop=8     " number of spaces in a tab
  set softtabstop=8 " as above
  set shiftwidth=8  " as above
  set noexpandtab   " never turn tabs into spaces
else
  set tabstop=2     " number of spaces in a tab
  set softtabstop=2 " as above
  set shiftwidth=2  " as above
  set expandtab     " always turn tabs into spaces
endif
"set expandtab     " always turn tabs into spaces. (you might want smarttab)
"colorscheme blue  " make blue the default colorscheme
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
if has("win32")
    set columns=120
    set lines=40
endif

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

set background=light
hi Search cterm=NONE ctermfg=grey ctermbg=blue

if &diff
	colorscheme blue
  set cc=
else
	colorscheme torte
endif

" alias on command mode:
command B :buffers

"
" Vundle configuration
"
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/ctrlp.vim'
Plugin 'vim-scripts/DoxygenToolkit.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
