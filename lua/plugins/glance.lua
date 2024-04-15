---@diagnostic disable: missing-fields
return {
  "dnlhc/glance.nvim",
  lazy = true,
  config = function()
    local glance = require("glance")
    local actions = glance.actions
    glance.setup({
      detached = true,
      border = {
        enable = true, -- Show window borders. Only horizontal borders allowed
        top_char = "─",
        bottom_char = "─",
      },
      mappings = {
        list = {
          ["j"] = actions.next, -- Bring the cursor to the next item in the list
          ["k"] = actions.previous, -- Bring the cursor to the previous item in the list
          ["<Down>"] = actions.next,
          ["<Up>"] = actions.previous,
          ["<Tab>"] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
          ["<S-Tab>"] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
          ["<C-u>"] = actions.preview_scroll_win(5),
          ["<C-d>"] = actions.preview_scroll_win(-5),
          ["v"] = actions.jump_vsplit,
          ["s"] = actions.jump_split,
          ["t"] = actions.jump_tab,
          ["<CR>"] = actions.jump,
          ["o"] = actions.jump,
          ["l"] = actions.open_fold,
          ["h"] = actions.close_fold,
          ["<leader>l"] = actions.enter_win("preview"), -- Focus preview window
          ["q"] = actions.close,
          ["Q"] = actions.close,
          ["<Esc>"] = actions.close,
          ["<C-q>"] = actions.quickfix,
        },
        preview = {
          ["Q"] = actions.close,
          ["<Tab>"] = actions.next_location,
          ["<S-Tab>"] = actions.previous_location,
          ["<leader>l"] = actions.enter_win("list"), -- Focus list window
        },
      },
    })
  end,
  keys = {
    { "gpd", "<CMD>Glance definitions<CR>", desc = "Glance definitions" },
    { "gpr", "<CMD>Glance references<CR>", desc = "Glance references" },
    { "gpt", "<CMD>Glance type_definitions<CR>", desc = "Glance type_definitions" },
    { "gpi", "<CMD>Glance implementations<CR>", desc = "Glance implementations" },
  },
}
