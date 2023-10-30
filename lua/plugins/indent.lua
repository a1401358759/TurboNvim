---@diagnostic disable: missing-fields
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
        style = {
          { fg = "#806d9c" },
        },
        textobject = "",
        max_file_size = 1024 * 1024,
        error_sign = false,
      },
      indent = {
        enable = true,
        use_treesitter = false,
        notify = false,
        chars = { "┊" },
        -- chars = { "│", "¦", "┆", "┊" },
      },
      line_num = {
        enable = true,
        use_treesitter = false,
        style = "#806d9c",
      },
      blank = {
        enable = false,
      },
    })
  end,
}
