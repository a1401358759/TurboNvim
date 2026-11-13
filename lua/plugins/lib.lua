-- 依赖库。

return {
  {
    name = "plenary",
    "https://github.com/nvim-lua/plenary.nvim",
  },

  {
    name = "nui",
    "https://github.com/MunifTanjim/nui.nvim",
  },

  {
    name = "nio",
    "https://github.com/nvim-neotest/nvim-nio",
  },

  {
    name = "sqlite",
    "https://github.com/kkharji/sqlite.lua",
  },

  {
    name = "nvim-web-devicons",
    "https://github.com/nvim-tree/nvim-web-devicons",
    on = "start",
    config = function()
      require("nvim-web-devicons").setup({
        override = require("config.icons").devicons,
      })
    end,
  },
}
