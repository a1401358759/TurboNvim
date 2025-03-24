require("config.options")
require("config.autocmds")
require("config.keymaps")
require("config.lazy")

local colorscheme = os.getenv("NVIM_COLORSCHEME") or "tokyonight"
vim.cmd([[colorscheme ]] .. colorscheme)
