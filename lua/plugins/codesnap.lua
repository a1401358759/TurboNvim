return {
  "mistricky/codesnap.nvim",
  event = "TurboLoad",
  build = "make",
  keys = {
    { "<leader>cc", "<Esc><cmd>CodeSnap<cr>", mode = { "v", "x" }, desc = "Save selected code snapshot into clipboard" },
    { "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = { "v", "x" }, desc = "Save selected code snapshot in ~/Pictures" },
  },
  opts = {
    bg_theme = "dusk",
    watermark = "",
    bg_x_padding = 112,
    bg_y_padding = 72,
    code_font_family = "Maple Mono NF CN",
  },
}
