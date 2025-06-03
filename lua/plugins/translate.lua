return {
  "JuanZoran/Trans.nvim",
  dependencies = { "kkharji/sqlite.lua" },
  event = "TurboLoad",
  build = function()
    require("Trans").install()
  end,
  keys = {
    -- 可以换成其他你想映射的键
    { "<leader>ts", mode = { "n", "x" }, "<Cmd>Translate<CR>", desc = "󰊿 Translate" },
    { "<leader>tp", mode = { "n", "x" }, "<Cmd>TransPlay<CR>", desc = " Auto Play" },
    -- 目前这个功能的视窗还没有做好，可以在配置里将view.i改成hover
    { "<leader>ti", "<Cmd>TranslateInput<CR>", desc = "󰊿 Translate From Input" },
  },
  opts = {
    theme = "tokyonight", -- default | tokyonight | dracula
    frontend = {
      default = {
        auto_play = false,
      },
      hover = {
        keymaps = {
          pageup = "<C-u>",
          pagedown = "<C-d>",
          close = "q",
        },
      },
    },
  },
}
