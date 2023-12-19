return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false,
  config = function()
    require("telescope").setup({
      defaults = {
        prompt_prefix = "  ",
        selection_caret = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal", -- bottom_pane
        color_devicons = true,
        entry_prefix = " ",
        multi_icon = "  ",
        file_ignore_patterns = { "node_modules" },
      },
      extensions = {},
    })
  end,
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files in the current workspace" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Find string in the current workspace" },
    { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Find telescope history" },
    { "<leader>fh", "<cmd>Telescope resume<CR>", desc = "Find last lookup" },
    { "<leader>ft", "<cmd>Telescope help_tags<CR>", desc = "Find all help document tags" },
    { "<leader>fm", "<cmd>Telescope marks<CR>", desc = "Find marks in the current workspace" },
    { "<leader>fi", "<cmd>Telescope highlights<CR>", desc = "Find all neovim highlights" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find all buffers" },
    { "<leader>f/", "<cmd>Telescope search_history<CR>", desc = "Find all search history" },
    { "<leader>f:", "<cmd>Telescope command_history<CR>", desc = "Find all command history" },
    { "<leader>fe", "<cmd>Telescope diagnostics<CR>", desc = "Find diagnostics in the current workspace" },
  },
}
