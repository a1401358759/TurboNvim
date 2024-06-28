return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  opts = function()
    local logo = [[
      ████████╗██╗░░░██╗██████╗░██████╗░░█████╗░███╗░░██╗██╗░░░██╗██╗███╗░░░███╗
      ╚══██╔══╝██║░░░██║██╔══██╗██╔══██╗██╔══██╗████╗░██║██║░░░██║██║████╗░████║
      ░░░██║░░░██║░░░██║██████╔╝██████╦╝██║░░██║██╔██╗██║╚██╗░██╔╝██║██╔████╔██║
      ░░░██║░░░██║░░░██║██╔══██╗██╔══██╗██║░░██║██║╚████║░╚████╔╝░██║██║╚██╔╝██║
      ░░░██║░░░╚██████╔╝██║░░██║██████╦╝╚█████╔╝██║░╚███║░░╚██╔╝░░██║██║░╚═╝░██║
      ░░░╚═╝░░░░╚═════╝░╚═╝░░╚═╝╚═════╝░░╚════╝░╚═╝░░╚══╝░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝
    ]]

    logo = string.rep("\n", 8) .. logo .. "\n\n"

    local opts = {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = true,
        tabline = true,
        winbar = true,
      },
      config = {
        header = vim.split(logo, "\n"),
        center = {
          { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
          { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
          { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
          { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
          { action = "e $MYVIMRC", desc = " Config", icon = " ", key = "c" },
          { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
          { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
          { action = "qa", desc = " Quit", icon = " ", key = "q" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
    end

    -- open dashboard after closing lazy
    if vim.o.filetype == "lazy" then
      vim.api.nvim_create_autocmd("WinClosed", {
        pattern = tostring(vim.api.nvim_get_current_win()),
        once = true,
        callback = function()
          vim.schedule(function()
            vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
          end)
        end,
      })
    end

    return opts
  end,
}
