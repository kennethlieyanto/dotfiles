" Set leader key
let mapleader = " "

" Move selected lines up and down in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Center screen when scrolling
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Center the cursor when searching
nnoremap n nzzzv
nnoremap N Nzzzv

" Paste without overwriting the clipboard in visual mode
xnoremap <leader>p "_dP

" Copy to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y

" Exit insert mode with Ctrl+C
inoremap <C-c> <Esc>
