-- Done
-- https://github.com/iamcco/vim-language-server
-- npm install -g vim-language-server

local util = require("lspconfig.util")

return {
  cmd = { "vim-language-server", "--stdio" },
  filetypes = { "vim" },
  root_dir = util.find_git_ancestor,
  init_options = {
    isNeovim = true,
    iskeyword = "@,48-57,_,192-255,-#",
    vimruntime = "",
    runtimepath = "",
    diagnostic = { enable = true },
    indexes = {
      runtimepath = true,
      gap = 100,
      count = 3,
      projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
    },
    suggest = { fromVimruntime = true, fromRuntimepath = true },
  },
  single_file_support = true,
}
