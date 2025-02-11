-- https://github.com/jake-stewart/multicursor.nvim

return {
  "jake-stewart/multicursor.nvim",
  event = "TurboLoad",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()
    local set = vim.keymap.set
    -- 在主光标上方/下方添加或跳过光标。
    set({ "n", "v" }, "<c-up>", function()
      mc.lineAddCursor(-1)
    end)
    set({ "n", "v" }, "<c-down>", function()
      mc.lineAddCursor(1)
    end)
    -- 主光标在多光标之间移动。
    set({ "n", "v" }, "<c-left>", mc.nextCursor)
    set({ "n", "v" }, "<c-right>", mc.prevCursor)
    -- 通过匹配单词/选择来添加或跳过添加新光标
    set({ "n", "v" }, "<c-n>", function()
      mc.matchAddCursor(1)
    end)
    set({ "n", "v" }, "<c-s-n>", function()
      mc.matchAddCursor(-1)
    end)
    set({ "n", "v" }, "<c-k>", function()
      mc.matchSkipCursor(1)
    end, { desc = "Skip Cursor Down" })
    set({ "n", "v" }, "<c-s-k>", function()
      mc.matchSkipCursor(-1)
    end, { desc = "Skip Cursor Up" })
    -- 使用 Control + 左键单击添加和删除光标。
    set("n", "<c-leftmouse>", mc.handleMouse)
    -- 启用/禁用多光标。
    set("n", "<esc>", function()
      if not mc.cursorsEnabled() then
        mc.enableCursors()
      elseif mc.hasCursors() then
        mc.clearCursors()
      else
        vim.cmd("nohlsearch")
      end
    end)
  end,
}
