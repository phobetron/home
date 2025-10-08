return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        disabled_filetypes = {
          statusline = {},
          winbar = {
            "qf",
            "neo-tree",
            "neo-tree-popup",
            "notify",
            "dashboard",
            "snacks_dashboard",
          },
        },
      },
      winbar = {
        lualine_c = {
          {
            "filetype",
            colored = true,
          },
          {
            "filename",
            path = 1,
          },
        },
        lualine_x = {
          "diagnostics",
        },
      },
      inactive_winbar = {
        lualine_c = {
          {
            "filetype",
            colored = false,
          },
          {
            "filename",
            path = 1,
          },
        },
        lualine_x = {
          {
            "diagnostics",
            colored = false,
          },
        },
      },
    },
  },
}
