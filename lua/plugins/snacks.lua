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
          section = "header",
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
    indent = {
      indent = {
        char = "▏",
      },
      scope = {
        char = "▏",
      },
    },
    input = {
      win = { style = { relative = "cursor" } },
    },
    scroll = {},
    styles = {
      notification = {
        wo = { wrap = true } -- Wrap notifications
      }
    },
    picker = {
      layout = {
        fullscreen = true,
      },
    },
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
    -- find
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    -- git
    { "<leader>gc", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    -- Grep
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    -- search
    { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
    { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
    { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
    { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
    { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    { "<leader>qp", function() Snacks.picker.projects() end, desc = "Projects" },
    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
  },
}
