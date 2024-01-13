local judge_version = function()
  if vim.fn.has("nvim-0.10.0") == 1 then
    return true
  else
    return false
  end
end

local remove_dropba_color = function()
  -- 防止 dropbar 显示 cmp 的背景颜色
  local dropbar_groups = {
    "DropBarIconKindVariable",
    "DropBarIconKindClass",
    "DropBarIconKindConstructor",
    "DropBarIconKindDeclaration",
    "DropBarIconKindEnum",
    "DropBarIconKindEnumMember",
    "DropBarIconKindEvent",
    "DropBarIconKindField",
    "DropBarIconKindIdentifier",
    "DropBarIconKindInterface",
    "DropBarIconKindMethod",
    "DropBarIconKindModule",
    "DropBarIconKindPackage",
    "DropBarIconKindProperty",
    "DropBarIconKindReference",
    "DropBarIconKindStruct",
    "DropBarIconKindTypeParameter",
    "DropBarIconKindType",
    "DropBarIconKindUnit",
    "DropBarKindVariable",
    "DropBarKindIdentifier",
  }
  for _, v in pairs(dropbar_groups) do
    vim.api.nvim_set_hl(0, v, { link = "" })
  end
  vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE" })
end

return {
  "Bekaboo/dropbar.nvim",
  lazy = true,
  event = { "UIEnter" },
  cond = judge_version(),
  config = function()
    require("dropbar").setup({})
    remove_dropba_color()
  end,
}
