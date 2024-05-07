return {
  "xiyaowong/nvim-cursorword",
  lazy = true,
  event = { "TurboLoad" },
  config = function()
    -- set cursorword gui
    vim.api.nvim_create_autocmd({ "FileType" }, {
      callback = function()
        vim.api.nvim_set_hl(0, "CursorWord", { fg = "NONE", bg = "#504945" })
      end,
    })
  end,
}
