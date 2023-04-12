return {
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason.nvim" },
  opts = function()
    local nls = require("null-ls")
    table.insert(nls.builtins.formatting.shfmt.filetypes, "zsh")
    return {
      sources = {
        -- nls.builtins.formatting.prettierd,
        nls.builtins.diagnostics.flake8,
        nls.builtins.formatting.gofmt,
        nls.builtins.formatting.shfmt,
        nls.builtins.formatting.prettier,
        nls.builtins.formatting.isort.with({
          extra_args = {
            "--line-length=120",
          },
        }),
        nls.builtins.formatting.black.with({
          extra_args = {
            "--line-length=120",
          },
        }),
        nls.builtins.formatting.sql_formatter,
        nls.builtins.formatting.stylua.with({
          extra_args = {
            "--indent-type=Spaces",
            "--indent-width=2",
          },
        }),
      },
    }
  end,
}
