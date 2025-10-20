-- mason.nvim 负责安装除 lsp server 之外的其他工具
-- mason-lspconfig 负责安装 lsp server

return {
  "mason-org/mason.nvim",
  event = "TurboLoad",
  cmd = "Mason",
  keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  build = ":MasonUpdate",
  opts = {
    ensure_installed = {
      -- python
      "ruff",
      "isort",
      "black",
      -- go
      "impl",
      "gofumpt",
      "gomodifytags",
      "goimports-reviser",
      -- frontend
      "biome",
      -- lua
      "stylua",
      -- shell & bash
      "shfmt",
      "shellcheck",
      -- sql
      "sql-formatter",
      -- json
      "fixjson",
      -- dap
      "delve",
      "debugpy",
      -- dockerfile
      "hadolint",
      -- markdown
      "markdownlint",
      "markdown-toc",
      "marksman",
    },
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
    require("mason-lspconfig").setup({
      automatic_enable = false,
      ensure_installed = {
        -- python
        "pyright",
        -- go
        "gopls",
        -- frontend
        "html",
        "cssls",
        "emmet_ls",
        "vue_ls",
        "vtsls",
        "tailwindcss",
        -- lua
        "lua_ls",
        -- shell & bash
        "bashls",
        -- vim
        "vimls",
        -- json
        "jsonls",
        -- docker
        "dockerls",
        "docker_compose_language_service",
        -- yamal
        "yamlls",
        -- latex
        "ltex_plus",
      },
    })
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
