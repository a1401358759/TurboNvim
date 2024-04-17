local diag_icons = require("config.icons").icons.diagnostics

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  dependencies = {
    { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
    { "folke/neodev.nvim", opts = {} },
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  opts = {
    diagnostics = {
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      virtual_text = false,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = diag_icons.Error,
          [vim.diagnostic.severity.WARN] = diag_icons.Warn,
          [vim.diagnostic.severity.INFO] = diag_icons.Info,
          [vim.diagnostic.severity.HINT] = diag_icons.Hint,
        }, -- neovim/neovim#26193 (0.10.0+)
      },
    },
    inlay_hints = {
      enabled = true,
    },
    codelens = {
      enabled = false,
    },
    format = {
      formatting_options = nil,
      timeout_ms = nil,
    },
    setup = {
      ruff_lsp = function(client, _)
        if client.name == "ruff_lsp" then
          -- Disable hover in favor of Pyright
          client.server_capabilities.hoverProvider = false
        end
      end,
    },
  },
  config = function(_, opts)
    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and cmp_nvim_lsp.default_capabilities({}) or {},
      opts.capabilities or {}
    )
    local mason_lspconfig = require("mason-lspconfig")
    for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
      local require_path = string.format("%s%s", "lspservers/", server_name)
      local ok, settings = pcall(require, require_path)
      if not ok then
        settings = {}
      end

      settings.on_attach = function(client, buffer)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.semanticTokensProvider = nil
        if opts.codelens.enabled then
          if client.supports_method("textDocument/codeLens") then
            vim.lsp.codelens.refresh()
            --- autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
              buffer = buffer,
              callback = vim.lsp.codelens.refresh,
            })
          end
        end
        if opts.inlay_hints.enabled then
          if client.supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(buffer, true)
          end
        end
      end
      settings.capabilities = capabilities
      settings.capabilities.textDocument.completion.completionItem = {
        documentationFormat = { "markdown", "plaintext" },
        snippetSupport = true,
        preselectSupport = true,
        insertReplaceSupport = true,
        labelDetailsSupport = true,
        deprecatedSupport = true,
        commitCharactersSupport = true,
        tagSupport = { valueSet = { 1 } },
        resolveSupport = {
          properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
          },
        },
      }
      if settings.enabled ~= false then
        require("lspconfig")[server_name].setup(settings)
      end
    end

    -- diagnostics
    if vim.fn.has("nvim-0.10.0") == 0 then
      for name, icon in pairs(diag_icons) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
    end
    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
        vim.keymap.set("n", "gd", function()
          require("telescope.builtin").lsp_definitions({ reuse_win = true })
        end, { desc = "Goto Definition" })
        vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
        vim.keymap.set("n", "gI", function()
          require("telescope.builtin").lsp_implementations({ reuse_win = true })
        end, { desc = "Goto Implementation" })
        vim.keymap.set("n", "gk", vim.lsp.buf.signature_help, { desc = "Signature Help" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
        vim.keymap.set("n", "gy", function()
          require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
        end, { desc = "Goto T[y]pe Definition" })
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
      end,
    })
  end,
}
