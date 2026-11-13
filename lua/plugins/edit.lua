-- 编辑。

return {
  {
    name = "persistence",
    "https://github.com/folke/persistence.nvim",
    on = "start",
    config = function()
      require("persistence").setup({ options = vim.opt.sessionoptions:get() })

      vim.keymap.set("n", "<leader>ss", function()
        require("persistence").load()
      end, { desc = "Restore Session", silent = true })
      vim.keymap.set("n", "<leader>sl", function()
        require("persistence").load({ last = true })
      end, { desc = "Restore Last Session", silent = true })
      vim.keymap.set("n", "<leader>sd", function()
        require("persistence").stop()
      end, { desc = "Don't Save Current Session", silent = true })
    end,
  },

  {
    name = "mini",
    src = {
      "https://github.com/folke/ts-comments.nvim",
      "https://github.com/echasnovski/mini.move",
      { "https://github.com/nvim-mini/mini.nvim", version = vim.version.range("*") },
      { "https://github.com/nvim-mini/mini.pairs", version = vim.version.range("*") },
    },
    on = "file",
    config = function()
      require("ts-comments").setup({})

      require("mini.move").setup({})

      vim.keymap.set(
        { "v", "x" },
        "<A-h>",
        "<cmd>lua MiniMove.move_selection('left')<CR>",
        { desc = "Move left", silent = true }
      )
      vim.keymap.set(
        { "v", "x" },
        "<A-l>",
        "<cmd>lua MiniMove.move_selection('right')<CR>",
        { desc = "Move right", silent = true }
      )
      vim.keymap.set(
        { "v", "x" },
        "<A-j>",
        "<cmd>lua MiniMove.move_selection('down')<CR>",
        { desc = "Move down", silent = true }
      )
      vim.keymap.set(
        { "v", "x" },
        "<A-k>",
        "<cmd>lua MiniMove.move_selection('up')<CR>",
        { desc = "Move up", silent = true }
      )
      vim.keymap.set(
        "n",
        "<A-h>",
        "<cmd>lua MiniMove.move_line('left')<CR>",
        { desc = "Move line left", silent = true }
      )
      vim.keymap.set(
        "n",
        "<A-l>",
        "<cmd>lua MiniMove.move_line('right')<CR>",
        { desc = "Move line right", silent = true }
      )
      vim.keymap.set(
        "n",
        "<A-j>",
        "<cmd>lua MiniMove.move_line('down')<CR>",
        { desc = "Move line down", silent = true }
      )
      vim.keymap.set("n", "<A-k>", "<cmd>lua MiniMove.move_line('up')<CR>", { desc = "Move line up", silent = true })

      require("mini.surround").setup({
        mappings = {
          add = "ys",
          delete = "ds",
          replace = "cs",
        },
      })

      require("mini.pairs").setup()
    end,
  },

  {
    name = "dial",
    "https://github.com/monaqa/dial.nvim",
    on = "file",
    config = function()
      local M = {}

      ---@param increment boolean
      ---@param g? boolean
      function M.dial(increment, g)
        local mode = vim.fn.mode(true)
        -- Use visual commands for VISUAL 'v', VISUAL LINE 'V' and VISUAL BLOCK '\22'
        local is_visual = mode == "v" or mode == "V" or mode == "\22"
        local func = (increment and "inc" or "dec") .. (g and "_g" or "_") .. (is_visual and "visual" or "normal")
        local group = vim.g.dials_by_ft[vim.bo.filetype] or "default"
        return require("dial.map")[func](group)
      end

      ---@param s string
      function M.str_title(s)
        return (s:gsub("(%a)([%w_']*)", function(f, r)
          return f:upper() .. r:lower()
        end))
      end

      local function dial_opts()
        local augend = require("dial.augend")

        local logical_alias = augend.constant.new({
          elements = { "&&", "||" },
          word = false,
          cyclic = true,
        })

        local ordinal_numbers = augend.constant.new({
          -- elements through which we cycle. When we increment, we go down
          -- On decrement we go up
          elements = {
            "first",
            "second",
            "third",
            "fourth",
            "fifth",
            "sixth",
            "seventh",
            "eighth",
            "ninth",
            "tenth",
          },
          -- if true, it only matches strings with word boundary. firstDate wouldn't work for example
          word = false,
          -- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
          -- Otherwise nothing will happen when there are no further values
          cyclic = true,
        })

        local weekdays = augend.constant.new({
          elements = {
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday",
            "Sunday",
          },
          word = true,
          cyclic = true,
        })

        local months = augend.constant.new({
          elements = {
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December",
          },
          word = true,
          cyclic = true,
        })

        local group_default = {
          augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.decimal_int, -- nonnegative and negative decimal number
          augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
          ordinal_numbers,
          weekdays,
          months,
          augend.constant.alias.bool, -- boolean value (true <-> false)
          logical_alias,
        }

        local word_antisense_switch = {
          { "true", "false" },
          { "on", "off" },
          { "yes", "no" },
          { "disable", "enable" },
          { "enabled", "disabled" },
          { "success", "failure" },
          { "open", "close" },
          { "in", "out" },
          { "resolve", "reject" },
          { "start", "end" },
          { "before", "after" },
          { "from", "to" },
          { "relative", "absolute" },
          { "up", "down" },
          { "left", "right" },
          { "top", "bottom" },
          { "first", "last" },
          { "next", "prev" },
          { "row", "column" },
          { "dark", "light" },
          { "inferior", "superior" },
          { "lower", "upper" },
          { "selected", "unselected" },
          { "active", "inactive" },
          { "white", "black" },
          { "get", "post" },
          { "forward", "backward" },
          { "odd", "even" },
          { "old", "new" },
          { "+", "-" },
          { ">", "<" },
          { "=", "!=" },
        }

        for _, value in ipairs(word_antisense_switch) do
          local upper_words = { string.upper(value[1]), string.upper(value[2]) }
          local title_words = { M.str_title(value[1]), M.str_title(value[2]) }
          table.insert(
            group_default,
            augend.constant.new({
              elements = value,
              word = true,
              cyclic = true,
            })
          )
          table.insert(
            group_default,
            augend.constant.new({
              elements = upper_words,
              word = true,
              cyclic = true,
            })
          )
          table.insert(
            group_default,
            augend.constant.new({
              elements = title_words,
              word = true,
              cyclic = true,
            })
          )
        end

        return {
          dials_by_ft = {
            css = "css",
            vue = "vue",
            javascript = "typescript",
            typescript = "typescript",
            typescriptreact = "typescript",
            javascriptreact = "typescript",
            json = "json",
            lua = "lua",
            markdown = "markdown",
            sass = "css",
            scss = "css",
            python = "python",
          },
          groups = {
            default = group_default,
            vue = {
              augend.constant.new({ elements = { "let", "const" } }),
              augend.hexcolor.new({ case = "lower" }),
              augend.hexcolor.new({ case = "upper" }),
            },
            typescript = {
              augend.constant.new({ elements = { "let", "const" } }),
            },
            css = {
              augend.hexcolor.new({
                case = "lower",
              }),
              augend.hexcolor.new({
                case = "upper",
              }),
            },
            markdown = {
              augend.misc.alias.markdown_header,
            },
            json = {
              augend.semver.alias.semver, -- versioning (v1.1.2)
            },
            lua = {
              augend.constant.new({
                elements = { "and", "or" },
                word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
                cyclic = true, -- "or" is incremented into "and".
              }),
            },
            python = {
              augend.constant.new({
                elements = { "and", "or" },
              }),
            },
          },
        }
      end

      local opts = dial_opts()
      for name, group in pairs(opts.groups) do
        if name ~= "default" then
          vim.list_extend(group, opts.groups.default)
        end
      end
      require("dial.config").augends:register_group(opts.groups)
      vim.g.dials_by_ft = opts.dials_by_ft

      vim.keymap.set({ "n", "v" }, "<C-a>", function()
        return M.dial(true)
      end, { expr = true, desc = "Increment", silent = true })
      vim.keymap.set({ "n", "v" }, "<C-x>", function()
        return M.dial(false)
      end, { expr = true, desc = "Decrement", silent = true })
      vim.keymap.set({ "n", "v" }, "g<C-a>", function()
        return M.dial(true, true)
      end, { expr = true, desc = "Increment", silent = true })
      vim.keymap.set({ "n", "v" }, "g<C-x>", function()
        return M.dial(false, true)
      end, { expr = true, desc = "Decrement", silent = true })
    end,
  },

  {
    name = "multicursor",
    "https://github.com/jake-stewart/multicursor.nvim",
    version = "1.0",
    on = "file",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      local set = vim.keymap.set
      set({ "n", "v" }, "<tab>", mc.nextCursor)
      set({ "n", "v" }, "<s-tab>", mc.prevCursor)
      set({ "n", "v" }, "<c-n>", function()
        mc.matchAddCursor(1)
      end)
      set({ "n", "v" }, "<c-s-n>", function()
        mc.matchAddCursor(-1)
      end)
      set({ "n", "v" }, "<c-s-j>", function()
        mc.matchSkipCursor(1)
      end, { desc = "Skip Cursor Down" })
      set({ "n", "v" }, "<c-s-k>", function()
        mc.matchSkipCursor(-1)
      end, { desc = "Skip Cursor Up" })
      set("n", "<c-leftmouse>", mc.handleMouse)
      set("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        elseif mc.hasCursors() then
          mc.clearCursors()
        else
          vim.cmd("nohlsearch")
        end
      end)
    end,
  },

  {
    name = "todo-comments",
    "https://github.com/folke/todo-comments.nvim",
    needs = { "trouble" },
    cmd = "TodoTrouble",
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
      { "<leader>xt", "TodoTrouble", desc = "Todo (Trouble)" },
      { "<leader>xT", "TodoTrouble keywords=TODO,FIX,FIXME", desc = "Todo/Fix/Fixme (Trouble)" },
      {
        "<leader>st",
        function()
          Snacks.picker.todo_comments()
        end,
        desc = "Todo",
      },
      {
        "<leader>sT",
        function()
          Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
        end,
        desc = "Todo/Fix/Fixme",
      },
    },
    config = function()
      require("todo-comments").setup()
    end,
  },

  {
    name = "grug-far",
    "https://github.com/MagicDuck/grug-far.nvim",
    cmd = { "GrugFar", "GrugFarWithin" },
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
    config = function()
      require("grug-far").setup({ headerMaxWidth = 80 })
    end,
  },

  {
    name = "csv",
    "https://github.com/hat0uma/csvview.nvim",
    ft = "csv",
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    config = function()
      require("csvview").setup({
        parser = { comments = { "#", "//" } },
        keymaps = {
          textobject_field_inner = { "if", mode = { "o", "x" } },
          textobject_field_outer = { "af", mode = { "o", "x" } },
          jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
          jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
          jump_next_row = { "<Enter>", mode = { "n", "v" } },
          jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
        },
      })
    end,
  },

  {
    name = "translate",
    "https://github.com/JuanZoran/Trans.nvim",
    needs = { "sqlite" },
    cmd = { "Translate", "TransPlay", "TranslateInput" },
    keys = {
      { "<leader>ts", "Translate", mode = { "n", "x" }, desc = "󰊿 Translate" },
      { "<leader>tp", "TransPlay", mode = { "n", "x" }, desc = " Auto Play" },
      { "<leader>ti", "TranslateInput", desc = "󰊿 Translate From Input" },
    },
    config = function()
      require("Trans").setup({
        theme = "tokyonight",
        frontend = {
          default = {
            auto_play = false,
          },
          hover = {
            keymaps = {
              pageup = "<C-u>",
              pagedown = "<C-d>",
              close = "q",
            },
          },
        },
      })
      local db = require("Trans").conf.dir .. "/ultimate.db"
      if vim.fn.filereadable(db) == 0 then
        require("Trans").install()
      end
    end,
  },

  {
    name = "yazi",
    "https://github.com/mikavilpas/yazi.nvim",
    needs = { "plenary" },
    cmd = "Yazi",
    keys = {
      { "<leader>tr", "Yazi", desc = "Open yazi at the current file" },
      { "<leader>cw", "Yazi cwd", desc = "Open the file manager in nvim's working directory" },
    },
    config = function()
      require("yazi").setup({
        open_for_directories = false,
        keymaps = {
          show_help = "<f1>",
        },
      })
    end,
  },
}
