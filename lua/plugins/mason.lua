return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  opts = {
    ensure_installed = {
      -- lsp
      "gopls",
      -- "pyright",
      "css-lsp",
      "json-lsp",
      "html-lsp",
      "emmet-ls",
      "vetur-vls",
      "vim-language-server",
      "lua-language-server",
      "bash-language-server",
      "typescript-language-server",
      "tailwindcss-language-server",
      "python-lsp-server",

      -- dap
      "delve",
      "debugpy",

      -- linter
      -- "pylint",
      -- "mypy",
      "flake8",

      -- formatter
      "shfmt",
      "isort",
      "black",
      "prettier",
      "sql-formatter",
      "stylua",
      "shellcheck",
    },
    max_concurrent_installers = 20,
    ui = {
      border = "rounded" or "none",
      icons = {
        package_installed = "",
        package_pending = "",
        package_uninstalled = "",
      },
    },
  },
  ---@param opts MasonSettings | {ensure_installed: string[]}
  config = function(plugin, opts)
    require("mason").setup(opts)
    local mr = require("mason-registry")
    for _, tool in ipairs(opts.ensure_installed) do
      local p = mr.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end
  end,
}
