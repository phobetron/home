-- Map leader to space
vim.g.mapleader = ' '

-- Auto install packer.nvim if not exists
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end
vim.cmd([[packadd packer.nvim]])

-- Auto compile when there are changes in plugins.lua
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')

require('plugins')
require('settings')
require('colorscheme')
require('keymappings')
require('commands')
