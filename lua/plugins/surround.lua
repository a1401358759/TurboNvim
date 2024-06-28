return {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "TurboLoad",
    config = function()
      require("nvim-surround").setup({
        surrounds = {
          ["("] = {
            add = { "(", ")" },
          },
        },
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    lazy = true,
    event = { "InsertEnter" },
    opts = {
      break_undo = false, -- switch for basic rule break undo sequence
      map_cr = false,
    },
  },
}
