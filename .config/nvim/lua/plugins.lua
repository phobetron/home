require('packer').startup(function()
  -- use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'} -- TreeSitter
  use 'cocopon/iceberg.vim'                                  -- Color scheme
  use 'cakebaker/scss-syntax.vim'                            -- SCSS syntax
  use 'posva/vim-vue'                                        -- Vue syntax
  use 'mileszs/ack.vim'                                      -- Ack
  use 'nvim-lua/plenary.nvim'                                -- LUA Dependencies
  use 'kyazdani42/nvim-web-devicons'                         -- Icons
  use 'hoob3rt/lualine.nvim'                                 -- Status line
  use 'nvim-lua/popup.nvim'                                  -- Popup manager
  use 'nvim-telescope/telescope.nvim'                        -- Fuzzy finder
  use 'pwntester/octo.nvim'                                  -- GitHub integration
  use {'neoclide/coc.nvim', branch = 'release'}              -- Conqueror of Completion
  end
)

-- Plugin Settings
if (vim.api.nvim_eval("exists('+guioptions')")) then
  vim.cmd([[
    set guioptions-=r
    set guioptions+=L
  ]])
end

vim.opt.winfixwidth = true
vim.opt.signcolumn = 'yes'

-- TreeSitter
-- require('nvim-treesitter.configs').setup {
--   highlight = {
--     enable = true,
--     disable = {},
--   },
--   indent = {
--     enable = true,
--     disable = {},
--   },
--   ensure_installed = {
--     'html',
--     'json',
--     'css',
--     'scss',
--     'typescript',
--     'vue',
--     'yaml'
--   },
-- }

-- Ack
vim.g.ackprg = 'ag --vimgrep'

-- LuaLine
require('nvim-web-devicons').setup({ default = true })

require('lualine').setup({
  options = { theme = 'iceberg_dark' }
})

-- Telescope
require('telescope').setup({
  pickers = {
    live_grep = {
      additional_args = function(opts)
        return {"--hidden"}
      end
    },
  }
})

-- CoC
vim.g.coc_global_extensions = {
  'coc-css',
  'coc-elixir',
  'coc-eslint',
  'coc-explorer',
  'coc-git',
  'coc-highlight',
  'coc-html',
  'coc-htmlhint',
  'coc-html-css-support',
  'coc-json',
  'coc-lists',
  'coc-markdownlint',
  'coc-prettier',
  'coc-stylelintplus',
  'coc-snippets',
  'coc-solargraph',
  'coc-sql',
  'coc-svg',
  'coc-tsserver',
  '@yaegassy/coc-volar',
  'coc-xml',
  'coc-yaml'
}

vim.g.coc_explorer_global_presets = {
  ['.vim'] = {
    ['root-uri'] = '~/.vim',
  },
  cocConfig = {
     ['root-uri'] = '~/.config/coc',
  },
  tab = {
    position = 'tab',
    ['quit-on-open'] = true
  },
  file = {
    sources = {{name = 'file', expand = true}}
  },
  buffer = {
    position = 'floating',
    ['open-action-strategy'] = 'sourceWindow',
    sources = {{name = 'buffer', expand = true}}
  }
}
