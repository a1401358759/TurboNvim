return {
  "shellRaining/hlchunk.nvim",
  event = { "UIEnter" },
  config = function()
    -- vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { pattern = "*", command = "EnableHL" })
    require("hlchunk").setup({
      chunk = {
        enable = true,
        use_treesitter = true,
        notify = false,
        chars = {
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = ">",
        },
        style = {
          { fg = "#806d9c" },
          { fg = "#c21f30" }, -- this fg is used to highlight wrong chunk
        },
        textobject = "",
        max_file_size = 1024 * 1024,
        error_sign = true,
      },
      indent = {
        enable = true,
        use_treesitter = false,
        notify = false,
        -- chars = { "│" },
        chars = { "│", "¦", "┆", "┊" },
        style = {
          { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui") },
        },
      },
      line_num = {
        enable = true,
        use_treesitter = false,
        notify = false,
        style = "#806d9c",
      },
      blank = {
        enable = false,
        use_treesitter = false,
        notify = false,
        chars = { "․" },
        style = {
          vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
        },
      },
      context = {
        enable = false,
        notify = false,
        use_treesitter = false,
        chars = {},
      },
    })
  end,
}
