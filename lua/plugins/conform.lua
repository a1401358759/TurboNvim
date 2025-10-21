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
        javascript = { "biome" },
        typescript = { "biome" },
        javascriptreact = { "biome" },
        typescriptreact = { "biome" },
        css = { "prettier", "prettierd" },
        html = { "prettier", "prettierd" },
        json = { "jq", "fixjson" },
        yaml = { "prettier", "prettierd" },
        markdown = { "prettierd", "prettier", "markdownlint", "markdown-toc" },
        graphql = { "prettier", "prettierd" },
        python = function(bufnr)
          if require("conform").get_formatter_info("ruff_format", bufnr).available then
            return { "ruff_fix", "ruff_organize_imports", "ruff_format" }
          else
            return { "isort", "black" }
          end
        end,
        go = { "golangcilint" },
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
        black = { prepend_args = { "--line-length", "150", "--fast" } },
        ruff_format = {
          args = {
            "format",
            "--config",
            vim.fn.stdpath("config") .. "/pyproject.toml",
            "--force-exclude",
            "--stdin-filename",
            "$FILENAME",
            "-",
          },
        },
        ruff_fix = { append_args = { "--config", vim.fn.stdpath("config") .. "/pyproject.toml" } },
      },
    })
  end,
}
