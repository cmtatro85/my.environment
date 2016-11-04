" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below. If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed. It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" ancomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'. Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
" set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on
set nocursorcolumn
set nocursorline
set norelativenumber
syntax sync minlines=50
syntax sync maxlines=100
set synmaxcol=1000

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
" au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
" \| exe "normal g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
"if has("autocmd")
" filetype indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd " Show (partial) command in status line.
"set showmatch " Show matching brackets.
set ignorecase " Do case insensitive matching
"set smartcase " Do smart case matching
"set incsearch " Incremental search
"set autowrite " Automatically save before commands like :next and :make
"set hidden " Hide buffers when they are abandoned
"set mouse=a " Enable mouse usage (all modes) in terminals

" Source a global configuration file if available
" XXX Deprecated, please move your changes here in /etc/vim/vimrc
if file_readable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" SET SOME VARS UP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitbelow
set splitright
set number
set ai " auto indent
set tags=./TAGS;
set nocompatible " Disable vi-compatibility
set laststatus=2 " Always show the statusline
set t_Co=256 " Explicitly tell vim that the terminal has 256 colors

" Set tabs to spaces
set et
set sw=4
set sts=2
set smarttab

let php_folding = 1
let html_folding = 0
let yml_folding = 0

" Match capitalization of tags
let b:unaryTagsStack = 1

" Show trailing spaces
set list
set listchars=trail:#

" Set the text width
" set textwidth=80
"
autocmd BufEnter * set title
let &titlestring="[ ".strftime("%c")." ]    ". $USER ."@". hostname() .":" ." %F"

:au Filetype twig,html,xml,xsl,php source ~/.vim/plugged/closetag.vim/plugin/closetag.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""LETS SETUP SOME MAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set space to toggle fold/unfold
nnoremap <silent> <S-Tab> :set foldmethod=indent <CR> :exe 'silent! normal! za'.(foldlevel('.')?'':'l')<cr>
nnoremap <silent> <Space> :set foldmethod=syntax <CR> :exe 'silent! normal! za'.(foldlevel('.')?'':'l')<cr>

" Set F3 and F4 to scroll back and forth through buffers
:silent nmap <F2> :tabprevious<CR>
:silent nmap <F3> :tabnext<CR>

" Set F5 and F6 to scroll back and forth through buffers
:silent map <F5> :bprevious<CR>
:silent map <F6> :bnext<CR>

" move to next screen accordingly
:silent nmap <C-h> :wincmd h<CR>
:silent nmap <C-j> :wincmd j<CR>
:silent nmap <C-k> :wincmd k<CR>
:silent nmap <C-l> :wincmd l<CR>
" create new tab
:silent nmap <T> <C-w> t

:silent imap <C-h> <Esc>:vertical resize -30<CR>i
:silent imap <C-j> <Esc>:resize +30<CR>i
:silent imap <C-k> <Esc>:resize -30<CR>i
:silent imap <C-l> <Esc>:vertical resize +30<CR>i

"CPP //= line breaks
au Filetype cpp nmap lb<Space> o//<Esc>78a=<Esc><Esc>o

" Com'n Give me a good color :/ I guess this will do
colorscheme desert

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" EVERYTHING AFTER THIS POINT IS THROUGH THE BUNDLE FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Infect with pathogen. Allows github control of plugins
call plug#begin('~/.vim/plugged')
" " Syntax and highlighting
Plug 'https://github.com/othree/javascript-libraries-syntax.vim.git'
Plug 'https://github.com/hail2u/vim-css3-syntax.git'
Plug 'https://github.com/veloce/vim-behat.git'
" Plug 'lumiliet/vim-twig'

" Disabled because it was causing indent issues
"
" Removed cause airline works better
" Plug 'https://github.com/Lokaltog/vim-powerline.git'
"
" Caused Perfomance issues
" Plug 'https://github.com/scrooloose/syntastic.git'
" Plug 'https://github.com/myint/syntastic-extras.git'
"
" " Formatting
" Plug 'https://github.com/Yggdroot/indentLine.git'

" " Autocomplete
Plug 'https://github.com/vim-scripts/closetag.vim.git'
Plug 'https://github.com/ervandew/supertab'
Plug 'https://github.com/shawncplus/phpcomplete.vim.git'
Plug 'https://github.com/othree/csscomplete.vim.git'
Plug 'https://github.com/mattn/emmet-vim.git'

