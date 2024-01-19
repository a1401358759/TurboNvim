-- Create code snippets in Neovim using ray.so
return {
  "TobinPalmer/rayso.nvim",
  lazy = true,
  cmd = "Rayso",
  config = function()
    require("rayso").setup({
      base_url = "https://ray.so/", -- Default URL
      open_cmd = "microsoft-edge-stable",
      options = {
        background = true, -- If the screenshot should have a background.
        dark_mode = true, -- If the screenshot should be in dark mode.
        logging_path = "", -- Path to create a log file in.
        logging_file = "rayso", -- Name of log file, will be a markdown file, ex rayso.md.
        logging_enabled = false, -- If you enable the logging file.
        padding = 16, -- The default padding that the screenshot will have.
        theme = "candy", -- Theme
        title = "Untitled", -- Default title
      },
    })
    vim.keymap.set("v", "<leader>rs", require("lib.create").create_snippet)
  end,
}
