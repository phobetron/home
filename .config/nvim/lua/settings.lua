-- Disable Perl
vim.cmd('let g:loaded_perl_provider = 0')

-- General
vim.opt.history      =   256                     -- Number of things to remember in history.
vim.opt.autowrite    =   true                    -- Writes on make/shell commands
vim.opt.autoread     =   true                    -- Reload file on external change
vim.opt.timeoutlen   =   250                     -- Time to wait after ESC (default causes an annoying delay)
vim.opt.tags         =   './tags;$HOME'          -- Walk directory tree upto $HOME looking for tags
vim.opt.modeline     =   true                    -- Vim settings loaded from edited file
vim.opt.modelines    =   5                       -- Default numbers of lines to read for modeline instructions
vim.opt.hidden       =   true                    -- The current buffer can be put to the background without writing to disk
vim.opt.clipboard:prepend('unnamed,unnamedplus') -- Yank to system clipboard

-- Formatting
vim.opt.wrap         =  false                              -- Don't wrap lines by default
vim.opt.textwidth    =  120                                -- Unvim.opt.width boundary
vim.opt.cc           =  '+1'                               -- Set an 80 column border for good coding style
vim.opt.wildmode     =  'longest,list'                     -- At command line, complete longest common string, then list alternatives.
vim.opt.backspace    =  'indent,eol,start'                 -- More powerful backspacing
vim.opt.tabstop      =  2                                  -- Set the default tabstop
vim.opt.softtabstop  =  2
vim.opt.shiftwidth   =  2                                  -- Set the default shift width for indents
vim.opt.expandtab    =  true                               -- Make tabs into spaces (vim.opt.by tabstop)
vim.opt.smarttab     =  true                               -- Smarter tab levels
vim.opt.autoindent   =  true                               -- Indent based on previous line
vim.opt.cindent      =  true                               -- C-style indenting
vim.opt.cinoptions   =  ':s,ps,ts,cs'                      -- Preferred indent style
vim.opt.cinwords     =  'if,else,while,do,for,switch,case' -- Keywords that trigger indent
vim.opt.fo:append('o')                                     -- Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
vim.opt.fo:remove('r')                                     -- Do not automatically insert a comment leader after an enter
vim.opt.fo:remove('t')                                     -- Do no auto-wrap text using textwidth (does not apply to comments)

-- Visual
vim.opt.cursorline   = true                                        -- Cursor on by default
vim.opt.number       = true                                        -- Line numbers on
vim.opt.showmatch    = true                                        -- Show matching brackets.
vim.opt.matchtime    = 5                                           -- Bracket blinking.
vim.opt.visualbell   = false                                       -- No blinking
vim.opt.errorbells   = false                                       -- No noise.
vim.opt.laststatus   = 2                                           -- Always show status line.
vim.opt.vb           = false                                       -- Disable any beeps or flashes on error
vim.opt.ruler        = true                                        -- Show ruler
vim.opt.showcmd      = true                                        -- Display an incomplete command in the lower right corner of the Vim window
vim.opt.shortmess    = 'atI'                                       -- Shortens messages
vim.opt.list         = false                                       -- Display unprintable characters f12 - switches
vim.opt.listchars    = 'tab:· ,eol:¶,trail:·,extends:»,precedes:«' -- Unprintable chars mapping
vim.opt.foldmethod   = 'indent'                                    -- Fold based on indent
vim.opt.foldnestmax  = 10                                          -- Deepest fold is 10 levels
vim.opt.foldenable   = false                                       -- Dont fold by default
vim.opt.foldlevel    = 1                                           -- This is just what i use
vim.opt.foldopen     = 'block,hor,mark,percent,quickfix,tag'       -- What movements open folds
vim.opt.mouse        = 'a'                                         -- Disable mouse
vim.opt.splitbelow   = true                                        -- Split panels to the bottom
vim.opt.splitright   = true                                        -- Split panels to the right
vim.opt.hlsearch     = true                                        -- Highlight search
vim.opt.incsearch    = true                                        -- Search incrementally as typed
vim.opt.smartcase    = true                                        -- Sensitive when there's a capital letter
vim.opt.gdefault     = true                                        -- Default to global search (/g)
vim.opt.fillchars:append('vert:╽')                                 -- Set fillchars
