-- Done
-- https://github.com/iamcco/vim-language-server
-- npm install -g vim-language-server

return {
  cmd = { "vim-language-server", "--stdio" },
  single_file_support = true,
  filetypes = { "vim" },
  root_markers = { ".git" },
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
}
