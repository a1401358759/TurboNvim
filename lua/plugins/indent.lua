---@diagnostic disable: missing-fields
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    cond = true,
    event = { "TurboLoad" },
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
    cond = false,
    config = function()
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
