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
        timeout_ms = 3000,
        async = false,
        quiet = false,
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
      -- LazyVim will merge the options you set here with builtin formatters.
      -- You can also define any custom formatters here.
      formatters = {
        injected = { options = { ignore_errors = true } },
        black = { prepend_args = { "--line-length", "88", "--fast" } },
        -- # Example of using shfmt with extra args
        -- shfmt = {
        --   extra_args = { "-i", "2", "-ci" },
        -- },
      },
    }
  end,
}
