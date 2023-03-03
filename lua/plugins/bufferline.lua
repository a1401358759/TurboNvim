return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      themable = true,
      show_close_icon = true,
      -- ordinal
      numbers = "ordinal",
      buffer_close_icon = "",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      separator_style = "thin",
      indicator = { icon = "▎", style = "icon" },
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      -- diagnostics_indicator = function(_, _, diag)
      --   local icons = require("lazyvim.config").icons.diagnostics
      --   local ret = (diag.error and icons.Error .. diag.error .. " " or "")
      --     .. (diag.warning and icons.Warn .. diag.warning or "")
      --   return vim.trim(ret)
      -- end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
        {
          filetype = "NvimTree",
          text = "Nvim-Tree",
          highlight = "Directory",
          text_align = "center",
          padding = 1,
        },
        {
          filetype = "aerial",
          text = "Outline Explorer",
          highlight = "Directory",
          text_align = "left",
        },
        {
          filetype = "undotree",
          text = "Undo Explorer",
          highlight = "Directory",
          text_align = "center",
        },
        {
          filetype = "dbui",
          text = "Database Explorer",
          highlight = "Directory",
          text_align = "center",
        },
        {
          filetype = "spectre_panel",
          text = "Project Blurry Search",
          highlight = "Directory",
          text_align = "center",
        },
        {
          filetype = "toggleterm",
          text = "Integrated Terminal",
          highlight = "Directory",
          text_align = "center",
        },
      },
    },
  },
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    {
      "<c-q>",
      "<cmd>BufferDelete<CR>",
      desc = "Close current buffer",
    },
    {

      "<leader>bq",
      "<cmd>BufferLinePickClose<cr>",
      desc = "Close target buffer",
    },
    {
      "<A-h>",
      "<cmd>BufferLineCyclePrev<cr>",
      desc = "Go to left buffer",
    },
    {
      "<A-l>",
      "<cmd>BufferLineCycleNext<cr>",
      desc = "Go to right buffer",
    },
    {
      "<A-e>",
      "<cmd>BufferLineMovePrev<cr>",
      desc = "Move current buffer to left",
    },
    {
      "<A-y>",
      "<cmd>BufferLineMoveNext<cr>",
      desc = "Move current buffer to right",
    },
    {
      "<leader>bn",
      "<cmd>enew<cr>",
      desc = "Create new buffer",
    },
    {
      "<leader>bh",
      "<cmd>BufferLineCloseLeft<cr>",
      desc = "Close all left buffers",
    },
    {
      "<leader>bl",
      "<cmd>BufferLineCloseRight<cr>",
      desc = "Close all right buffers",
    },
    {
      "<leader>bo",
      function()
        vim.cmd("BufferLineCloseLeft")
        vim.cmd("BufferLineCloseRight")
      end,
      desc = "Close all other buffers",
    },
    {
      "<leader>ba",
      function()
        vim.cmd("BufferLineCloseLeft")
        vim.cmd("BufferLineCloseRight")
        vim.cmd("BufferDelete")
      end,
      desc = "Close all buffers",
    },
    {
      "<leader>bt",
      "<cmd>BufferLinePick<cr>",
      desc = "Go to buffer *",
    },
    {
      "<leader>bs",
      "<cmd>BufferLineSortByExtension<cr>",
      desc = "Buffers sort (by extension)",
    },
    {
      "<A-1>",
      "<cmd>BufferLineGoToBuffer 1<cr>",
      desc = "Go to buffer 1",
    },
    {
      "<A-2>",
      "<cmd>BufferLineGoToBuffer 2<cr>",
      desc = "Go to buffer 2",
    },
    {
      "<A-3>",
      "<cmd>BufferLineGoToBuffer 3<cr>",
      desc = "Go to buffer 3",
    },
    {
      "<A-4>",
      "<cmd>BufferLineGoToBuffer 4<cr>",
      desc = "Go to buffer 4",
    },
    {
      "<A-5>",
      "<cmd>BufferLineGoToBuffer 5<cr>",
      desc = "Go to buffer 5",
    },
    {
      "<A-6>",
      "<cmd>BufferLineGoToBuffer 6<cr>",
      desc = "Go to buffer 6",
    },
    {
      "<A-7>",
      "<cmd>BufferLineGoToBuffer 7<cr>",
      desc = "Go to buffer 7",
    },
    {
      "<A-8>",
      "<cmd>BufferLineGoToBuffer 8<cr>",
      desc = "Go to buffer 8",
    },
    {
      "<A-9>",
      "<cmd>BufferLineGoToBuffer 9<cr>",
      desc = "Go to buffer 9",
    },
  },
}
