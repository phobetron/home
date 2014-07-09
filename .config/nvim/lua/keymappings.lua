local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Clear search terms (Ctrl+/)
vim.api.nvim_set_keymap('', '<C-_>', ':let @/ = ""<CR>', {noremap = true, silent = true })

-- Nudge lines up and down
vim.api.nvim_set_keymap('n', '<A-j>', ':m .+1<CR>==', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-k>', ':m .-2<CR>==', { noremap = true })
vim.api.nvim_set_keymap('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { noremap = true })
vim.api.nvim_set_keymap('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { noremap = true })
vim.api.nvim_set_keymap('v', '<A-j>', ':m \'>+1<CR>gv=gv', { noremap = true })
vim.api.nvim_set_keymap('v', '<A-k>', ':m \'<-2<CR>gv=gv', { noremap = true })

-- Nudge lines up and down MacOS version
vim.api.nvim_set_keymap('n', '<A-∆>', ':m .+1<CR>==', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-˚>', ':m .-2<CR>==', { noremap = true })
vim.api.nvim_set_keymap('i', '<A-∆>', '<Esc>:m .+1<CR>==gi', { noremap = true })
vim.api.nvim_set_keymap('i', '<A-˚>', '<Esc>:m .-2<CR>==gi', { noremap = true })
vim.api.nvim_set_keymap('v', '<A-∆>', ':m \'>+1<CR>gv=gv', { noremap = true })
vim.api.nvim_set_keymap('v', '<A-˚>', ':m \'<-2<CR>gv=gv', { noremap = true })

-- Terminal mappings
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>:enew<CR>:bd! #<CR>', { noremap = true })
vim.api.nvim_set_keymap('t', '<C-r>', '\'<C-\\><C-N>"\'.nr2char(getchar()).\'pi\'', { noremap = true, expr = true })

-- CoC diagnostics
vim.api.nvim_set_keymap('n', '<leader><Space>', '<Plug>(coc-diagnostic-info)', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>n', '<Plug>(coc-diagnostic-next)', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', '<Plug>(coc-diagnostic-prev)', { silent = true })

-- CoC explorer
vim.api.nvim_set_keymap('n', '<F1>', '<cmd>CocCommand explorer --preset file<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F2>', '<cmd>CocCommand explorer --preset buffer<CR>', { noremap = true })

-- Telescope finder
vim.api.nvim_set_keymap('n', '<F3>', '<cmd>Telescope find_files<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F4>', '<cmd>Telescope live_grep<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F5>', '<cmd>Telescope help_tags<cr>', { noremap = true })
