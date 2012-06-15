set nocompatible
syntax on

filetype off
call pathogen#infect()
filetype plugin indent on

set history=10000
set number
set showmatch
set incsearch
set hlsearch
set background=dark
set hidden
set backspace=indent,eol,start
set textwidth=0
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set ignorecase smartcase
set cursorline
set wrap
set noswapfile
set bs=2

" Highlight trailing whitespace
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/

" Set up highlight group & retain through colorscheme changes
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
map <silent> <LocalLeader>ws :highlight clear ExtraWhitespace<CR>

" Highlight too-long lines
autocmd BufRead,InsertEnter,InsertLeave * 2match LineLengthError /\%126v.*/
highlight LineLengthError ctermbg=black guibg=black
autocmd ColorScheme * highlight LineLengthError ctermbg=black guibg=black

:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

if &t_Co == 256
  colorscheme Tomorrow-Night
endif

" Keymaps

nmap , \
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nf :NERDTreeFind<CR>
map <silent> <LocalLeader>nh :nohls<CR>
map <silent> <LocalLeader>t :CommandT<CR>
map <silent> <LocalLeader>cf :CommandTFlush<CR>
map <silent> <LocalLeader>cb :CommandTBuffer<CR>
map <silent> <LocalLeader>cj :CommandTJump<CR>
map <silent> <LocalLeader>ct :CommandTTag<CR>
imap <C-L> <SPACE>=><SPACE>

function! Trim()
  exe "normal mz"
  %s/\s*$//
  exe "normal `z"
  exe "normal zz"
endfunction

command! -nargs=0 Trim :call Trim()
nnoremap <silent> <Leader>tw :Trim<CR>

let g:CommandTAcceptSelectionSplitMap=['<C-s>']
let g:CommandTAcceptSelectionVSplitMap=['<C-v>']
let g:CommandTCancelMap=['<Esc>', '<C-c>']
let g:CommandTMaxHeight=10
