return {
  "saghen/blink.pairs",
  version = "*", -- (recommended) only required with prebuilt binaries
  event = "TurboLoad",
  dependencies = "saghen/blink.download",
  --- @module 'blink.pairs'
  opts = {
    mappings = {
      enabled = true,
      disabled_filetypes = {},
      pairs = {},
    },
    highlights = {
      enabled = true,
      groups = {
        "BlinkPairsOrange",
        "BlinkPairsPurple",
        "BlinkPairsBlue",
      },
      matchparen = {
        enabled = true,
        group = "MatchParen",
      },
    },
    debug = false,
  },
  config = function(_, opts)
    require("blink.pairs").setup(opts)
  end,
}
