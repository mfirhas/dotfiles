filetype on

filetype plugin on

filetype indent on

syntax on

" line number
set number
set relativenumber

" keys maps
nnoremap $ ^
nnoremap ^ $
nnoremap <leader>' :botright term<CR>

let g:netrw_liststyle=3

set hlsearch

command! Q :bufdo bd | :tabonly | :only | :NERDTreeClose

" plugins installations
" using: https://github.com/junegunn/vim-plug
call plug#begin()

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'

call plug#end()

" nerdtree ignore
let NERDTreeGitIgnore = 1
let NERDTreeIgnore = [
      \ '\.pyc$', '\.o$', '\.swp$',
      \ '\.DS_Store$', '\.log$',
      \ '/node_modules$', '/vendor$',
      \ '/build$', '/dist$', '/out$',
      \ '/venv$', '/env$',
      \ '/.idea$', '/.vscode$',
      \ '/.tmp$', '/temp$',
      \ '/yarn.lock$', '/package-lock.json$',
      \ '/.env$',
      \ '\.sqlite$', '\.db$'
      \ ]

" plugins configs
" start nerdtree only when open on a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
" Enable the git branch status
let g:airline#extensions#branch#enabled = 1


