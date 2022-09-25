require('packer').startup(function(use)
  use 'cocopon/iceberg.vim'                                  -- Color scheme
  use 'kyazdani42/nvim-web-devicons'                         -- Icons
  use 'nvim-lua/plenary.nvim'                                -- LUA dependencies
  use 'MunifTanjim/nui.nvim'                                 -- UI Components
  use 'nvim-lua/popup.nvim'                                  -- Popup manager
  use 'nvim-lualine/lualine.nvim'                            -- Status line
  use 'pwntester/octo.nvim'                                  -- GitHub integration
  use 'mileszs/ack.vim'                                      -- Ack
  use 'nvim-telescope/telescope.nvim'                        -- Fuzzy finder
  use 's1n7ax/nvim-window-picker'                            -- Select window/split
  use {'nvim-neo-tree/neo-tree.nvim', branch = 'v2.x'}       -- File explorer
  use 'cakebaker/scss-syntax.vim'                            -- SCSS syntax
  use 'posva/vim-vue'                                        -- Vue syntax
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'} -- TreeSitter
  use 'lewis6991/gitsigns.nvim'                              -- git signs
  use 'neovim/nvim-lspconfig'                                -- Configurations for nvim LSP
  use 'jose-elias-alvarez/null-ls.nvim'                      -- Diagnostics, formatting, etc
  use 'mfussenegger/nvim-dap'                                -- Debug adapter
  use {
    'williamboman/mason.nvim',                               -- Automated LSP installation
    'williamboman/mason-lspconfig.nvim',                     -- Mason/LSP config bridge
  }
  end
)

-- GUI Settings
if (vim.api.nvim_eval("exists('+guioptions')")) then
  vim.cmd([[
    set guioptions-=r
    set guioptions+=L
  ]])
end

-- Diagnostic settings
vim.diagnostic.config {
  virtual_text = false,
  float = {
    source = 'always',
  }
}

local signs = {
  Error = '▣',
  Warn = '◮',
  Hint = '◉',
  Info = '❖',
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

-- git signs
require('gitsigns').setup({
  sign_priority = 0,
  numhl = true,
})

-- Mason
require('mason').setup()
require('mason-lspconfig').setup()

-- LSP
local servers = {
  'bashls',
  'crystalline',
  'cssmodules_ls',
  'dockerls',
  'elixirls',
  'eslint',
  'graphql',
  'html',
  'jsonls',
  'lemminx',
  'marksman',
  'pyright',
  'solargraph',
  'sqls',
  'sumneko_lua',
  'svelte',
  'tsserver',
  'volar',
  'yamlls',
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>d', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
end

for _, server in pairs(servers) do
  require('lspconfig')[server].setup({
    on_attach = on_attach
  })
end

require('lspconfig').sumneko_lua.setup({
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'},
      },
    },
  },
})

-- null-ls
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
  sources = {
    require("null-ls").builtins.diagnostics.markdownlint,
    require("null-ls").builtins.diagnostics.stylelint,
    require("null-ls").builtins.diagnostics.yamllint,
    require("null-ls").builtins.diagnostics.zsh,
    require("null-ls").builtins.formatting.eslint_d,
    require("null-ls").builtins.formatting.crystal_format,
    require("null-ls").builtins.formatting.rubocop,
    require("null-ls").builtins.formatting.sql_formatter,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 5000 }) instead
          vim.lsp.buf.formatting_sync(nil, 5000)
        end,
      })
    end
  end,
})

-- TreeSitter
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'css',
    'elixir',
    'gitattributes',
    'gitignore',
    'graphql',
    'html',
    'http',
    'javascript',
    'json5',
    'lua',
    'markdown',
    'pug',
    'python',
    'regex',
    'ruby',
    'scss',
    'svelte',
    'swift',
    'tsx',
    'typescript',
    'vue',
    'yaml'
  },
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
}

-- window-picker
require'window-picker'.setup({
  include_current_win = true,
  fg_color = '#ffffff',
  current_win_hl_color = '#1593e5',
  other_win_hl_color = '#1593e5',
})

-- neo-tree
require('neo-tree').setup({
  window = {
    mappings = {
      ["<2-LeftMouse>"] = "open_with_window_picker",
      ['<cr>'] = 'open_with_window_picker',
    }
  },
  buffers = {
    window = {
      mappings = {
        ['d'] = 'buffer_delete',
      }
    }
  }
})

-- Ack
vim.g.ackprg = 'ag --vimgrep'

-- LuaLine
require('nvim-web-devicons').setup({ default = true })

require('lualine').setup({
  options = { theme = 'iceberg_dark' },
  sections = {
    -- 0: Just the filename; 1: Relative path; 2: Absolute path
    lualine_c = {{ 'filename', path = 1 }}
  },
  inactive_sections = {
    lualine_c = {{ 'filename', path = 1 }}
  }
})

-- Telescope
require('telescope').setup({
  pickers = {
    live_grep = {
      additional_args = function(opts)
        return {"--hidden"}
      end
    }
  }
})
