-- https://github.com/smoka7/multicursors.nvim

return {
  "smoka7/multicursors.nvim",
  lazy = true,
  dependencies = {
    "smoka7/hydra.nvim",
  },
  opts = {},
  cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
  keys = {
    {
      mode = { "v", "n" },
      "<C-n>",
      "<cmd>MCstart<cr>",
      desc = "Create a selection for selected text or word under the cursor",
    },
  },
  config = function()
    vim.api.nvim_set_hl(0, "MultiCursor", { link = "Search" })
    require("multicursors").setup({
      hint_config = {
        border = "rounded",
        position = "bottom-right",
      },
      generate_hints = {
        normal = true,
        insert = true,
        extend = true,
        config = {
          column_count = 1,
          max_hint_length = 30,
        },
      },
      normal_keys = {
        ["<C-/>"] = {
          method = function()
            require("multicursors.utils").call_on_selections(function(selection)
              vim.api.nvim_win_set_cursor(0, { selection.row + 1, selection.col + 1 })
              local line_count = selection.end_row - selection.row + 1
              vim.cmd("normal " .. line_count .. "gcc")
            end)
          end,
          opts = { desc = "comment selections" },
        },
      },
    })
  end,
}
