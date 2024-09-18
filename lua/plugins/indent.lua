---@diagnostic disable: missing-fields
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    cond = false,
    lazy = true,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      indent = { char = "▏", tab_char = "▏" },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
    main = "ibl",
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "TurboLoad" },
    config = function()
      -- local indent_color = function()
      --   local bg_color = require("utils.ui").bg("CursorLine").bg
      --   return bg_color
      -- end

      require("hlchunk").setup({
        chunk = {
          enable = false,
          notify = false,
        },
        indent = {
          enable = true,
          ahead_lines = 25,
          delay = 50,
          -- chars = { "│" },
          chars = { "▏" },
          -- style = {
          --   { fg = indent_color },
          -- },
          style = {
            vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
          },
        },
        blank = { enable = false },
        line_num = { enable = false },
      })
    end,
  },
}
