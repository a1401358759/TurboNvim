return {
  "mfussenegger/nvim-lint",
  lazy = false,
  event = "VeryLazy",
  config = function()
    require("lint").linters_by_ft = {
      fish = { "fish" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "flake8" },
      markdown = { "markdownlint" },
      dockerfile = { "hadolint" },
    }
    local flake8 = require("lint").linters.flake8
    flake8.args = {
      "--format=function%(path)s:%(row)d:%(col)d:%(code)s:%(text)s",
      "--no-show-source",
      "--max-line-length",
      "120",
      "--extend-ignore",
      "E121,E123,E126,E226,E24,E501,E704,W503,W504",
      "-",
    }
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
