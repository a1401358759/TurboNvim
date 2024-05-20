return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "VeryLazy" },
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  opts = {
    auto_install = true,
    autotag = { enable = true },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      disable = function(_, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
    indent = { enable = true },
    -- incremental selection
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-cr>",
        node_incremental = "<C-cr>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    textobjects = { enable = true },
    ensure_installed = {
      "bash",
      "blueprint",
      "c",
      "cmake",
      "comment",
      "cpp",
      "css",
      "cuda",
      "dockerfile",
      "dot",
      "fish",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
      "go",
      "gomod",
      "gowork",
      "gosum",
      "hjson",
      "html",
      "http",
      "java",
      "javascript",
      "jsdoc",
      "json",
      "json5",
      "jsonc",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "ninja",
      "python",
      "rust",
      "scss",
      "sql",
      "toml",
      "typescript",
      "vim",
      "vue",
      "yaml",
      "regex",
      "xml",
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
  keys = {
    { "<c-cr>", desc = "Increment selection" },
    { "<bs>", desc = "Schrink selection", mode = "x" },
  },
}
