return {
  "glepnir/lspsaga.nvim",
  lazy = true,
  event = "LspAttach",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    --Please make sure you install markdown and markdown_inline parser
    { "nvim-treesitter/nvim-treesitter" },
  },
  config = function()
    require("lspsaga").setup({
      ui = {
        -- This option only works in Neovim 0.9
        title = true,
        -- Border type can be single, double, rounded, solid, shadow.
        border = "rounded",
        winblend = 0,
        kind = {},
      },
      symbol_in_winbar = {
        enable = true,
        separator = " > ",
        ignore_patterns = {},
        hide_keyword = true,
        show_file = true,
        folder_level = 10,
        respect_root = true,
        color_mode = true,
      },
      outline = {
        win_position = "right",
        win_with = "",
        win_width = 30,
        preview_width = 0.4,
        show_detail = true,
        auto_preview = true,
        auto_refresh = true,
        auto_close = true,
        custom_sort = nil,
        keys = {
          expand_or_jump = "o",
          quit = "q",
        },
      },
      rename = {
        quit = "<ESC>",
        exec = "<CR>",
        mark = "x",
        confirm = "<CR>",
        in_select = true,
      },
    })
  end,
  keys = {
    { "<leader>2", ":Lspsaga outline<cr>", desc = "Lspsaga Outline" },
    { "<leader>xx", ":Lspsaga show_buf_diagnostics<cr>", desc = "Show buffer diagnostics" },
    { "<leader>xw", ":Lspsaga show_workspace_diagnostics<cr>", desc = "Show workspace diagnostic" },
    { "<leader>xl", ":Lspsaga show_line_diagnostics<cr>", desc = "Show line diagnostics" },
    { "<leader>xQ", ":TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
  },
}
