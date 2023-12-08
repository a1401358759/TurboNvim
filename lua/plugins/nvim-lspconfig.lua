return {
  "neovim/nvim-lspconfig",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
    { "folke/neodev.nvim", opts = {} },
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    version = false, -- last release is way too old
  },
  opts = function()
    local mason_lspconfig = require("mason-lspconfig")
    local lsp_servers = {}
    for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
      local require_path = string.format("%s%s", "server_configs/", server_name)
      local ok, settings = pcall(require, require_path)
      if not ok then
        settings = {}
      end

      settings.on_attach = function(client, _)
        client.server_capabilities.documentFormattingProvider = false
        -- close semantic tokens
        client.server_capabilities.semanticTokensProvider = nil
      end
      settings.mason = true
      lsp_servers[server_name] = settings
    end
    lsp_servers.tailwindcss = { filetypes_exclude = { "markdown" } }
    lsp_servers.dockerls = {}
    lsp_servers.docker_compose_language_service = {}

    return {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      },
      inlay_hints = {
        enabled = false,
      },
      -- add any global capabilities here
      capabilities = {},
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      servers = lsp_servers,
      setup = {
        ruff_lsp = function()
          require("lazyvim.util").lsp.on_attach(function(client, _)
            if client.name == "ruff_lsp" then
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
      },
    }
  end,
}
