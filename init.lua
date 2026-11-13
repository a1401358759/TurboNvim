vim.g.startup_ns = vim.uv.hrtime()

-- Skip unused builtin plugins before they load.
for _, name in ipairs({
  "editorconfig",
  "gzip",
  "matchit",
  "netrwPlugin",
  "shada",
  "tarPlugin",
  "tohtml",
  "tutor",
  "zipPlugin",
}) do
  vim.g["loaded_" .. name] = 1
end

require("config.options")
require("config.autocmds")
require("config.keymaps")
require("config.pack")

local colorscheme = os.getenv("NVIM_COLORSCHEME") or "tokyonight"
vim.cmd.colorscheme(colorscheme)
