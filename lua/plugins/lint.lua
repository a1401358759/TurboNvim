return {
  "mfussenegger/nvim-lint",
  lazy = true,
  event = "TurboLoad",
  config = function()
    local options = require("config.options")
    require("lint").linters_by_ft = {
      fish = { "fish" },
      javascript = { "biomejs" },
      typescript = { "biomejs" },
      javascriptreact = { "biomejs" },
      typescriptreact = { "biomejs" },
      python = { "ruff" },
      dockerfile = { "hadolint" },
      go = { "golangcilint" },
    }

    -- ruff
    local ruff = require("lint").linters.ruff
    ruff.args = options.ruff_args

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
