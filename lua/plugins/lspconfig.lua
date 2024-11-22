local diag_icons = require("config.icons").icons.diagnostics

return {
  "neovim/nvim-lspconfig",
  event = { "VeryLazy", "TurboLoad" },
  dependencies = {
    "mason.nvim",
    { "williamboman/mason-lspconfig.nvim", config = function() end },
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
      exclude = { "go", "lua" }, -- filetypes for which you don't want to enable inlay hints
    },
    codelens = {
      enabled = false,
    },
    -- Enable lsp cursor word highlighting
    document_highlight = {
      enabled = true,
    },
    format = {
      formatting_options = nil,
      timeout_ms = nil,
    },
  },
  config = function(_, opts)
    require("lspconfig.ui.windows").default_options.border = "rounded"
    -- add init
    local on_init = function(client, _)
      if client.supports_method("textDocument/semanticTokens") then
        client.server_capabilities.semanticTokensProvider = nil
      end
    end
    -- add capabilities
    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and cmp_nvim_lsp.default_capabilities({}) or {},
      opts.capabilities or {}
    )
    -- add on_attach
    local on_attach = function(client, bufnr)
      if client.name == "ruff" or client.name == "ruff_lsp" then
        -- Disable hover in favor of Pyright
        client.server_capabilities.hoverProvider = false
      end
      if opts.codelens.enabled then
        if client.supports_method("textDocument/codeLens") then
          vim.lsp.codelens.refresh()
          vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            buffer = bufnr,
            callback = vim.lsp.codelens.refresh,
          })
        end
      end
      if opts.inlay_hints.enabled then
        if
          vim.api.nvim_buf_is_valid(bufnr)
          and vim.bo[bufnr].buftype == ""
          and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[bufnr].filetype)
        then
          if client.supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
        end
      end
    end
    -- setup lspservers
    local mason_lspconfig = require("mason-lspconfig")
    for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
      local require_path = string.format("%s%s", "lspservers/", server_name)
      local ok, settings = pcall(require, require_path)
      if not ok then
        settings = {}
      end
      if settings.enabled == false then
        goto continue
      end
      settings.on_attach = on_attach
      settings.capabilities = capabilities
      if server_name == "lua_ls" then
        settings.on_init = on_init
      end
      require("lspconfig")[server_name].setup(settings)
      ::continue::
    end

    -- diagnostics for neovim < 0.10.0
    if vim.fn.has("nvim-0.10.0") == 0 then
      for name, icon in pairs(diag_icons) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
    end
    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    -- regiseter lsp keymaps
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
        vim.keymap.set("n", "gk", function()
          return vim.lsp.buf.signature_help()
        end, { desc = "Signature Help" })
        vim.keymap.set("i", "<c-k>", function()
          return vim.lsp.buf.signature_help()
        end, { desc = "Signature Help" })
        vim.keymap.set("n", "K", function()
          return vim.lsp.buf.hover()
        end, { desc = "Hover" })
        vim.keymap.set("n", "gy", function()
          require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
        end, { desc = "Goto T[y]pe Definition" })
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
      end,
    })
  end,
}
