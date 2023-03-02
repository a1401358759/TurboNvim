vim.g.VM_Extend_hl = "VM_Extend_hl"
vim.g.VM_Cursor_hl = "VM_Cursor_hl"
vim.g.VM_Mono_hl = "VM_Mono_hl"
vim.g.VM_Insert_hl = "VM_Insert_hl"

vim.g.VM_default_mappings = 0

vim.g.VM_maps = {
  ["Find Under"] = "<c-n>",
  ["Find Prev"] = "<c-p>",
  ["Skip Region"] = "<c-s>",
  ["Remove Region"] = "<c-d>",
}

return {
  "mg979/vim-visual-multi",
  lazy = true,
  event = "VeryLazy",
}
