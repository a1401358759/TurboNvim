return {
  "linux-cultist/venv-selector.nvim",
  lazy = true,
  ft = "python",
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
  opts = {
    notify_user_on_activate = true,
  },
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Virtualenv" },
    { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Select Virtualenv (cached)" },
  },
  config = function(_, opts)
    require("venv-selector").setup(opts)

    -- Auto select virtualenv Nvim open
    vim.api.nvim_create_autocmd({ "FileType" }, {
      desc = "Auto select virtualenv Nvim open",
      pattern = "python",
      callback = function()
        local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
        if venv ~= "" then
          require("venv-selector").retrieve_from_cache()
        end
      end,
      once = true,
    })
  end,
}
