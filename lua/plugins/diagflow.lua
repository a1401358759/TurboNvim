return {
  "dgagn/diagflow.nvim",
  event = "LspAttach",
  config = function()
    require("diagflow").setup({
      enable = true,
      max_width = 60, -- The maximum width of the diagnostic messages
      max_height = 10, -- the maximum height per diagnostics
      format = function(diagnostic)
        return diagnostic.message
      end,
      gap_size = 1,
      scope = "line", -- 'cursor', 'line' this changes the scope, so instead of showing errors under the cursor, it shows errors on the entire line.
      padding_top = 0,
      padding_right = 5,
      text_align = "left", -- 'left', 'right'
      placement = "top", -- 'top', 'inline'
      inline_padding_left = 3, -- the padding left when the placement is inline
      show_sign = true, -- set to true if you want to render the diagnostic sign before the diagnostic message
      update_event = { "DiagnosticChanged", "BufReadPost" }, -- the event that updates the diagnostics cache
      toggle_event = { "InsertEnter" }, -- if InsertEnter, can toggle the diagnostics on inserts
      render_event = { "DiagnosticChanged", "CursorMoved" },
    })
  end,
}
