return {
  "akinsho/bufferline.nvim",
  event = "LspAttach",
  opts = {
    options = {
      themable = true,
      show_close_icon = true,
      numbers = "ordinal",
      buffer_close_icon = "",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      separator_style = { "", "" },
      indicator_icon = " ",
      always_show_bufferline = true,
      diagnostics = false,
      offsets = {
        {
          filetype = "neo-tree",
          text = "EXPLORER",
          text_align = "center",
          highlight = "Directory",
          padding = 0,
        },
        {
          filetype = "NvimTree",
          text = "EXPLORER",
          text_align = "center",
          highlight = "Directory",
          padding = 0,
        },
      },
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd("BufAdd", {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    {

      "<leader>bq",
      "<cmd>BufferLinePickClose<cr>",
      desc = "Close target buffer",
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
    {
      "<A-,>",
      "<cmd>BufferLineMovePrev<cr>",
      desc = "Move current buffer to left",
    },
    {
      "<A-.>",
      "<cmd>BufferLineMoveNext<cr>",
      desc = "Move current buffer to right",
    },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
  },
}
