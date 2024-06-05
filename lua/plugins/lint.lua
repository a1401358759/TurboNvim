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
      dockerfile = { "hadolint" },
    }

    -- ruff
    local ruff = require("lint").linters.ruff
    ruff.args = options.ruff_args

    -- eslint_d
    local eslint_d = require("lint").linters.eslint_d
    eslint_d.args = {
      "--no-warn-ignored", -- <-- this is the key argument
      "--format",
      "json",
      "--stdin",
      "--stdin-filename",
      function()
        return vim.api.nvim_buf_get_name(0)
      end,
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
