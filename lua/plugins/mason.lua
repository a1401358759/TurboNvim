return {
  "williamboman/mason.nvim",
  event = "TurboLoad",
  cmd = "Mason",
  opts = {
    ensure_installed = {
      -- python
      "basedpyright",
      "pyright",
      "ruff",
      "isort",
      "black",

      -- go
      "impl",
      "gopls",
      "gofumpt",
      "gomodifytags",
      "goimports-reviser",

      -- java
      "jdtls",

      -- frontend
      "html-lsp",
      "css-lsp",
      "emmet-ls",
      "vetur-vls",
      "tailwindcss-language-server",
      "eslint_d",
      "vtsls",
      "prettier",
      "prettierd",

      -- lua
      "lua-language-server",
      "stylua",

      -- shell & bash
      "bash-language-server",
      "shfmt",
      "shellcheck",

      -- sql
      "sql-formatter",

      -- vim
      "vim-language-server",

      -- json
      "json-lsp",
      "fixjson",

      -- dap
      "delve",
      "debugpy",

      -- docker
      "dockerfile-language-server",
      "docker-compose-language-service",

      -- markdown
      "markdownlint",
      "markdown-toc",
      "marksman",
      "hadolint",
    },
    max_concurrent_installers = 20,
    pip = {
      -- Whether to upgrade pip to the latest version in the virtual environment before installing packages.
      upgrade_pip = true,
    },
    ui = {
      border = "rounded",
      -- Width of the window. Accepts:
      -- - Integer greater than 1 for fixed width.
      -- - Float in the range of 0-1 for a percentage of screen width.
      width = 0.8,
      -- Height of the window. Accepts:
      -- - Integer greater than 1 for fixed height.
      -- - Float in the range of 0-1 for a percentage of screen height.
      height = 0.8,
      icons = {
        package_installed = "",
        package_pending = "",
        package_uninstalled = "",
      },
    },
  },
  ---@diagnostic disable-next-line: unused-local
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
