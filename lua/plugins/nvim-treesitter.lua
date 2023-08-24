---@diagnostic disable: missing-fields
return {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- last release is way too old and doesn't work on Windows
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      init = function()
        -- PERF: no need to load the plugin, if we only need its queries for mini.ai
        local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
        local opts = require("lazy.core.plugin").values(plugin, "opts", false)
        local enabled = false
        if opts.textobjects then
          for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
            if opts.textobjects[mod] and opts.textobjects[mod].enable then
              enabled = true
              break
            end
          end
        end
        if not enabled then
          require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
        end
      end,
    },
  },
  keys = {
    { "<c-space>", desc = "Increment selection" },
    { "<bs>", desc = "Schrink selection", mode = "x" },
  },
  ---@type TSConfig
  opts = {
    highlight = {
      enable = true,
      disable = function(_, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true, disable = { "python" } },
    context_commentstring = { enable = true, enable_autocmd = false },
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
    },
    -- incremental selection
    incremental_selection = {
      enable = false,
      keymaps = {
        init_selection = "<cr>",
        node_incremental = "<cr>",
        node_decremental = "<bs>",
        scope_incremental = "<tab>",
      },
    },
    -- nvim-ts-rainbow
    rainbow = {
      enable = true,
      extended_mode = true,
      -- Do not enable for files with more than 1000 lines, int
      max_file_lines = 1000,
    },
    -- nvim-ts-autotag
    autotag = {
      enable = true,
    },
  },
  ---@param opts TSConfig
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
