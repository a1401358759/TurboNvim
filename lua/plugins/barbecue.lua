return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  lazy = true,
  event = "VeryLazy",
  opts = {
    ---whether to show/use navic in the winbar
    ---@type boolean
    show_navic = true,
    ---whether to attach navic to language servers automatically
    ---@type boolean
    attach_navic = true,
    ---whether to create winbar updater autocmd
    ---@type boolean
    create_autocmd = true,
    ---buftypes to enable winbar in
    ---@type string[]
    include_buftypes = { "" },
    ---filetypes not to enable winbar in
    ---@type string[]
    exclude_filetypes = { "gitcommit", "toggleterm" },
    modifiers = {
      ---filename modifiers applied to dirname
      ---@type string
      dirname = ":~:.",
      ---filename modifiers applied to basename
      ---@type string
      basename = "",
    },
    ---returns a string to be shown at the end of winbar
    ---@type fun(bufnr: number): string
    custom_section = function()
      return ""
    end,
    ---`auto` uses your current colorscheme's theme or generates a theme based on it
    ---`string` is the theme name to be used (theme should be located under `barbecue.theme` module)
    ---`barbecue.Theme` is a table that overrides the `auto` theme detection/generation
    ---@type "auto"|string|barbecue.Theme
    theme = "auto",
    ---whether to display path to file
    ---@type boolean
    show_dirname = true,
    ---whether to replace file icon with the modified symbol when buffer is modified
    ---@type boolean
    show_modified = false,
    symbols = {
      ---modification indicator
      ---@type string
      modified = "●",
      ---truncation indicator
      ---@type string
      ellipsis = "…",
      ---entry separator
      ---@type string
      separator = ">",
    },
    ---icons for different context entry kinds
    ---`false` to disable kind icons
    ---@type table<string, string>|false
    kinds = {
      File = "",
      Module = "",
      Namespace = "",
      Package = "",
      Class = "",
      Method = "",
      Property = "",
      Field = "",
      Constructor = "",
      Enum = "",
      Interface = "",
      Function = "",
      Variable = "",
      Constant = "",
      String = "",
      Number = "",
      Boolean = "",
      Array = "",
      Object = "",
      Key = "",
      Null = "",
      EnumMember = "",
      Struct = "",
      Event = "",
      Operator = "",
      TypeParameter = "",
    },
  },
}
