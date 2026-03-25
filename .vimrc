" --- Don's Termux/Ubuntu friendly .vimrc (clean) ---

scriptencoding utf-8
set nocompatible
set encoding=utf-8
set hidden
set mouse=a
set number relativenumber
set numberwidth=1
set clipboard=unnamedplus
set showcmd ruler
set cursorline cursorcolumn
set showmatch
set sw=2 ts=2 expandtab
set laststatus=2 noshowmode
set hlsearch
set splitbelow splitright
set fillchars=vert:\|

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'Yggdroot/indentLine'
Plug 'luochen1990/rainbow'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'tpope/vim-commentary'
Plug 'ap/vim-css-color'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }
Plug 'mattn/emmet-vim'
Plug 'vimwiki/vimwiki'
" Auto-commit vimwiki on save
autocmd BufWritePost ~/vimwiki/*.wiki silent! execute '!cd ~/vimwiki && git add -- "%" && git commit -m "Update %" && git push &'
Plug 'mlaursen/vim-react-snippets'
Plug 'mlaursen/mlaursen-vim-snippets'
call plug#end()

" Keymaps
let mapleader=" "
nmap <Leader>s <Plug>(easymotion-s2)
nmap <Leader>nt :NERDTreeFind<CR>
nnoremap <Leader>f m'gg=G`'
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>
nmap <Leader>b :NoBackground<CR>
nnoremap <leader>g :set background=dark<CR>
"arrow function
iab arrf () => {} <left><left> <BS>
"< and > for different keyboards
inoremap <Leader>,, <LT>
inoremap <Leader>.. >
nnoremap <leader>ff :Files!<CR>
nnoremap <leader>fl :BLines!<CR>
"Buffer navigation
nnoremap <Leader>k :bnext<CR>
nnoremap <Leader>j :bprevious<CR>

" CoC + snippets
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ getline('.')[col('.')-2] =~# '\s' ? "\<TAB>" : coc#refresh()
let g:coc_snippet_next = '<tab>'
let g:coc_disable_startup_warning = 1
" NERDTree auto-refresh (simplified)
autocmd BufEnter NERD_tree_* normal R
"Emmet shortcuts
let g:user_emmet_leader_key=','

"NERDTree window size
let g:NERDTreeWinSize = 25
"NERDTree auto-close
let NERDTreeQuitOnOpen = 1
" Colors & UI
try | colorscheme gruvbox | catch | colorscheme desert | endtry
set background=dark
let g:rainbow_active = 1
let g:gruvbox_contrast_dark = "hard"
command! NoBackground highlight Normal ctermbg=NONE
let g:airline_theme='dark'
let g:airline_powerline_fonts = 1
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1

" Termux-friendly
if !has('gui_running')
  set clipboard=
  set guicursor=
endif

" BookMode — line-by-line book writing format
function! BookModeOn()
  setlocal textwidth=60
  setlocal colorcolumn=60
  setlocal number norelativenumber
  setlocal list
  setlocal nowrap
  setlocal linebreak
  echo "BookMode ON (tw=60, 25 lines/page)"
endfunction

function! BookModeOff()
  setlocal textwidth=0
  setlocal colorcolumn=
  setlocal number relativenumber
  setlocal nolist
  setlocal wrap
  echo "BookMode OFF"
endfunction

command! BookMode call BookModeOn()
command! BookModeOff call BookModeOff()

filetype plugin on
syntax on
