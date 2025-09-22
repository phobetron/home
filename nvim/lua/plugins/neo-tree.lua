local function set_colors()
  local visual = vim.api.nvim_get_hl(0, { name = "Visual" })
  vim.api.nvim_set_hl(0, "WindowPickerStatusLine", { fg = visual.fg, bg = visual.bg })
  vim.api.nvim_set_hl(0, "WindowPickerStatusLineNC", { fg = visual.fg, bg = visual.bg })
  vim.api.nvim_set_hl(0, "WindowPickerWinBar", { fg = visual.fg, bg = visual.bg })
  vim.api.nvim_set_hl(0, "WindowPickerWinBarNC", { fg = visual.fg, bg = visual.bg })
end

set_colors()

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.window.mappings["<2-LeftMouse>"] = "open_with_window_picker"
      opts.window.mappings["<cr>"] = "open_with_window_picker"
      opts.window.mappings["S"] = "split_with_window_picker"
      opts.window.mappings["s"] = "vsplit_with_window_picker"
    end,
  },

  {
    "s1n7ax/nvim-window-picker",
    opts = {
      hint = "floating-big-letter",
      show_prompt = false,
      selection_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
      picker_config = {
        handle_mouse_click = true,
        statusline_winbar_picker = {
          use_winbar = "smart",
        },
      },
    },
  },
}
