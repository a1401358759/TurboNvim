-- https://github.com/voldikss/vim-translator
-- :Translate                                  " translate the word under the cursor
-- :Translate --engines=google,youdao are you ok " translate text `are you ok` using google and youdao engines
-- :2Translate ...                             " translate line 2
-- :1,3Translate ...                           " translate line 1 to line 3
-- :'<,'>Translate ...                         " translate selected lines
-- Once the translation window is opened, type <C-w>p to jump into it and again to jump back

vim.g.translator_target_lang = "zh"
vim.g.translator_source_lang = "auto"
vim.g.translator_default_engines = { "bing", "youdao" }
vim.g.translator_window_type = "popup" -- preview

return {
  "voldikss/vim-translator",
  lazy = true,
  event = "VeryLazy",
  keys = {
    {
      "<leader>tw",
      "<cmd>TranslateW<cr>",
      desc = "Display translation in a window",
    },
    -- {
    --   "<leader>tR",
    --   "<cmd>TranslateR<cr>",
    --   desc = "Replace the text with translation",
    -- },
  },
}
