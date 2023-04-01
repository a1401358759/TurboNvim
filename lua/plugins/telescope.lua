return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false,
  lazy = true,
  config = function()
    local fb_actions = require("telescope._extensions.file_browser.actions")
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
        file_browser = {
          -- theme = "ivy",
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          mappings = {
            ["i"] = {
              ["<A-c>"] = fb_actions.create,
              ["<S-CR>"] = fb_actions.create_from_prompt,
              ["<A-r>"] = fb_actions.rename,
              ["<A-m>"] = fb_actions.move,
              ["<A-y>"] = fb_actions.copy,
              ["<A-d>"] = fb_actions.remove,
              ["<C-o>"] = fb_actions.open,
              ["<C-g>"] = fb_actions.goto_parent_dir,
              ["<C-e>"] = fb_actions.goto_home_dir,
              ["<C-w>"] = fb_actions.goto_cwd,
              ["<C-t>"] = fb_actions.change_cwd,
              ["<C-f>"] = fb_actions.toggle_browser,
              ["<C-h>"] = fb_actions.toggle_hidden,
              ["<C-s>"] = fb_actions.toggle_all,
              ["<bs>"] = fb_actions.backspace,
            },
            ["n"] = {
              ["c"] = fb_actions.create,
              ["r"] = fb_actions.rename,
              ["m"] = fb_actions.move,
              ["y"] = fb_actions.copy,
              ["d"] = fb_actions.remove,
              ["o"] = fb_actions.open,
              ["g"] = fb_actions.goto_parent_dir,
              ["e"] = fb_actions.goto_home_dir,
              ["w"] = fb_actions.goto_cwd,
              ["t"] = fb_actions.change_cwd,
              ["f"] = fb_actions.toggle_browser,
              ["h"] = fb_actions.toggle_hidden,
              ["s"] = fb_actions.toggle_all,
            },
          },
        },
      },
    })
    require("telescope").load_extension("projects")
    require("telescope").load_extension("file_browser")
  end,
  opts = {},
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
    { "<leader>fB", ":Telescope file_browser<CR>", desc = "File browser" },
    { "<leader>fp", ":Telescope projects<CR>", desc = "Find projects" },
  },
}
