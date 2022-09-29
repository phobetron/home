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
  use 'L3MON4D3/LuaSnip'                                     -- Snippets plugin
  use {
    'hrsh7th/nvim-cmp',                                      -- Autocompletion plugin
    'hrsh7th/cmp-nvim-lsp',                                  -- LSP source for nvim-cmp
    'saadparwaiz1/cmp_luasnip',                              -- Snippets source for nvim-cmp
  }
end)

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
-- luasnip
local luasnip = require('luasnip')

-- nvim-cmp
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
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
end

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local on_attach_format = function(client, bufnr)
  on_attach(client, bufnr)

  local bufopts = { noremap=true, silent=true, buffer=bufnr }

  vim.keymap.set('n', '<leader>f', function()
    local params = vim.lsp.util.make_formatting_params({})
    client.request('textDocument/formatting', params, nil, bufnr)
  end, bufopts)

  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        -- on -1.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
        vim.lsp.buf.formatting_seq_sync(nil, 5000, { 'null-ls' })
      end,
    })
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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

for _, server in pairs(servers) do
  require('lspconfig')[server].setup({
    on_attach = on_attach,
    capabilities = capabilities,
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
require('null-ls').setup({
  sources = {
    require('null-ls').builtins.diagnostics.markdownlint,
    require('null-ls').builtins.diagnostics.stylelint,
    require('null-ls').builtins.diagnostics.yamllint,
    require('null-ls').builtins.diagnostics.zsh,
    require('null-ls').builtins.formatting.eslint_d,
    require('null-ls').builtins.formatting.crystal_format,
    require('null-ls').builtins.formatting.rubocop,
    require('null-ls').builtins.formatting.sql_formatter,
  },
  on_attach = on_attach_format,
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
  selection_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
  fg_color = '#ffffff',
  current_win_hl_color = '#1593e5',
  other_win_hl_color = '#1593e5',
})

-- neo-tree
require('neo-tree').setup({
  default_component_configs = {
    modified = {
      symbol = '◈',
    },
    git_status = {
      symbols = {
        -- Change type
        added     = '✚',
        modified  = '◆',
        deleted   = '✖',
        renamed   = '',
        -- Status type
        untracked = '',
        ignored   = '◫',
        unstaged  = '◧',
        staged    = '◨',
        conflict  = '',
      },
    },
  },
  window = {
    mappings = {
      ['<2-LeftMouse>'] = 'open_with_window_picker',
      ['<cr>'] = 'open_with_window_picker',
    },
  },
  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
    },
  },
  buffers = {
    window = {
      mappings = {
        ['d'] = 'buffer_delete',
      },
    },
  },
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
        return {'--hidden'}
      end
    }
  }
})
