return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  opts = {
    ensure_installed = {
      -- lsp
      "pyright",
      "ruff-lsp",
      -- "python-lsp-server",
      "gopls",
      "impl",
      "gofumpt",
      "gomodifytags",
      "goimports-reviser",
      "css-lsp",
      "cssmodules-language-server",
      "json-lsp",
      "html-lsp",
      "emmet-ls",
      "vetur-vls",
      "vim-language-server",
      "lua-language-server",
      "bash-language-server",
      "typescript-language-server",
      "tailwindcss-language-server",
      "dockerfile-language-server",
      "docker-compose-language-service",
      "hadolint",

      -- dap
      "delve",
      "debugpy",

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
  ---@param opts MasonSettings | {ensure_installed: string[]}
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
