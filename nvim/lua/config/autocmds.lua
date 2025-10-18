-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Properly set types for all .env-like files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = ".env*",
  callback = function()
    vim.bo.filetype = "sh"
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", { pattern = "*", command = "retab" }) -- Convert tabs to spaces on save
vim.api.nvim_create_autocmd("BufWritePre", { pattern = "*", command = "%s/\\s\\+$//e" }) -- Remove trailing whitespace on save

vim.api.nvim_create_augroup("cline", { clear = true }) -- Only show cursorline in the current window and in normal mode
vim.api.nvim_create_autocmd("WinLeave", { group = "cline", pattern = "*", command = "set nocursorline" })
vim.api.nvim_create_autocmd("WinEnter", { group = "cline", pattern = "*", command = "set cursorline" })
vim.api.nvim_create_autocmd("InsertEnter", { group = "cline", pattern = "*", command = "set nocursorline" })
vim.api.nvim_create_autocmd("InsertLeave", { group = "cline", pattern = "*", command = "set cursorline" })
