local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local noopts = { noremap=true }
local nosopts = { noremap=true, silent=true }
local noeopts = { noremap = true, expr = true }

-- Clear search terms (Ctrl+/)
vim.keymap.set('', '<C-_>', ':let @/ = ""<CR>', nosopts)

-- Nudge lines up and down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', noopts)
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', noopts)
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', noopts)
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', noopts)
vim.keymap.set('v', '<A-j>', ':m \'>+1<CR>gv=gv', noopts)
vim.keymap.set('v', '<A-k>', ':m \'<-2<CR>gv=gv', noopts)

-- Nudge lines up and down MacOS version
vim.keymap.set('n', '<A-∆>', ':m .+1<CR>==', noopts)
vim.keymap.set('n', '<A-˚>', ':m .-2<CR>==', noopts)
vim.keymap.set('i', '<A-∆>', '<Esc>:m .+1<CR>==gi', noopts)
vim.keymap.set('i', '<A-˚>', '<Esc>:m .-2<CR>==gi', noopts)
vim.keymap.set('v', '<A-∆>', ':m \'>+1<CR>gv=gv', noopts)
vim.keymap.set('v', '<A-˚>', ':m \'<-2<CR>gv=gv', noopts)

-- Terminal mappings
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>:enew<CR>:bd! #<CR>', noopts)
vim.keymap.set('t', '<C-r>', '\'<C-\\><C-N>"\'.nr2char(getchar()).\'pi\'', noeopts)

-- NvimTree
vim.keymap.set('n', '<F1>', '<cmd>Neotree filesystem toggle reveal<cr>', noopts)
vim.keymap.set('n', '<F2>', '<cmd>Neotree buffers toggle<cr>', noopts)
vim.keymap.set('n', '<F3>', '<cmd>Neotree git_status toggle<cr>', noopts)

-- Telescope finder
vim.keymap.set('n', '<F4>', '<cmd>Telescope find_files<cr>', noopts)
vim.keymap.set('n', '<F5>', '<cmd>Telescope live_grep<cr>', noopts)
vim.keymap.set('n', '<F6>', '<cmd>Telescope help_tags<cr>', noopts)

-- LSP diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, nosopts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, nosopts)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, nosopts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, nosopts)
