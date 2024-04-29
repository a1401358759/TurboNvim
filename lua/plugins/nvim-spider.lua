return {
  "chrisgrieser/nvim-spider",
  lazy = true,
  keys = {
    {
      "w",
      "<cmd>lua require('spider').motion('w')<CR>",
      mode = { "n", "o", "x" },
      { desc = "Spider-w" },
    },
    {
      "e",
      "<cmd>lua require('spider').motion('e')<CR>",
      mode = { "n", "o", "x" },
      { desc = "Spider-e" },
    },
    {
      "b",
      "<cmd>lua require('spider').motion('b')<CR>",
      mode = { "n", "o", "x" },
      { desc = "Spider-b" },
    },
    { "cw", "c<cmd>lua require('spider').motion('e')<CR>", desc = "Spider-cw" },
    { "<C-e>", "<Esc><cmd>lua require('spider').motion('e')<CR>a", mode = { "i" } },
    { "<C-f>", "<Esc>l<cmd>lua require('spider').motion('w')<CR>i", mode = { "i" } },
    { "<C-b>", "<Esc><cmd>lua require('spider').motion('b')<CR>i", mode = { "i" } },
  },
}
