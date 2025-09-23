return {
  "nvim-treesitter/nvim-treesitter",
  lazy = vim.fn.argc(-1) == 0,
  branch = "main",
  build = ":TSUpdate",
  event = { "TurboLoad", "VeryLazy" },
  cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
  opts = {
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
    local nvim_treesitter = require("nvim-treesitter")
    nvim_treesitter.setup()

    local pattern = {}
    for _, parser in ipairs(opts.ensure_installed) do
      local has_parser, _ = pcall(vim.treesitter.language.inspect, parser)

      if not has_parser then
        -- 需要通过系统的包管理器安装 tree-sitter-cli
        nvim_treesitter.install(parser)
      else
        vim.list_extend(pattern, vim.treesitter.language.get_filetypes(parser))
      end
    end

    local group = vim.api.nvim_create_augroup("NvimTreesitterFt", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = pattern,
      callback = function(ev)
        local max_filesize = 100 * 1024
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
        if not (ok and stats and stats.size > max_filesize) then
          vim.treesitter.start()
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    -- In markdown files, the rendered output would only display the correct highlight if the code is set to scheme
    -- However, this would result in incorrect highlight in neovim
    -- Therefore, the scheme language should be linked to query
    vim.treesitter.language.register("query", "scheme")

    vim.api.nvim_exec_autocmds("FileType", { group = "NvimTreesitterFt" })
  end,
}
