" Byron Batteson
" This file automatically folds all secions. Use 'za' to unfold a section.

" Shortcuts {{{
let mapleader=","       " leader is comma
" }}}
" Behavior {{{
set bs=2                  " enable expected backspace behaviors
set ruler                 " show row and column number in the status bar
filetype plugin indent on " keep indent based on file-type
" }}}
" Colors {{{
syntax enable           " enable syntax processing
colorscheme molokai     " set theme
if has('win32')
  set termguicolors
endif
" }}}
" Folding {{{
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level
" }}}
" Formatting {{{
set encoding=UTF-8      " use utf-8 encoding
set tw=80               " set text width to 80 characters
" }}}
" Searching {{{
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ic                  " turn on ignore case mode
" turn off search highlight
nnoremap <Leader><space> :nohlsearch<CR>
" }}}
" Spacing {{{
set tabstop=4           " number of visual spaces per tab
set softtabstop=4       " number of spaces in tab when editing
set expandtab           " tabs are spaces
set shiftwidth=4        " shift width is the same as our tab size
" }}}
" User Interface {{{
set number              " show line numbers
set showcmd             " show last command in status bar
" set cursorline          " highlight current line
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when there is a visual change
set showmatch           " highlight matching [{()}]
set laststatus=2        " show the status line
" }}}
" Plugins {{{
" ALE {{{
let g:ale_fixers = {
\   "javascript": ["eslint"],
\   "rust": ["rustfmt"],
\ }

let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_linters = {
\   "rust": ["rls"],
\ }
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '🟡'
" }}}
" NERDTree {{{
" toggle nerdtree with ctrl+n
map <C-n> :NERDTreeToggle<CR>

" close vim if nerdtree is the only open window 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}
" CtrlP {{{
" custom ignore
if has('win32')
  set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*\\node_modules\\*
elseif
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*
endif

" use faster searching methods if they are available
if isdirectory('./.git')
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard']
elseif has('win32')
  let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'
elseif executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
elseif executable('ag')
  let g:ctrlp_user_command = 'ag -l --nocolor -g "" %s'
endif
" }}}
" clang_complete {{{
let g:clang_library_path="/usr/lib/llvm-10/lib"
" }}}
" rust.vim {{{
let g:rustfmt_autosave=1
" }}}
" YouCompleteMe {{{
"execute "packadd YouCompleteMe"
" }}}
" Meta Configuration {{{
set modeline
set modelines=2
" vim:foldmethod=marker:foldlevel=0
" }}}
