local M = {}

M.lazy_file_events = { "BufReadPost", "BufNewFile", "BufWritePre" }

function M.setup()
  M.lazy_file()
end

function M.lazy_file()
  -- Add support for the TurboLoad event
  local Event = require("lazy.core.handler.event")

  Event.mappings.TurboLoad = { id = "TurboLoad", event = M.lazy_file_events }
  Event.mappings["User TurboLoad"] = Event.mappings.TurboLoad
end

return M
