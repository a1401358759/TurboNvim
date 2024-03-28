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
      python = { "ruff" },
      markdown = { "markdownlint" },
      dockerfile = { "hadolint" },
    }
    local ruff = require("lint").linters.ruff
    ruff.args = {
      "--preview",
      "--line-length=120",
      "--extend-select=E,N,W,ARG,RUF",
      "--ignore=E402,E501,N802,N803,N806,N801,N813,RUF001,RUF002,RUF003,RUF012",
    }
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
