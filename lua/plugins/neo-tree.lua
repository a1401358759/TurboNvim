local icons = require("config.icons").icons

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, but recommended
  },
  lazy = true,
  cmd = "Neotree",
  ---@module 'neo-tree'
  ---@type neotree.Config
  opts = {
    sources = { "filesystem", "buffers", "git_status" },
    ---@diagnostic disable-next-line: missing-fields
    source_selector = {
      winbar = false, -- toggle to show selector on winbar
      statusline = false,
    },
    enable_diagnostics = false,
    open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
    default_component_configs = {
      ---@diagnostic disable-next-line: missing-fields
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        folder_empty_open = "",
        use_filtered_colors = true,
      },
      modified = { symbol = "" },
      git_status = { symbols = icons.git },
      diagnostics = { symbols = icons.diagnostics },
    },
    filesystem = {
      follow_current_file = { enabled = true },
      filtered_items = {
        show_hidden_count = false,
        hide_by_pattern = { -- uses glob style patterns
          "__pycache__",
        },
      },
    },
  },
  keys = {
    {
      "<leader>fe",
      function()
        require("neo-tree.command").execute({ source = "filesystem", toggle = true })
      end,
      desc = "Explorer NeoTree",
    },
    {
      "<leader>ge",
      function()
        require("neo-tree.command").execute({ source = "git_status", toggle = true })
      end,
      desc = "Git explorer",
    },
    {
      "<leader>be",
      function()
        require("neo-tree.command").execute({ source = "buffers", toggle = true })
      end,
      desc = "Buffer explorer",
    },
    { "<leader>e", "<leader>fe", desc = "Explorer NeoTree", remap = true },
  },
}
