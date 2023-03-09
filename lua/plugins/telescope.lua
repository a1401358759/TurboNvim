return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false,
  lazy = true,
  opts = {
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
      -- config
      layout_config = {
        bottom_pane = {
          height = 15,
          preview_cutoff = 100,
          prompt_position = "bottom",
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  },
  keys = {
    { "<leader>ff", ":Telescope find_files<CR>", desc = "Find files in the current workspace" },
    { "<leader>fg", ":Telescope live_grep<CR>", desc = "Find string in the current workspace" },
    { "<leader>fo", ":Telescope oldfiles<CR>", desc = "Find telescope history" },
    { "<leader>fh", ":Telescope resume<CR>", desc = "Find last lookup" },
    { "<leader>ft", ":Telescope help_tags<CR>", desc = "Find all help document tags" },
    { "<leader>fm", ":Telescope marks<CR>", desc = "Find marks in the current workspace" },
    { "<leader>fi", ":Telescope highlights<CR>", desc = "Find all neovim highlights" },
    { "<leader>fb", ":Telescope buffers<CR>", desc = "Find all buffers" },
    { "<leader>f/", ":Telescope search_history<CR>", desc = "Find all search history" },
    { "<leader>f:", ":Telescope command_history<CR>", desc = "Find all command history" },
  },
}
