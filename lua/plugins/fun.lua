return {
  {
    "Eandrju/cellular-automaton.nvim",
    lazy = true,
    keys = "<leader>rr",
    config = function()
      vim.keymap.set("n", "<leader>rr", "<cmd>CellularAutomaton make_it_rain<CR>")
    end,
  },
  {
    "tamton-aquib/duck.nvim",
    event = { "UIEnter" },
    config = function()
      vim.keymap.set("n", "<leader>dd", function()
        require("duck").hatch()
      end, { desc = "Duck Hatch" })
      vim.keymap.set("n", "<leader>dk", function()
        require("duck").cook()
      end, { desc = "Duck Cook" })
    end,
  },
}
