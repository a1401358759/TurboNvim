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

require("config.autocmds")

local Event = require("lazy.core.handler.event")
Event.mappings.TurboLoad = { id = "TurboLoad", event = "User", pattern = "TurboLoad" }
Event.mappings["User TurboLoad"] = Event.mappings.TurboLoad

require("lazy").setup({
  defaults = {
    lazy = true, -- should plugins be lazy-loaded?
  },
  spec = {
    { import = "plugins" },
  },
  ui = {
    border = "rounded",
  },
  checker = { enabled = true }, -- automatically check for plugin updates
})
