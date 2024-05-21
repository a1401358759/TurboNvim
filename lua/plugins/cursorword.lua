return {
  "xiyaowong/nvim-cursorword",
  lazy = true,
  event = { "TurboLoad" },
  config = function()
    -- set cursorword gui
    vim.api.nvim_create_autocmd({ "FileType" }, {
      callback = function()
        local bg = "#504945"
        local fg_color = require("utils.ui").fg("LineNr")
        if fg_color ~= nil then
          bg = fg_color.fg
        end
        vim.api.nvim_set_hl(0, "CursorWord", { fg = "NONE", bg = bg })
      end,
    })
  end,
}
