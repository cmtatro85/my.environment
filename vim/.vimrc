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
set norelativenumber
syntax sync minlines=50
syntax sync maxlines=100
set synmaxcol=300
if &term =~ "xterm-256color\\|rxvt"
  " use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;orange\x7"
  " use a red cursor otherwise
  let &t_EI = "\<Esc>]12;red\x7"
  silent !echo -ne "\033]12;red\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
  " use \003]12;gray\007 for gnome-terminal and rxvt up to version 9.21
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
" au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
" \| exe "normal g'\"" | endif
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
set listchars=trail:≡ ",eol:¬
set ffs=unix
set encoding=utf-8
set fileencoding=utf-8
set list

" Set the text width
" set textwidth=80
"
autocmd BufEnter * set title
let &titlestring=hostname()." -- %f | ". $USER ."@". hostname() .":" ." %F [ ".strftime('%c')." ]"
let php_syntax_extensions_enabled=["date", "json"]
let html_load=0
let php_sql_query=0


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
":silent nmap <T> <C-w> t

:silent imap <C-h> <Esc>:vertical resize -30<CR>a
:silent imap <C-j> <Esc>:resize +30<CR>a
:silent imap <C-k> <Esc>:resize -30<CR>a
:silent imap <C-l> <Esc>:vertical resize +30<CR>a

" :silent inoremap <C-x> <Esc>:syntax off<CR>a<C-x>
" :silent imap <C-a> <Esc>:syntax on<CR>a

"CPP //= line breaks
au Filetype cpp nmap lb<Space> o//<Esc>78a=<Esc><Esc>o

" Com'n Give me a good color :/ I guess this will do
colorscheme desert

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" COLORS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufEnter NERD_tree_* hi CursorLine cterm=BOLD ctermbg=DarkGray
au BufLeave NERD_tree_* highlight clear CursorLine
au BufAdd * highlight clear CursorLine
" Let's change some colors and add some syntax highlighting
"" Let's set up lines over 80 to be highlighted in a different color bg
hi LineTooLong cterm=bold ctermbg=LightGrey
match LineTooLong /\%>80v.\+/

"" Change non text lines to a lighter color
hi NonText ctermfg=LightGrey gui=bold guifg=LightGrey guibg=grey30

"Sort PHP use statements
""http://stackoverflow.com/questions/11531073/how-do-you-sort-a-range-of-lines-by-length
vmap <Leader>su ! awk '{ print length(), $0 \| "sort -n \| cut -d\\  -f2-" }'<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" EVERYTHING AFTER THIS POINT IS THROUGH THE BUNDLE FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype off
" Infect with pathogen. Allows github control of plugins
call plug#begin('~/.vim/plugged')
" " Syntax and highlighting
" Plug 'https://github.com/sheerun/vim-polyglot'
" Plug 'https://github.com/othree/javascript-libraries-syntax.vim.git'
" Plug 'https://github.com/hail2u/vim-css3-syntax.git'
" Plug 'https://github.com/veloce/vim-behat.git'

" " Colors
Plug 'https://github.com/reedes/vim-colors-pencil'

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
" Plug 'https://github.com/vim-scripts/SQLUtilities.git'
Plug 'https://github.com/kylef/apiblueprint.vim'

" " Autocomplete
Plug 'https://github.com/vim-scripts/closetag.vim.git'
" Plug 'https://github.com/ervandew/supertab'
" Plug 'Valloric/YouCompleteMe'
" Does not work correcly....
" Plug 'lvht/phpcd.vim', { 'for': 'php' , 'do': 'composer update' }
"
" Plug 'https://github.com/shawncplus/phpcomplete.vim.git'
Plug 'https://github.com/phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
Plug 'https://github.com/ludovicchabant/vim-gutentags.git'
Plug 'arnaud-lb/vim-php-namespace'
Plug 'https://github.com/mbbill/echofunc'
Plug 'https://github.com/dhruvasagar/vim-table-mode'

" Snippets are separated from the engine. Add this if you want them:
Plug 'https://github.com/SirVer/UltiSnips'
" Plug 'https://github.com/honza/vim-snippets'
" Plug 'https://github.com/sniphpets/sniphpets'
" Plug 'https://github.com/sniphpets/sniphpets-common'
" Plug 'https://github.com/sniphpets/sniphpets-symfony'
" Plug 'https://github.com/bonsaiben/bootstrap-snippets'
" Plug 'https://github.com/othree/csscomplete.vim.git'
Plug 'https://github.com/mattn/emmet-vim.git'

" " File Explorer and Buffers
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin'
Plug 'https://github.com/vim-scripts/qnamebuf.git'
Plug 'https://github.com/majutsushi/tagbar.git'

