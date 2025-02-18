return {
  "williamboman/mason.nvim",
  event = "TurboLoad",
  cmd = "Mason",
  keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  build = ":MasonUpdate",
  opts_extend = { "ensure_installed" },
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
      "java-debug-adapter",
      "java-test",

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
      upgrade_pip = true,
    },
    ui = {
      border = "rounded",
      width = 0.8,
      height = 0.8,
      icons = {
        package_installed = "",
        package_pending = "",
        package_uninstalled = "",
      },
    },
  },
  config = function(_, opts)
    require("mason").setup(opts)
    local mr = require("mason-registry")
    mr:on("package:install:success", function()
      vim.defer_fn(function()
        -- trigger FileType event to possibly load this newly installed LSP server
        require("lazy.core.handler.event").trigger({
          event = "FileType",
          buf = vim.api.nvim_get_current_buf(),
        })
      end, 100)
    end)

    mr.refresh(function()
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end)
  end,
}
