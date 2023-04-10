return {
  "akinsho/toggleterm.nvim",
  lazy = true,
  event = "VeryLazy",
  version = "*",
  opts = function()
    local M = {}
    local toggleterm = require("toggleterm")
    local terms = require("toggleterm.terminal").Terminal

    toggleterm.setup({
      start_in_insert = true,
      shade_terminals = false,
      shading_factor = -30,
      size = function(term)
        if term.direction == "horizontal" then
          return vim.o.lines * 0.25
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.25
        end
      end,
      on_open = function()
        vim.wo.spell = false
      end,
      highlights = {
        Normal = {
          link = "Normal",
        },
        NormalFloat = {
          link = "NormalFloat",
        },
        FloatBorder = {
          link = "FloatBorder",
        },
      },
      float_opts = {
        border = "curved", -- 'single' | 'double' | 'shadow' | 'curved'
        width = function()
          return math.ceil(vim.o.columns * 0.85)
        end,
        height = function()
          return math.ceil(vim.o.lines * 0.8)
        end,
      },
    })

    M.terminals = {
      horizontal = nil,
      vert = nil,
      float = nil,
      lazygit = nil,
      lazydocker = nil,
    }

    function M.close_callback()
      vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { silent = true, desc = "Escape terminal insert mode" })
    end

    function M.open_callback()
      vim.cmd("startinsert")
      vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { silent = true, desc = "Escape terminal insert mode" })
    end

    M.terminals.horizontal = terms:new({
      direction = "horizontal",
    })

    M.terminals.vert = terms:new({
      direction = "vertical",
    })

    M.terminals.float = terms:new({
      hidden = true,
      count = 120,
      direction = "float",
      on_open = function(term)
        M.open_callback()
        vim.keymap.set(
          "t",
          "<esc>",
          "<c-\\><c-n><cmd>close<cr>",
          { silent = true, buffer = term.bufnr, desc = "Escape float terminal" }
        )
        vim.keymap.set(
          "t",
          "<esc><esc>",
          "<c-\\><c-n><cmd>close<cr>",
          { silent = true, buffer = term.bufnr, desc = "Escape float terminal" }
        )
      end,
      on_close = M.close_callback,
    })

    M.terminals.lazygit = terms:new({
      cmd = "lazygit",
      count = 120,
      hidden = true,
      direction = "float",
      on_open = function(term)
        M.open_callback()
        vim.keymap.set(
          "i",
          "q",
          "<cmd>close<cr>",
          { silent = true, buffer = term.bufnr, desc = "Escape lazygit terminal" }
        )
      end,
      on_close = M.close_callback,
    })

    M.terminals.lazydocker = terms:new({
      cmd = "lazydocker",
      count = 120,
      hidden = true,
      direction = "float",
      on_open = function(term)
        M.open_callback()
        vim.keymap.set(
          "i",
          "q",
          "<cmd>close<cr>",
          { silent = true, buffer = term.bufnr, desc = "Escape lazydocker terminal" }
        )
      end,
      on_close = M.close_callback,
    })

    toggleterm.horizontal_toggle = function()
      ---@diagnostic disable-next-line: missing-parameter
      M.terminals.horizontal:toggle()
    end

    toggleterm.vertical_toggle = function()
      ---@diagnostic disable-next-line: missing-parameter
      M.terminals.vert:toggle()
    end

    toggleterm.float_toggle = function()
      ---@diagnostic disable-next-line: missing-parameter
      M.terminals.float:toggle()
    end

    toggleterm.lazygit_toggle = function()
      ---@diagnostic disable-next-line: missing-parameter
      M.terminals.lazygit:toggle()
    end

    toggleterm.lazydocker_toggle = function()
      ---@diagnostic disable-next-line: missing-parameter
      M.terminals.lazydocker:toggle()
    end
  end,
  keys = {
    {
      "<leader>tt",
      function()
        require("toggleterm").horizontal_toggle()
      end,
      desc = "Toggle horizontal terminal",
    },
    {
      "<leader>tv",
      function()
        require("toggleterm").vertical_toggle()
      end,
      desc = "Toggle vertical terminal",
    },
    {
      "<leader>tf",
      function()
        require("toggleterm").float_toggle()
      end,
      desc = "Toggle floating terminal",
    },
    {
      "<leader>tg",
      function()
        require("toggleterm").lazygit_toggle()
      end,
      desc = "Toggle lazygit terminal",
    },
    {
      "<leader>td",
      function()
        require("toggleterm").lazydocker_toggle()
      end,
      desc = "Toggle lazydocker terminal",
    },
  },
}
