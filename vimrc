" General syntax
syntax on
set number
colorscheme gruvbox
set background=dark

set number

set backspace=indent,eol,start

" http://vim.wikia.com/wiki/Indenting_source_code
set expandtab			    " When press <TAB> key, insert 'softtabstop' amount of space
set shiftwidth=4		    " Affects when press >>, << or ==
set softtabstop=4		    " Set it the same sa shiftwidth when using SPACE indention
				    " , default value is the same as 'tabstop'
set smartindent                     " Copy indentation from previous line
                                    " , and add extra level in some cases

set nowrap                          " Don't wrap lines

autocmd BufWritePre * :%s/\s\+$//e  " Delete all trailing whitespaces on save


" The begining of Vunble

set nocompatible		    " be iMproved, required
filetype off			    " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" formats to install plugins on Github
Plugin 'scrooloose/nerdtree'
" NERDTree toggle
map <C-n> :NERDTreeToggle<CR>

Plugin 'bling/vim-airline'

" Plugin 'scrooloose/syntastic'
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" let g:syntastic_java_checkers = ['checkstyle']
" let g:syntastic_java_checkstyle_classpath = "/Users/linwei/.vim/checkstyle-6.3-all.jar"

" Plugin 'ervandew/supertab'

Plugin 'kien/ctrlp.vim'
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'

call vundle#end()		    " required
filetype plugin indent on	    " required
