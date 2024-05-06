return {
  {
    "echasnovski/mini.comment",
    lazy = true,
    opts = {},
  },
  {
    "echasnovski/mini.surround",
    lazy = true,
    event = { "TurboLoad" },
    opts = {
      mappings = {
        add = "ys", -- Add surrounding in Normal and Visual modes
        delete = "ds", -- Delete surrounding
        find = "bf", -- Find surrounding (to the right)
        find_left = "bF", -- Find surrounding (to the left)
        highlight = "bh", -- Highlight surrounding
        replace = "cs", -- Replace surrounding
        update_n_lines = "bn", -- Update `n_lines`
      },
      silent = true,
    },
  },
  {
    "echasnovski/mini.pairs",
    lazy = true,
    event = { "InsertEnter" },
    opts = {
      mappings = {
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\`].", register = { cr = false } },
      },
    },
    keys = {
      {
        "<leader>up",
        function()
          vim.g.minipairs_disable = not vim.g.minipairs_disable
          if vim.g.minipairs_disable then
            vim.notify("Disabled auto pairs", vim.log.levels.WARN, { title = "Option" })
          else
            vim.notify("Enabled auto pairs", vim.log.levels.WARN, { title = "Option" })
          end
        end,
        desc = "Toggle auto pairs",
      },
    },
  },
  {
    "echasnovski/mini.bufremove",
    lazy = true,
    keys = {
      {
        "<leader>bd",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = "Delete Buffer",
      },
    -- stylua: ignore
    { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },
  {
    "echasnovski/mini.move",
    lazy = true,
    opts = {},
    keys = {
      -- Visual
      { "<A-h>", "<cmd>lua MiniMove.move_selection('left')<CR>", desc = "Move left", mode = { "v", "x" } },
      { "<A-l>", "<cmd>lua MiniMove.move_selection('right')<CR>", desc = "Move right", mode = { "v", "x" } },
      { "<A-j>", "<cmd>lua MiniMove.move_selection('down')<CR>", desc = "Move down", mode = { "v", "x" } },
      { "<A-k>", "<cmd>lua MiniMove.move_selection('up')<CR>", desc = "Move up", mode = { "v", "x" } },
      -- Normal
      { "<A-h>", "<cmd>lua MiniMove.move_line('left')<CR>", desc = "Move line left", mode = "n" },
      { "<A-l>", "<cmd>lua MiniMove.move_line('right')<CR>", desc = "Move line right", mode = "n" },
      { "<A-j>", "<cmd>lua MiniMove.move_line('down')<CR>", desc = "Move line down", mode = "n" },
      { "<A-k>", "<cmd>lua MiniMove.move_line('up')<CR>", desc = "Move line up", mode = "n" },
    },
  },
}
