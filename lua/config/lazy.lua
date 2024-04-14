local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Add LazyLoad event
-- If user starts neovim but does not edit a file, i.e., entering Dashboard directly, the LazyLoad event is hooked to the
-- next BufRead event. Otherwise, the event is triggered right after the VeryLazy event.
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    local function _trigger()
      vim.api.nvim_exec_autocmds("User", { pattern = "LazyLoad" })
    end

    if vim.bo.filetype == "dashboard" then
      vim.api.nvim_create_autocmd("BufRead", {
        once = true,
        callback = _trigger,
      })
    else
      _trigger()
    end
  end,
})

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  ui = {
    border = "rounded",
  },
  checker = { enabled = true }, -- automatically check for plugin updates
})
