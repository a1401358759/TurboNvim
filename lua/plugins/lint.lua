return {
  "mfussenegger/nvim-lint",
  lazy = true,
  event = "TurboLoad",
  config = function()
    local options = require("config.options")
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
    ruff.args = options.ruff_args
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