" " File Explorer and Buffers
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin'
Plug 'https://github.com/vim-scripts/qnamebuf.git'
Plug 'https://github.com/majutsushi/tagbar.git'

" " Pair Coding
Plug 'https://github.com/FredKSchott/CoVim.git'

" " Status Line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'


call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"         Plug Configurations - Fine tuning            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                      "
" #### #    #  # ####   #### #### #  # ####            "
" #  # #    #  # #      #    #  # ## # #               "
" #### #    #  # # ##   #    #  # #### ###             "
" #    #    #  # #  #   #    #  # # ## #               "
" #    #### #### ####   #### #### #  # #               "
"                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""     NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:silent map <F7> :NERDTreeToggle<CR>
let g:NERDTreeHighlightCursorline = 1
let g:NERDTreeIgnore = ['\~$', '.*\.o$']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""     AirLine
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline configuration
let g:airline_left_sep=' '
let g:airline_right_sep=' '
let g:airline_powerline_fonts = 1
if has('autocmd')
  augroup airline_init
    autocmd!
    autocmd User AirlineAfterInit
      \ call s:airline_init()
  augroup END
endif

call airline#parts#define_function(
  \ 'fencbomffmt',
  \ 'Airline_file_encoding_bom_file_format'
\)

" Overwrite any sections for airline in this method.
function! s:airline_init()
  let g:airline_section_b=airline#section#create(['branch',' ','hunks'])
  let l:spc = g:airline_symbols.space
  let g:airline_section_y = airline#section#create_right([
    \ 'fencbomffmt'
  \])
  let g:airline_section_z = airline#section#create([
    \ 'windowswap',
    \ '%3p%%'.l:spc,
    \ 'linenr',
    \ ':%3v'.l:spc,
    \ '𝐁'.l:spc,
    \ '%5o'
  \])
endfunction

function! Airline_file_encoding_bom_file_format()
  return printf(
    \ '%s%s%s',
    \ &fenc,
    \ &bomb ? '[bom]' : '',
    \ strlen(&ff) > 0 ? '['.&ff.']' : ''
  \)
endfunction
"
" Lets set up some vars for our plugins
let g:Powerline_symbols = 'fancy'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""     CoVim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let CoVim_default_name = "ctatro"
let CoVim_default_port = "959595"
let g:tagbar_type_php = {
    \ 'kinds' : [
        \ 'f:function',
        \ 'c:class',
        \ 'i:interface'
    \ ]
\ }


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""     Emmet
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:silent nmap <F12> <C-y>,
:silent imap <F12> <C-y>,
vmap <F12> <C-y>,
let g:user_emmet_install_global = 0
autocmd FileType html,css,twig,htmldjango.twig EmmetInstall
let g:user_emmet_settings = {
\  'html' : {
\      'comment_type': 'lastonly',
\  },
\}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""     Complete Omnifunc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci
"autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
"autocmd FileType c set omnifunc=ccomplete#Complete

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""     Syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:syntastic_php_checkers=['php', 'phpcs']
" let g:syntastic_php_phpcs_args='--standard=PSR2 -n'
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_w = 1
" let g:syntastic_javascript_checkers = ['json_tool']
" let g:syntastic_yaml_checkers = ['pyyaml']
" :silent nmap <F12> :SyntasticReset<CR>

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""     SuperTabs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set pumheight=5              " so the complete menu doesn't get too big
set completeopt=menu,longest " menu, menuone, longest and preview
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

:set pastetoggle=<F9>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""     TagBar
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:silent nmap <F8> :TagbarToggle<CR>


" Overwite file types
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" SETUP FILETYPES AND SYNTAX
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 1
au! bufread,bufnewfile *.cpp set filetype=cpp
au! bufread,bufnewfile *.h set filetype=cpp
au! bufread,bufnewfile TAGS set filetype=tags
au! BufRead,BufNewFile *.js set filetype=javascript syntax=jquery
au! BufRead,BufNewFile *.sql set filetype=mysql
au! FileType javascript set syntax=jquery
au! FileType mysql set syntax=mysql
au! BufNewFile,BufRead *.wiki setf Wikipedia
au! BufNewFile,BufRead *.txt setf Wikipedia
au! BufNewFile,BufRead *.md setf Markdown
au! BufNewFile,BufRead *.twig set syntax=htmldjango.twig

let g:feature_filetype='behat'
