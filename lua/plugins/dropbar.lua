local is_available = function()
  return vim.fn.has("nvim-0.11.0") == 1
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
  event = { "TurboLoad" },
  cond = is_available(),
  opts = {
    bar = {
      enable = function(buf, win, _)
        buf = vim._resolve_bufnr(buf)
        if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_win_is_valid(win) then
          return false
        end

        if
          not vim.api.nvim_buf_is_valid(buf)
          or not vim.api.nvim_win_is_valid(win)
          or vim.fn.win_gettype(win) ~= ""
          or vim.wo[win].winbar ~= ""
          or vim.bo[buf].ft == "help"
          or vim.bo[buf].ft == "neo-tree"
        then
          return false
        end

        local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf))
        if stat and stat.size > 1024 * 1024 then
          return false
        end

        return vim.bo[buf].bt == "terminal"
          or vim.bo[buf].ft == "markdown"
          or pcall(vim.treesitter.get_parser, buf)
          or not vim.tbl_isempty(vim.lsp.get_clients({
            bufnr = buf,
            method = "textDocument/documentSymbol",
          }))
      end,
    },
  },
  config = function(_, opts)
    require("dropbar").setup(opts)
    remove_dropba_color()
  end,
}
