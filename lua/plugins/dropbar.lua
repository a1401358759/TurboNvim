local judge_version = function()
  if vim.fn.has("nvim-0.10.0") == 1 then
    return true
  else
    return false
  end
end

return {
  "Bekaboo/dropbar.nvim",
  lazy = true,
  event = { "UIEnter" },
  enabled = judge_version(),
  config = function()
    require("dropbar").setup({})
  end,
}
