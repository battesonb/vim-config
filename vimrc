" Byron Batteson
" This file automatically folds all secions. Use 'za' to unfold a section.

" Behavior {{{
set bs=2                " enable expected backspace behaviors
" }}}
" Colors {{{
syntax enable           " enable syntax processing
colorscheme molokai     " set theme
" }}}
" Folding {{{
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level
" }}}
" Formatting {{{
set encoding=UTF-8      " use utf-8 encoding
" }}}
" Searching {{{
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" }}}
" Shortcuts {{{
let mapleader=","       " leader is comma
" }}}
" Spacing {{{
set tabstop=4           " number of visual spaces per tab
set softtabstop=4       " number of spaces in tab when editing
set expandtab           " tabs are spaces
" }}}
" User Interface {{{
set number              " show line numbers
set showcmd             " show last command in status bar
set cursorline          " highlight current line
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when there is a visual change
set showmatch           " highlight matching [{()}]
set laststatus=2        " show the status line
" }}}
" Plugins {{{
" NERDTree {{{
" toggle nerdtree with ctrl+n
map <C-n> :NERDTreeToggle<CR>

" close vim if nerdtree is the only open window 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}
" CtrlP {{{
" use faster searching methods if they are available
if isdirectory('./.git')
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard']
elseif executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
elseif executable('ag')
  let g:ctrlp_user_command = 'ag -l --nocolor -g "" %s'
endif
" }}}
" }}}
" Meta Configuration {{{
set modeline
set modelines=2
" vim:foldmethod=marker:foldlevel=0
" }}}
