return {
  {
    "echasnovski/mini.comment",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    opts = {},
  },
  {
    "echasnovski/mini.surround",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
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
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    opts = {},
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
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    opts = {},
    keys = function()
      local ret = {}
      local directions = { "left", "down", "up", "right" }
      local keys = { "h", "j", "k", "l" }
      local move = require("mini.move")
      for i, dir in ipairs(directions) do
        ret[#ret + 1] = {
          "<A-" .. keys[i] .. ">",
          mode = { "i", "n" },
          function()
            move.move_line(dir)
          end,
        }
      end
      for i, dir in ipairs(directions) do
        ret[#ret + 1] = {
          "<A-" .. keys[i] .. ">",
          mode = { "v" },
          function()
            move.move_selection(dir)
          end,
        }
      end
      return ret
    end,
  },
}
