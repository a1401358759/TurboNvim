return {
  "stevearc/aerial.nvim",
  lazy = true,
  event = "VeryLazy",
  opts = {
    show_guides = true,
    backends = { "lsp", "treesitter", "markdown" },
    update_events = "TextChanged,InsertLeave",
    layout = {
      min_width = 30,
      max_width = { 40, 0.2 },
    },
    lsp = {
      diagnostics_trigger_update = false,
      update_when_errors = true,
      update_delay = 300,
    },
    guides = {
      mid_item = "├─",
      last_item = "└─",
      nested_top = "│ ",
      whitespace = "  ",
    },
    filter_kind = {
      "Module",
      "Struct",
      "Interface",
      "Class",
      "Constructor",
      "Enum",
      "Function",
      "Method",
    },
  },
  keys = {
    {
      "<leader>2",
      "<cmd>AerialToggle! right<cr>",
      desc = "Open Outilne Explorer",
    },
    {
      "{",
      "<cmd>AerialPrev<cr>",
      desc = "Move item up",
    },
    {
      "}",
      "<cmd>AerialNext<cr>",
      desc = "Move item down",
    },
    {
      "[[",
      "<cmd>AerialPrevUp<cr>",
      desc = "Move up one level",
    },
    {
      "]]",
      "<cmd>AerialNextUp<cr>",
      desc = "Move down one level",
    },
  },
}
