-- return {
--   "mfussenegger/nvim-dap",
--   lazy = true,
--   dependencies = {
--     "rcarriga/nvim-dap-ui",
--     "theHamsta/nvim-dap-virtual-text",
--     "nvim-telescope/telescope-dap.nvim",
--     "mfussenegger/nvim-dap-python",
--   },
--   config = function()
--     local dap, dapui = require("dap"), require("dapui")
--     require("nvim-dap-virtual-text").setup({})
--     dapui.setup()
--
--     dap.listeners.after.event_initialized["dapui_config"] = function()
--       dapui.open()
--     end
--     dap.listeners.before.event_terminated["dapui_config"] = function()
--       dapui.open()
--     end
--     dap.listeners.before.event_exited["dapui_config"] = function()
--       dapui.open()
--     end
--
--     local Config = require("lazyvim.config")
--     vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
--     for name, sign in pairs(Config.icons.dap) do
--       sign = type(sign) == "table" and sign or { sign }
--       vim.fn.sign_define(
--         "Dap" .. name,
--         { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
--       )
--     end
--   end,
--   keys = {
--     {
--       "<F5>",
--       function()
--         require("telescope").extensions.dap.configurations({})
--       end,
--       desc = "DAP configurations",
--     },
--     -- 在单步执行时，遇到子函数就进入并且继续单步执行，有的会跳到源代码里面去执行。
--     {
--       "<F7>",
--       function()
--         require("dap").step_into()
--       end,
--       desc = "Step Into",
--     },
--     -- 在单步执行时，在函数内遇到子函数时不会进入子函数内单步执行，而是将子函数整个执行完再停止，也就是把子函数整个作为一步。
--     -- 在不存在子函数的情况下是和step into效果一样的。简单的说就是，程序代码越过子函数，但子函数会执行，且不进入
--     {
--       "<F8>",
--       function()
--         require("dap").step_over()
--       end,
--       desc = "Step Over",
--     },
--     -- 假如进入了一个函数体中，你看了两行代码，不想看了，跳出当前函数体内，返回到调用此函数的地方，即使用此功能即可
--     {
--       "S-<F8>",
--       function()
--         require("dap").step_out()
--       end,
--       desc = "Step Out",
--     },
--     {
--       "<F9>",
--       function()
--         require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
--       end,
--       desc = "Breakpoint Condition",
--     },
--     {
--       "<leader>db",
--       function()
--         require("dap").toggle_breakpoint()
--       end,
--       desc = "Toggle Breakpoint",
--     },
--     {
--       "<leader>dc",
--       function()
--         require("dap").continue()
--       end,
--       desc = "Continue",
--     },
--     {
--       "<leader>dC",
--       function()
--         require("dap").run_to_cursor()
--       end,
--       desc = "Run to Cursor",
--     },
--     {
--       "<leader>dg",
--       function()
--         require("dap").goto_()
--       end,
--       desc = "Go to line (no execute)",
--     },
--     {
--       "<leader>dj",
--       function()
--         require("dap").down()
--       end,
--       desc = "Down",
--     },
--     {
--       "<leader>dk",
--       function()
--         require("dap").up()
--       end,
--       desc = "Up",
--     },
--     {
--       "<leader>dl",
--       function()
--         require("dap").run_last()
--       end,
--       desc = "Run Last",
--     },
--     {
--       "<leader>dp",
--       function()
--         require("dap").pause()
--       end,
--       desc = "Pause",
--     },
--     {
--       "<leader>dr",
--       function()
--         require("dap").repl.toggle()
--       end,
--       desc = "Toggle REPL",
--     },
--     {
--       "<leader>ds",
--       function()
--         require("dap").session()
--       end,
--       desc = "Session",
--     },
--     {
--       "<leader>dt",
--       function()
--         require("dap").terminate()
--       end,
--       desc = "Terminate",
--     },
--     {
--       "<leader>dw",
--       function()
--         require("dap.ui.widgets").hover()
--       end,
--       desc = "Widgets",
--     },
--   },
-- }

return {
  {
    "mfussenegger/nvim-dap",
    recommended = true,
    desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

    dependencies = {
      "rcarriga/nvim-dap-ui",
      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },

  -- stylua: ignore
  keys = {
    { "<leader>d", "", desc = "+debug", mode = {"n", "v"} },
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },

    config = function()
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      local icons = require("config.icons").icons
      for name, sign in pairs(icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
    },
    opts = {},
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {},
  },
  { "nvim-neotest/nvim-nio" },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
      },
    },
    -- mason-nvim-dap is loaded when nvim-dap loads
    config = function() end,
  },
}
