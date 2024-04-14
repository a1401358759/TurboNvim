-- https://github.com/danymat/neogen
-- Add comments for class,function and file

return {
  "danymat/neogen",
  lazy = true,
  event = { "TurboLoad" },
  config = function()
    require("neogen").setup({
      enabled = true,
      input_after_comment = true,
      languages = {
        python = {
          template = {
            annotation_convention = "google_docstrings",
          },
        },
      },
      snippet_engine = "luasnip",
    })
  end,
  keys = {
    { "<leader>nc", "<cmd>lua require('neogen').generate({ type = 'class' })<CR>", desc = "Comments Class" },
    { "<leader>nf", "<cmd>lua require('neogen').generate({ type = 'func' })<CR>", desc = "Comments Function" },
    { "<leader>nF", "<cmd>lua require('neogen').generate({ type = 'file' })<CR>", desc = "Comments File" },
  },
}
