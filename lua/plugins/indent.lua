---@diagnostic disable: missing-fields
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    cond = false,
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
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
    event = { "UIEnter" },
    config = function()
      local cb = function()
        if vim.g.colors_name == "tokyonight" then
          return "#806d9c"
        else
          return "#00ffff"
        end
      end

      require("hlchunk").setup({
        chunk = {
          enable = false,
          notify = false,
          style = {
            { fg = cb },
            { fg = "#c21f30" }, -- this fg is used to highlight wrong chunk
          },
          chars = {
            horizontal_line = "─",
            vertical_line = "▏",
            left_top = "╭",
            left_bottom = "╰",
            right_arrow = ">",
          },
        },
        indent = {
          chars = { "▏" },
          style = {
            { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui") },
          },
        },
        blank = { enable = false },
        line_num = { enable = false, style = "#806d9c" },
      })
    end,
  },
}