" " Pair Coding
" Plug 'https://github.com/FredKSchott/CoVim.git'

" " Status Line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'


call plug#end()

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins. forces autocmd from bundles
filetype plugin indent on


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
let g:used_javascript_libs = 'jquery, d3'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""     NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:silent map <F7> :NERDTreeToggle<CR>
let g:NERDTreeHighlightCursorline = 1
let g:NERDTreeIgnore = ['\~$', '.*\.o$']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""     Gutentags
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gutentags_ctags_exclude = ['*.css', '*.htm*', '*.js', '*.json', '*.xml','*.phar', '*.ini', '*.rst', '*.md',
                            \ '*vendor/*/test*', '*vendor/*/Test*',
                            \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
                            \ '*var/cache*', '*var/log*']

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
""     Pencil Theme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:airline_theme = 'pencil'
" let g:pencil_gutter_color = 1

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
:silent nmap <F12> <C-z>,
:silent imap <F12> <C-z>,
vmap <F12> <C-z>,
let g:user_emmet_install_global = 0
let g:user_emmet_leader_key='<C-Z>'
autocmd FileType html,css,twig,htmldjango.twig EmmetInstall
let g:user_emmet_settings = {
\  'html' : {
\      'comment_type': 'lastonly',
\  },
\}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""     EchoFunc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EchoFuncKeyNext='<C-j>'
let g:EchoFuncKeyPrev='<C-k>'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""     Complete Omnifunc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd FileType python set omnifunc=pythoncomplete#Complete
" autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci
" autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
" autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType php setlocal omnifunc=phpactor#Complete
" autocmd FileType c set omnifunc=ccomplete#Complete

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
set pumheight=30             " so the complete menu doesn't get too big
set completeopt=menu,preview " menu, menuone, longest and preview
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

:set pastetoggle=<F9>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""     TagBar
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:silent nmap <F8> :TagbarToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""     SQLUtilities
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap <silent>sf        <Plug>SQLU_Formatter<CR>
" nmap <silent>scl       <Plug>SQLU_CreateColumnList<CR>
" nmap <silent>scd       <Plug>SQLU_GetColumnDef<CR>
" nmap <silent>scdt      <Plug>SQLU_GetColumnDataType<CR>
" nmap <silent>scp       <Plug>SQLU_CreateProcedure<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""     UltiSnips
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets='<c-tab>'
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" Overwite file types
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" SETUP FILETYPES AND SYNTAX AND SPACINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 1

au! bufread,bufnewfile *.cpp set filetype=cpp
au! bufread,bufnewfile *.h set filetype=cpp
au! bufread,bufnewfile TAGS set filetype=tags
au! BufRead,BufNewFile *.jsx? set filetype=javascript syntax=javascript
au! BufRead,BufNewFile *.sql set filetype=mysql
au! FileType mysql set syntax=mysql
au! BufNewFile,BufRead *.wiki setf Wikipedia
au! BufNewFile,BufRead *.txt setf Wikipedia
au! BufNewFile,BufRead *.md setf Markdown
au! BufNewFile,BufRead *.twig set syntax=htmldjango.twig

au! FileType cucumber setlocal et sw=2 sts
au! Filetype javascript setlocal expandtab softtabstop tabstop=2 shiftwidth=2
au! Filetype make setlocal noexpandtab shiftwidth=2 tabstop=2
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Spelling
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nospell
" au FileType twig,html,php,javascript,wikipedia,mysql,htmldjango.twig setlocal spell spelllang=en_us

let g:feature_filetype='behat'

au FileType cucumber setlocal et sw=2 sts
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" PhpActor
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:phpactorPhpBin = 'php'
let g:phpactorOmniAutoClassImport = v:true

" Include use statement
nmap <Leader>u :call phpactor#UseAdd()<CR>

" Invoke the context menu
nmap <Leader>mm :call phpactor#ContextMenu()<CR>

" Invoke the navigation menu
nmap <Leader>nn :call phpactor#Navigate()<CR>

" Goto definition of class or class member under the cursor
nmap <Leader>o :call phpactor#GotoDefinition()<CR>

" Show brief information about the symbol under the cursor
nmap <Leader>K :call phpactor#Hover()<CR>

" Transform the classes in the current file
nmap <Leader>tt :call phpactor#Transform()<CR>

" Generate a new class (replacing the current file)
nmap <Leader>cc :call phpactor#ClassNew()<CR>

" Extract expression (normal mode)
nmap <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>

" Extract expression from selection
vmap <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>

" Extract method from selection
vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>
