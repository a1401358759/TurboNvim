-- 调试。

return {
  {
    name = "glance",
    "https://github.com/dnlhc/glance.nvim",
    cmd = "Glance",
    keys = {
      { "gpd", "Glance definitions", desc = "Glance definitions" },
      { "gpr", "Glance references", desc = "Glance references" },
      { "gpt", "Glance type_definitions", desc = "Glance type_definitions" },
      { "gpi", "Glance implementations", desc = "Glance implementations" },
    },
    config = function()
      local glance = require("glance")
      -- GlanceOpts marks every option required. Only overrides belong here;
      -- the mappings block was identical to the plugin defaults.
      ---@diagnostic disable-next-line: missing-fields
      glance.setup({
        -- The annotation types this field as a function. Runtime also accepts true.
        detached = function()
          return true
        end,
        border = {
          enable = true,
          top_char = "─",
          bottom_char = "─",
        },
      })
    end,
  },
}
