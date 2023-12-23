-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- This file is automatically loaded by lazyvim.config.init.

local options = require("config.options")

-- Disable autoformat for python files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "python" },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- auto save buffer
if options.auto_save then
  vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    pattern = { "*" },
    command = "silent! wall",
    nested = true,
  })
end

-- auto reload log file
if options.auto_reload then
  vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    pattern = { "*" },
    callback = function()
      if vim.fn.mode() ~= "c" then
        vim.cmd([[checktime]])
      end
    end,
  })
end

-- switch input method
if options.auto_switch_input then
  vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    pattern = { "*" },
    callback = function()
      local input_status = tonumber(vim.fn.system("fcitx5-remote"))
      if input_status == 2 then
        vim.fn.system("fcitx5-remote -c")
      end
    end,
  })
end

-- auto restore cursor position
if options.auto_restore_cursor_position then
  vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = { "*" },
    callback = function()
      if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
        vim.fn.setpos(".", vim.fn.getpos("'\""))
        -- how do I center the buffer in a sane way??
        -- vim.cmd('normal zz')
        vim.cmd("silent! foldopen")
      end
    end,
  })
end

-- remove auto-comments
if options.auto_remove_new_lines_comment then
  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*" },
    callback = function()
      vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
    end,
  })
end

-- auto remove blank
vim.api.nvim_create_autocmd({ "BufWrite", "BufRead" }, {
  pattern = { "*" },
  command = [[silent! %s/\s\+$//ge]],
  nested = true,
})

-- Persisted
local group = vim.api.nvim_create_augroup("PersistedHooks", {})
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "PersistedSavePre",
  group = group,
  callback = function()
    vim.cmd("nohlsearch")
  end,
})

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "PersistedTelescopeLoadPre",
  group = group,
  callback = function()
    ---@diagnostic disable-next-line: param-type-mismatch
    pcall(vim.cmd, "SessionSave")
    vim.api.nvim_input("<ESC>:%bd<CR>")
  end,
})

vim.api.nvim_create_user_command("MakeDirectory", function()
  ---@diagnostic disable-next-line: missing-parameter
  local path = vim.fn.expand("%")
  local dir = vim.fn.fnamemodify(path, ":p:h")
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  else
    vim.notify("Directory already exists", "WARN", { title = "Nvim" })
  end
end, { desc = "Create directory if it doesn't exist" })

vim.api.nvim_create_user_command("BufferDelete", function()
  ---@diagnostic disable-next-line: missing-parameter
  local file_exists = vim.fn.filereadable(vim.fn.expand("%p"))
  local modified = vim.bo.modified

  if 0 == file_exists and modified then
    local user_choice = vim.fn.input("The file is not saved, whether to force delete? Press enter or input [y/n]:")
    if user_choice == "y" or user_choice:len() == 0 then
      vim.cmd("bd!")
    end
    return
  end

  local force = not vim.bo.buflisted or vim.bo.buftype == "nofile"

  vim.cmd(force and "bd!" or ("bp | bd! %s"):format(vim.api.nvim_get_current_buf()))
end, { desc = "Delete the current Buffer while maintaining the window layout" })

-- line number column is not displayed cursorline
vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function()
    vim.cmd([[hi! link CursorLineNr LineNr]])
  end,
})

-- set cursor word、cursorline、pumblend style
if options.transparent then
  vim.cmd([[
    hi NotifyBackground guibg = #000000
    set pumblend=0
  ]])
end
