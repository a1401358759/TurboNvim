-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- This file is automatically loaded by plugins.core

vim.g.autoformat = false

-- customize config
local options = {}
options.transparent = true
options.auto_save = true
options.auto_reload = false
options.auto_switch_input = true
options.auto_restore_cursor_position = true
options.auto_remove_new_lines_comment = true
options.use_ai_plugins = true
options.show_cursorline = false

local opt = vim.opt
opt.cmdheight = 0
opt.fillchars = { eob = " " }
opt.cursorline = options.show_cursorline
if options.transparent then
  opt.pumblend = 0
end

return options
