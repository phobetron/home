vim.opt.termguicolors = true

if (vim.api.nvim_eval("exists('+termguicolors')")) then
  vim.cmd([[
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  ]])
end

vim.cmd('filetype plugin indent on')
vim.cmd('colorscheme iceberg')
