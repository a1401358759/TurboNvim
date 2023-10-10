-- need install glow
-- sudo pacman -S glow

return {
  "ellisonleao/glow.nvim",
  cmd = "Glow",
  config = function()
    vim.g.glow_border = "rounded"
    --vim.g.glow_width = 120
    --vim.g.glow_use_pager = true
    vim.g.glow_width = vim.fn.winwidth(0)
    if vim.g.style == "light" then
      vim.g.glow_style = "light"
    else
      vim.g.glow_style = "dark"
    end
    require("glow").setup({
      glow_binary_path = "~/.local/bin",
    })
  end,
  keys = {
    { "<leader>mp", ":Glow<cr>:resize +1000<cr>:vertical resize +1000<cr>", desc = "Markdown Preview" },
  },
}
