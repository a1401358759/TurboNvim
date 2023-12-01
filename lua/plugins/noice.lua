return {
  "folke/noice.nvim",
  lazy = true,
  event = "VeryLazy",
  opts = {
    cmdline = {
      enabled = false, -- enables the Noice cmdline UI
      view = "cmdline_popup", -- `cmdline_popup`, view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
      opts = { -- global options for the cmdline. See section on views
        border = { text = { top = "", top_align = "left" } },
      },

      format = {
        -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
        -- view: (default is cmdline view)
        -- opts: any options passed to the view
        -- icon_hl_group: optional hl_group for the icon
        -- title: set to anything or empty string to hide
        cmdline = { pattern = "^:", icon = "", lang = "vim" },
        search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
        search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
        filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
        man = { pattern = "^:%s*Man%s+", icon = "龎", lang = "bash" },
        lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
        help = { pattern = "^:%s*he?l?p?%s+", icon = "ﲉ" },
        input = {}, -- Used by input()
        -- lua = false, -- to disable a format, set to `false`
      },
    },

    messages = {
      -- NOTE: If you enable messages, then the cmdline is enabled automatically.
      -- This is a current Neovim limitation.
      enabled = true, -- enables the Noice messages UI
    },

    popupmenu = {
      enabled = true, -- enables the Noice popupmenu UI
      ---@type 'nui'|'cmp'
      backend = "nui", -- backend to use to show regular cmdline completions
      -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
      kind_icons = {}, -- set to `false` to disable icons
    },

    notify = {
      -- Noice can be used as `vim.notify` so you can route any notification like other messages
      -- Notification messages have their level and other properties set.
      -- event is always "notify" and kind can be any log level as a string
      -- The default routes will forward notifications to nvim-notify
      -- Benefit of using Noice for this is the routing and consistent history view
      enabled = true,
      view = "notify",
    },

    lsp = {
      progress = {
        enabled = true,
        -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
        -- See the section on formatting for more details on how to customize.
        format = "lsp_progress",
        format_done = "lsp_progress_done",
        throttle = 1000 / 100, -- frequency to update lsp progress message
        view = "mini",
      },

      override = {
        -- override the default lsp markdown formatter with Noice
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        -- override the lsp markdown formatter with Noice
        ["vim.lsp.util.stylize_markdown"] = true,
        -- override cmp documentation with Noice (needs the other options to work)
        ["cmp.entry.get_documentation"] = true,
      },

      hover = {
        enabled = true,
        view = nil, -- when nil, use defaults from documentation
        opts = {}, -- merged with defaults from documentation
      },

      signature = {
        enabled = true,
        auto_open = {
          enabled = true,
          trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
          luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
          throttle = 50, -- Debounce lsp signature help request by 50ms
        },
        view = nil, -- when nil, use defaults from documentation
        opts = {}, -- merged with defaults from documentation
      },

      message = {
        -- Messages shown by lsp servers
        enabled = true,
        view = "notify",
        opts = {},
      },
    },

    presets = {
      -- you can enable a preset by setting it to true, or a table that will override the preset config
      -- you can also add custom presets that you can enable/disable with enabled=true
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },

    -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
    throttle = 1000 / 100,

    views = { ---@see section on views
      ["mini"] = {
        reverse = false,
        align = "message-left",
        timeout = 3000,
        position = { row = -2, col = -2 },
        size = {
          max_height = math.ceil(0.8 * vim.o.lines),
          max_width = math.ceil(0.8 * vim.o.columns),
          width = "auto",
          height = "auto",
        },
        win_options = { winblend = 0 },
      },

      ["cmdline"] = {
        backend = "mini",
        relative = "editor",
        align = "message-left",
        timeout = 100,
        reverse = true,
        position = { row = -2, col = 0 },
        size = "auto",
        zindex = 60,

        border = {
          style = {
            { "╭", "" },
            { "─", "" },
            { "╮", "" },
            { "│", "" },
            { "╯", "" },
            { "─", "" },
            { "╰", "" },
            { "│", "" },
          },
          padding = { left = 1, right = 1 },
        },
        win_options = {
          winblend = 0,
          winhighlight = { Normal = "", IncSearch = "", Search = "" },
        },
      },
    },
  },
}
