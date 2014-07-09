set nocompatible                                         " disable vi compatibility.

" Plugin Installation " {
  let vimplug_exists=expand('~/.vim/autoload/plug.vim')
  let curl_exists=expand('curl')

  if !filereadable(vimplug_exists)
    if !executable(curl_exists)
      echoerr "You have to install curl or first install vim-plug yourself!"
      execute "q!"
    endif
    echo "Installing Vim-Plug..."
    echo ""
    silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    let g:not_finish_vimplug = "yes"

    autocmd VimEnter * PlugInstall
  endif

  call plug#begin('~/.vim' . '/plugged')

  Plug 'cocopon/iceberg.vim'                                " Color scheme

  call plug#end()

  autocmd VimEnter *
    \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \|   PlugInstall --sync | q
    \| endif
" " }

" Color settings " {
  if (exists('+termguicolors'))
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif

  syntax on
  filetype plugin indent on
  colorscheme iceberg

  set background=dark
  set guioptions-=r
  set guioptions-=L
  set winfixwidth
" "}

" General "{
  set history=256                                          " Number of things to remember in history.
  set autowrite                                            " Writes on make/shell commands
  set autoread                                             " Reload file on external change
  set timeoutlen=250                                       " Time to wait after ESC (default causes an annoying delay)
  set tags=./tags;$HOME                                    " walk directory tree upto $HOME looking for tags

  set modeline                                             " vim settings loaded from edited file
  set modelines=5                                          " default numbers of lines to read for modeline instructions

  set backupdir=~/.vim/tmp/backup                          " backups
  set directory=~/.vim/tmp/swap                            " swap files

  set hidden                                               " The current buffer can be put to the background without writing to disk

  set clipboard=unnamedplus                                " yank to system clipboard
" "}

" Formatting "{
  set fo+=o                                                " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
  set fo-=r                                                " Do not automatically insert a comment leader after an enter
  set fo-=t                                                " Do no auto-wrap text using textwidth (does not apply to comments)

  set nowrap                                               " Don't wrap lines by default
  set textwidth=80                                         " unset width boundary
  set wildmode=longest,list                                " At command line, complete longest common string, then list alternatives.

  set backspace=indent,eol,start                           " more powerful backspacing

  set tabstop=2                                            " Set the default tabstop
  set softtabstop=2
  set shiftwidth=2                                         " Set the default shift width for indents
  set expandtab                                            " Make tabs into spaces (set by tabstop)
  set smarttab                                             " Smarter tab levels

  set autoindent                                           " indent based on previous line
  set cindent                                              " C-style indenting
  set cinoptions=:s,ps,ts,cs                               " preferred indent style
  set cinwords=if,else,while,do,for,switch,case            " keywords that trigger indent
" "}

" Visual "{
  set number                                               " Line numbers on
  set showmatch                                            " Show matching brackets.
  set matchtime=5                                          " Bracket blinking.
  set novisualbell                                         " No blinking
  set noerrorbells                                         " No noise.
  set laststatus=2                                         " Always show status line.
  set vb t_vb=                                             " disable any beeps or flashes on error
  set ruler                                                " Show ruler
  set showcmd                                              " Display an incomplete command in the lower right corner of the Vim window
  set shortmess=atI                                        " Shortens messages

  set nolist                                               " Display unprintable characters f12 - switches
  set listchars=tab:·\ ,eol:¶,trail:·,extends:»,precedes:« " Unprintable chars mapping
  set fillchars+=vert:╽                                    " Set fillchars

  set foldmethod=indent                                    "fold based on indent
  set foldnestmax=10                                       "deepest fold is 10 levels
  set nofoldenable                                         "dont fold by default
  set foldlevel=1                                          "this is just what i use
  set foldopen=block,hor,mark,percent,quickfix,tag         " what movements open folds

  set mouse=a                                              " Disable mouse
  set mousehide                                            " Hide mouse after chars typed

  set splitbelow                                           " Split panels to the bottom
  set splitright                                           " Split panels to the right

  set hlsearch                                             " highlight search
  set incsearch                                            " search incrementally as typed
  " set ignorecase                                         " case insensitive matching with
  " set smartcase                                          " sensitive when there's a capital letter
  set gdefault                                             " default to global search (/g)

  set ts=2 sw=2 et                                         " indent guide settings
" "}

" Command and Auto commands " {
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=Grey11 ctermbg=234
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=Grey15 ctermbg=235

  comm! W :w                                               " write on accidental shift
  comm! W exec 'w !sudo tee % > /dev/null' | e!            " sudo write

  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif " restore position in file

  au BufWritePre * :retab                                  " convert tabs to spaces on save
  au BufWritePre * :%s/\s\+$//e                            " remove trailing whitespace on save

  augroup cline                                            " Only show cursorline in the current window and in normal mode.
    au!
    au WinLeave * set nocursorline
    au WinEnter * set cursorline
    au InsertEnter * set nocursorline
    au InsertLeave * set cursorline
  augroup END

  au FocusLost * :silent! wall                             " Save when losing focus

  au! BufWritePost vimrc source ~/.vimrc                   " When vimrc is edited, reload it
" " }

" Key mappings " {
  let mapleader = "\<Space>"

  " Clear search terms (Ctrl+/)
  noremap <silent> <c-_> :let @/ = ""<CR>

  " Easier buffer switching
  nnoremap <Leader>n :bn<CR>
  nnoremap <Leader>p :bp<CR>
  nnoremap <Leader>d :enew<CR>:bd #<CR>

  " Terminal mappings
  tnoremap <Esc> <C-\><C-n>:enew<CR>:bd! #<CR>
  tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

  " Nudge lines up and down
  nnoremap <A-j> :m .+1<CR>==
  nnoremap <A-k> :m .-2<CR>==
  inoremap <A-j> <Esc>:m .+1<CR>==gi
  inoremap <A-k> <Esc>:m .-2<CR>==gi
  vnoremap <A-j> :m '>+1<CR>gv=gv
  vnoremap <A-k> :m '<-2<CR>gv=gv

  " Nudge lines up and down MacOS version
  nnoremap ∆ :m .+1<CR>==
  nnoremap ˚ :m .-2<CR>==
  inoremap ∆ <Esc>:m .+1<CR>==gi
  inoremap ˚ <Esc>:m .-2<CR>==gi
  vnoremap ∆ :m '>+1<CR>gv=gv
  vnoremap ˚ :m '<-2<CR>gv=gv
" " }
