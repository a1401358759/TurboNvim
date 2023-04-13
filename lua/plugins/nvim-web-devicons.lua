return {
  "nvim-tree/nvim-web-devicons",
  opts = function()
    return { override = require("config.icons").devicons }
  end,
  config = function(_, opts)
    require("nvim-web-devicons").setup(opts)
  end,
}
