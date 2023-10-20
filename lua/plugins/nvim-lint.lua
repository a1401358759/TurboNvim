return {
  "mfussenegger/nvim-lint",
  event = "LazyFile",
  opts = {
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      fish = { "fish" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "flake8" },
      markdown = { "markdownlint" },
      dockerfile = { "hadolint" },
    },
    -- LazyVim extension to easily override linter options
    -- or add custom linters.
    linters = {
      flake8 = {
        cmd = "flake8",
        stdin = true,
        args = {
          "--format=%(path)s:%(row)d:%(col)d:%(code)s:%(text)s",
          "--no-show-source",
          "--max-line-length",
          "120",
          "--extend-ignore",
          "E121,E123,E126,E226,E24,E501,E704,W503,W504",
          "-",
        },
        ignore_exitcode = true,
      },
      -- -- Example of using selene only when a selene.toml file is present
      -- selene = {
      --   -- `condition` is another LazyVim extension that allows you to
      --   -- dynamically enable/disable linters based on the context.
      --   condition = function(ctx)
      --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
      --   end,
      -- },
    },
  },
}
