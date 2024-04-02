return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  lazy = true,
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cF",
      function()
        require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
      end,
      mode = { "n", "v" },
      desc = "Format Injected Langs",
    },
  },
  config = function()
    require("conform").setup({
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if not vim.g.autoformat and not vim.b[bufnr].autoformat then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
      format = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
        lsp_fallback = true, -- not recommended to change
      },
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
        javascript = { { "prettierd", "prettier" } },
        typescript = { { "prettier", "prettierd" } },
        javascriptreact = { { "prettier", "prettierd" } },
        typescriptreact = { { "prettier", "prettierd" } },
        svelte = { { "prettier", "prettierd" } },
        css = { { "prettier", "prettierd" } },
        html = { { "prettier", "prettierd" } },
        json = { { "jq", "fixjson", "prettier", "prettierd" } },
        yaml = { { "prettier", "prettierd" } },
        markdown = { { "prettier", "prettierd" } },
        graphql = { { "prettier", "prettierd" } },
        python = function(bufnr)
          if require("conform").get_formatter_info("ruff_format", bufnr).available then
            -- return { "ruff_format" }
            return { "isort", "black" }
          else
            return { "isort", "black" }
          end
        end,
        go = { "goimports-reviser", "gofumpt" },
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
        black = { prepend_args = { "--line-length", "120", "--fast" } },
        -- # Example of using shfmt with extra args
        -- shfmt = {
        --   extra_args = { "-i", "2", "-ci" },
        -- },
      },
    })
  end,
}
