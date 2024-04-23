return {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  dependencies = { "nvim-telescope/telescope-fzf-native.nvim" },
  cmd = "Telescope",
  version = false,
  opts = function(_, opts)
    local open_with_trouble = require("trouble.sources.telescope").open
    return vim.tbl_deep_extend("force", opts, {
      defaults = {
        mappings = {
          i = {
            ["<c-t>"] = open_with_trouble,
            ["<a-t>"] = open_with_trouble,
          },
        },
      },
    })
  end,
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
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
    })
  end,
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files in the current workspace" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Find string in the current workspace" },
    { "<leader>/", "<cmd>Telescope live_grep<CR>", desc = "Find string in the current workspace" },
    { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Find files history" },
    { "<leader>fh", "<cmd>Telescope resume<CR>", desc = "Find last lookup" },
    { "<leader>ft", "<cmd>Telescope help_tags<CR>", desc = "Find all help document tags" },
    { "<leader>fm", "<cmd>Telescope marks<CR>", desc = "Find marks in the current workspace" },
    { "<leader>fi", "<cmd>Telescope highlights<CR>", desc = "Find all neovim highlights" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find all buffers" },
    { "<leader>f/", "<cmd>Telescope search_history<CR>", desc = "Find all search history" },
    { "<leader>f:", "<cmd>Telescope command_history<CR>", desc = "Find all command history" },
    { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Find diagnostics in the current workspace" },
    {
      "<leader>fs",
      "<cmd>lua require('telescope.builtin').spell_suggest()<cr>",
      desc = "Find spelling suggestions",
    },
  },
}
