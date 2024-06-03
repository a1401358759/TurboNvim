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

require("utils.plugin").setup()
require("lazy").setup({
  defaults = {
    lazy = true, -- should plugins be lazy-loaded?
  },
  spec = {
    { import = "plugins" },
  },
  ui = {
    border = "rounded",
    backdrop = 60,
  },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      disabled_plugins = {
        "editorconfig",
        "gzip",
        "matchit",
        "netrwPlugin",
        "shada",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
