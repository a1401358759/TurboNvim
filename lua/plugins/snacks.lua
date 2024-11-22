---@diagnostic disable: undefined-global
-- stylua: ignore
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    terminal = {
      enabled = true,
      win = {
        position = "float",
        title = "",
        title_pos = "center",
        border = "rounded",
        backdrop = 100,
        width = 0.9,
        height = 0.9,
      }
    },
    dashboard = {
      enabled = true,
      width = 72,
      sections = {
        {
          section = "terminal",
          align = "center",
          cmd = "cat ~/.config/nvim/static/neovim.cat",
          -- indent = -6,
          height = 11,
          width = 72,
          padding = 1,
        },
        {
          section = "keys",
          indent = 1,
          padding = 1,
        },
        { section = "recent_files", icon = " ", title = "Recent Files", indent = 3, padding = 1 },
        { section = "projects", icon = " ", title = "Projects", indent = 3, padding = 1 },
        { section = "startup" },
      },
    },
    styles = {
      notification = {
        wo = { wrap = true } -- Wrap notifications
      }
    }
  },
  keys = {
    { "<c-q>", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    {
      "<leader>tt",
      function() Snacks.terminal() end,
      desc = "Toggle horizontal terminal",
    },
    { "<leader>tg", function() Snacks.terminal("lazygit", { cwd = vim.uv.cwd(), win = {border = "rounded"} }) end, desc = "Lazygit" },
    { "<leader>td", function() Snacks.terminal("lazydocker", { cwd = vim.uv.cwd(), win = {border = "rounded"} }) end, desc = "Lazydocker" },
    { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
    { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
    { "<leader>gL", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
    { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
    { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
  },
}
