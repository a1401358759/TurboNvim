-- https://github.com/zbirenbaum/neodim

return {
  "zbirenbaum/neodim",
  event = "LspAttach",
  branch = "v2",
  config = function()
    require("neodim").setup({
      refresh_delay = 75, -- time in ms to wait after typing before refresh diagnostics
      alpha = 0.75,
      blend_color = "#000000",
      hide = { underline = true, virtual_text = true, signs = true },
      priority = 100, -- priority of dim highlights (increasing may interfere with semantic tokens!!)
      disable = {}, -- table of filetypes to disable neodim
    })
  end,
}
