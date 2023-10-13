-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- This file is automatically loaded by plugins.core

vim.g.autoformat = true

local opt = vim.opt

opt.cmdheight = 0
opt.fillchars = { eob = " " }

-- custmo config
local options = {}
options.transparent = false
options.float_border = true
options.show_winbar = true

-- auto command manager
options.auto_save = true
options.auto_reload = false
options.auto_switch_input = true
options.auto_restore_cursor_position = true
options.auto_remove_new_lines_comment = true
return options
