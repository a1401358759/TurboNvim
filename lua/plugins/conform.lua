return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  lazy = true,
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cF",
      function()
        require("conform").format({ formatters = { "injected" } })
      end,
      mode = { "n", "v" },
      desc = "Format Injected Langs",
    },
  },
  opts = function()
    return {
      -- LazyVim will use these options when formatting with the conform.nvim formatter
      format = {
        timeout_ms = 1000,
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
        json = { { "prettier", "prettierd" } },
        yaml = { { "prettier", "prettierd" } },
        markdown = { { "prettier", "prettierd" } },
        graphql = { { "prettier", "prettierd" } },
        python = { "isort", "black" },
        go = { "goimports", "gofumpt" },
      },
      -- LazyVim will merge the options you set here with builtin formatters.
      -- You can also define any custom formatters here.
      formatters = {
        injected = { options = { ignore_errors = true } },
        black = { extra_args = { "--max-line-length", "120" } },
        isort = { extra_args = { "--max-line-length", "120" } },
      },
    }
  end,
}
