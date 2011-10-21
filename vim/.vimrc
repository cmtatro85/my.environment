" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
" set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
"    \| exe "normal g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
"if has("autocmd")
"  filetype indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes) in terminals

" Source a global configuration file if available
" XXX Deprecated, please move your changes here in /etc/vim/vimrc
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

set number
set ai " auto indent

" Com'n Give me a good color :/ I guess this will do
colorscheme desert

" Set F5 and F6 to scroll back and forth through buffers
:silent map <F5> :bprevious<CR>
:silent map <F6> :bnext<CR>

" Set tabs to spaces
set et
set sw=2
set sts=2
set smarttab

let php_folding = 1
let html_folding = 1

"Set live search
set incsearch

" Show trailing spaces
set list
set listchars=trail:#

" Set space to toggle fold/unfold
nnoremap <silent> <space> :exe 'silent! normal! za'.(foldlevel('.')?'':'l')<cr>

"VTreeExplorer settings
"http://www.vim.org/scripts/script.php?script_id=184
"Added by tom on 31 Aug 2009
let treeExplVertical = 1
let treeExplWinSize = 45
let treeExplIndent = 1
:silent map <F7> :NERDTreeToggle<CR>
let g:NERDTreeHighlightCursorline = 1
let g:NERDTreeIgnore = ['\~$', '.*\.o$']

"Set up auto closing of tags 
"http://vim.sourceforge.net/scripts/script.php?script_id=13
"Added by tom on 31 Aug 2009
au Filetype html,xml,xsl,php,symfony,htm source /etc/vim/scripts/closetag.vim
au! BufRead,BufNewFile *.js set filetype=jquery
au! bufread,bufnewfile *.cpp set filetype=cpp
au! bufread,bufnewfile *.h set filetype=cpp

augroup filetypedetect
au BufNewFile,BufRead *.wiki setf Wikipedia
au BufNewFile,BufRead *.txt setf Wikipedia
augroup END


"Set up taglist for php
:silent map <F8> :TlistToggle<CR>

" Set F3 and F4 to scroll back and forth through buffers
:silent nmap <F2> :tabprevious<CR>
:silent nmap <F3> :tabnext<CR>

" move to next screen accordingly
:silent nmap <C-h> :wincmd h<CR>
:silent nmap <C-j> :wincmd j<CR>
:silent nmap <C-k> :wincmd k<CR>
:silent nmap <C-l> :wincmd l<CR>
:silent imap <C-h> <Esc>:vertical resize -30<CR>i
:silent imap <C-j> <Esc>:resize +30<CR>i
:silent imap <C-k> <Esc>:resize -30<CR>i
:silent imap <C-l> <Esc>:vertical resize +30<CR>i
inoremap <C-s>a <ESC>:w <CR>
nmap <C-w> :w <CR>

"PHP shortcut for php view files
au Filetype php inoremap <buffer> <? <?php ; ?><Left><Left><Left><Left>
au Filetype php inoremap <buffer> <?= <?php echo ; ?><Left><Left><Left><Left>
au Filetype php inoremap <buffer> <?foreach <?php foreach(): ?><Return><?php endforeach; ?><Up><Left><Left><Left><Left><Left>
au Filetype php inoremap <buffer> <?if <?php if(): ?><Return><?php endif; ?><Up><Left><Left><Left><Left><Left>

"PHP documentor
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR> 

"Super Tabs overwrite... Mostly cause I only want referenced files
let g:SuperTabDefaultCompletionType = "<C-P>"

"CPP //= line breaks
au Filetype cpp nmap lb<Space> o//<Esc>78a=<Esc><Esc>o
