return {
  "andrewferrier/debugprint.nvim",
  lazy = true,
  cmd = {
    "ToggleCommentDebugPrints",
    "DeleteDebugPrints",
  },
  opts = {
    commands = {
      toggle_comment_debug_prints = "ToggleCommentDebugPrints",
      delete_debug_prints = "DeleteDebugPrints",
    },
    print_tag = "DEBUGPRINT",
  },
  keys = {
    { "g?p", mode = "n", desc = "plain debug below current line" },
    { "g?P", mode = "n", desc = "plain debug above current line" },
    { "g?v", mode = "n", desc = "Variable debug below current line" },
    { "g?V", mode = "n", desc = "Variable debug above current line" },
    { "g?o", mode = "n", desc = "Text-obj-selected variable debug below current line" },
    { "g?O", mode = "n", desc = "Text-obj-selected variable debug above current line" },
    { "g?v", mode = "x", desc = "Variable debug below current line" },
    { "g?V", mode = "x", desc = "Variable debug above current line" },
    { "g?r", mode = "n", desc = "Variable debug below current line (always prompt)" },
    { "g?R", mode = "n", desc = "Variable debug above current line (always prompt)" },
    { "<leader>dd", "<cmd>DeleteDebugPrints<cr>", desc = "Delete DebugPrints" },
  },
}
