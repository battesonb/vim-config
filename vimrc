" Byron Batteson
" This file automatically folds all secions. Use 'za' to unfold a section.

" Shortcuts {{{
let mapleader=","       " leader is comma
" }}}
" Behavior {{{
set bs=2                  " enable expected backspace behaviors
set ruler                 " show row and column number in the status bar
set ttimeoutlen=50        " reduce timeout for Vim to determine if the terminal will use an escape sequence
filetype plugin indent on " keep indent based on file-type

if has('mouse')
  set mouse=a
endif
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
set guifont=JetBrains_Mono:h12:cANSI:qDRAFT
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
set number              " show line number for current line
set relativenumber      " show relative line numbers
set showcmd             " show last command in status bar
" set cursorline          " highlight current line
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when there is a visual change
set showmatch           " highlight matching [{()}]
set laststatus=2        " show the status line
" }}}
" Plugins {{{
" lightline {{{
function! LightlineCocStatus()
    return get(g:, 'coc_status', '')
endfunction

let s:indicator_warnings = get(g:, 'lightline_indicator_warnings', '•')
let s:indicator_errors = get(g:, 'lightline_indicator_errors', '×')

function! LightlineCocErrors()
    if s:isHidden()
        return ''
    endif
    let l:counts = s:count('error')
    return l:counts == 0 ? '' : printf(s:indicator_errors . '%d', l:counts)
endfunction

function! LightlineCocWarns()
    if s:isHidden()
        return ''
    endif
    let l:counts = s:count('warning')
    return l:counts == 0 ? '' : printf(s:indicator_warnings . '%d', l:counts)
endfunction

let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste', ],
  \             [ 'readonly', 'filename', 'modified', 'coc_errors', 'coc_warns', 'coc_status' ] ]
  \ },
  \ 'component_expand': {
  \   'coc_errors': 'LightlineCocErrors',
  \   'coc_warns': 'LightlineCocWarns'
  \ },
  \ 'component_function': {
  \   'coc_status': 'LightlineCocStatus'
  \ },
  \ 'component_type': {
  \   'coc_errors': 'error',
  \   'coc_warns': 'warning'
  \ }
  \ }


function! s:count(level) abort
  let info = get(b:, 'coc_diagnostic_info', {})
    return get(info, a:level, 0)
endfunction

function! s:isHidden()
  return exists('*lightline#sensible#isHidden') && lightline#sensible#isHidden()
endfunction

autocmd User CocStatusChange call lightline#update()
autocmd User CocDiagnosticChange call lightline#update()
" }}}
" NERDTree {{{
" toggle nerdtree with ctrl+n
map <C-n> :NERDTreeToggle<CR>

" close vim if nerdtree is the only open window 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}
" coc {{{
" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim', 'help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Apply code action to selected code
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" }}}
" CtrlP {{{
" custom ignore
if has('win32')
  set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*\\node_modules\\*
else
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*
endif

" use faster searching methods if they are available
if isdirectory('./.git')
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --others --exclude-standard']
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
" Meta Configuration {{{
set modeline
set modelines=2
" vim:foldmethod=marker:foldlevel=0
" }}}
