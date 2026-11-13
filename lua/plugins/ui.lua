-- 界面。
-- vim-startuptime 在 :StartupTime 时读这个值。
vim.g.startuptime_tries = 10

return {
  {
    name = "snacks",
    "https://github.com/folke/snacks.nvim",
    on = "start",
    needs = { "persistence" },
    config = function()
    ---@diagnostic disable: undefined-global
    -- stylua: ignore
    local opts = {
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
          cwd = vim.uv.cwd(),
          win = {
            title = "",
            title_pos = "center",
            border = "rounded",
          }
        },
        dashboard = {
          enabled = true,
          sections = {
            {
              section = "terminal",
              cmd = "lolcat --seed=20 ~/.config/nvim/static/neovim.cat",
              indent = -7,
              height = 6,
              width = 80,
              padding = 1,
            },
            {
              section = "keys",
              indent = 1,
              padding = 1,
            },
            { section = "recent_files", icon = " ", title = "Recent Files", indent = 3, padding = 1 },
            { section = "projects", icon = " ", title = "Projects", indent = 3, padding = 1 },
            function()
              local pack = require("config.pack")
              local loaded = pack.loaded_count()
              local total = #(vim.pack.get(nil, { info = false }) or {})
              local ms = math.floor((vim.uv.hrtime() - vim.g.startup_ns) / 1e4 + 0.5) / 100
              return {
                align = "center",
                text = {
                  { "⚡ Neovim loaded ", hl = "footer" },
                  { loaded .. "/" .. total, hl = "special" },
                  { " plugins in ", hl = "footer" },
                  { ms .. "ms", hl = "special" },
                },
              }
            end,
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
            fullscreen = false,
          },
          sources = {
            explorer = {
              finder = "explorer",
              layout = { fullscreen = false },
            }
          }
        },
        image = { force = true },
    }

      require("snacks").setup(opts)

      -- snacks.dashboard.have_plugin only looks at lazy.nvim. Session restore
      -- (dashboard "s", and opening a project) stays hidden without this.
      local dashboard = require("snacks.dashboard")
      local have_plugin = dashboard.have_plugin
      function dashboard.have_plugin(name)
        if have_plugin(name) then
          return true
        end
        local root = vim.fn.stdpath("data") .. "/site/pack/core/"
        return vim.uv.fs_stat(root .. "opt/" .. name) ~= nil or vim.uv.fs_stat(root .. "start/" .. name) ~= nil
      end

      local function map(mode, lhs, rhs, desc, extra)
        vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", { desc = desc, silent = true }, extra or {}))
      end

      map("n", "<c-q>", function()
        Snacks.bufdelete()
      end, "Delete Buffer")
      map("n", "<leader>cR", function()
        Snacks.rename.rename_file()
      end, "Rename File")
      map("t", "<c-q>", "<cmd>close<cr>", "Close Terminal")
      map("n", "<leader>tt", function()
        Snacks.terminal()
      end, "Toggle Horizontal Terminal")
      map("n", "<leader>tg", function()
        Snacks.terminal("lazygit", { win = { position = "float" } })
      end, "Lazygit")
      map("n", "<leader>td", function()
        Snacks.terminal("lazydocker", { win = { position = "float" } })
      end, "Lazydocker")
      map("n", "<leader>tf", function()
        Snacks.terminal(nil, { win = { position = "float" } })
      end, "Toggle Float Terminal")
      map("n", "<c-/>", function()
        Snacks.terminal(nil, { win = { position = "float" } })
      end, "Toggle Float Terminal")
      map("n", "<leader><space>", function()
        Snacks.picker.smart({ layout = { fullscreen = true } })
      end, "Smart Find Files")
      map("n", "<leader>/", function()
        Snacks.picker.grep({ layout = { fullscreen = true } })
      end, "Grep")
      map("n", "<leader>:", function()
        Snacks.picker.command_history()
      end, "Command History")
      map("n", "<leader>n", function()
        Snacks.picker.notifications({ layout = { fullscreen = true } })
      end, "Notification History")
      map("n", "<leader>fb", function()
        Snacks.picker.buffers({ layout = { fullscreen = true } })
      end, "Buffers")
      map("n", "<leader>fc", function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end, "Find Config File")
      map("n", "<c-p>", function()
        Snacks.picker.files({ layout = { fullscreen = true } })
      end, "Find Files")
      map("n", "<leader>ff", function()
        Snacks.picker.files({ layout = { fullscreen = true } })
      end, "Find Files")
      map("n", "<leader>fg", function()
        Snacks.picker.git_files({ layout = { fullscreen = true } })
      end, "Find Git Files")
      map("n", "<leader>fp", function()
        Snacks.picker.projects({ layout = { fullscreen = true } })
      end, "Projects")
      map("n", "<leader>fr", function()
        Snacks.picker.recent({ layout = { fullscreen = true } })
      end, "Recent")
      map("n", "<leader>fs", function()
        Snacks.picker.spelling()
      end, "Spelling")
      map("n", "<leader>gb", function()
        Snacks.picker.git_branches()
      end, "Git Branches")
      map("n", "<leader>gL", function()
        Snacks.picker.git_log()
      end, "Git Log")
      map("n", "<leader>gs", function()
        Snacks.picker.git_status()
      end, "Git Status")
      map("n", "<leader>gS", function()
        Snacks.picker.git_stash()
      end, "Git Stash")
      map("n", "<leader>gd", function()
        Snacks.picker.git_diff()
      end, "Git Diff (Hunks)")
      map("n", "<leader>gf", function()
        Snacks.picker.git_log_file()
      end, "Git Log File")
      map("n", "<leader>gB", function()
        Snacks.gitbrowse()
      end, "Git Browse")
      map("n", "<leader>sb", function()
        Snacks.picker.lines()
      end, "Buffer Lines")
      map("n", "<leader>sB", function()
        Snacks.picker.grep_buffers()
      end, "Grep Open Buffers")
      map("n", "<leader>sg", function()
        Snacks.picker.grep()
      end, "Grep")
      map({ "n", "x" }, "<leader>sw", function()
        Snacks.picker.grep_word({ layout = { fullscreen = true } })
      end, "Visual selection or word")
      map("n", '<leader>s"', function()
        Snacks.picker.registers()
      end, "Registers")
      map("n", "<leader>s/", function()
        Snacks.picker.search_history()
      end, "Search History")
      map("n", "<leader>sa", function()
        Snacks.picker.autocmds()
      end, "Autocmds")
      map("n", "<leader>sc", function()
        Snacks.picker.command_history()
      end, "Command History")
      map("n", "<leader>sC", function()
        Snacks.picker.commands()
      end, "Commands")
      map("n", "<leader>sd", function()
        Snacks.picker.diagnostics()
      end, "Diagnostics")
      map("n", "<leader>sh", function()
        Snacks.picker.help()
      end, "Help Pages")
      map("n", "<leader>sH", function()
        Snacks.picker.highlights()
      end, "Highlights")
      map("n", "<leader>si", function()
        Snacks.picker.icons()
      end, "Icons")
      map("n", "<leader>sj", function()
        Snacks.picker.jumps()
      end, "Jumps")
      map("n", "<leader>sk", function()
        Snacks.picker.keymaps()
      end, "Keymaps")
      map("n", "<leader>sl", function()
        Snacks.picker.loclist()
      end, "Location List")
      map("n", "<leader>sM", function()
        Snacks.picker.man()
      end, "Man Pages")
      map("n", "<leader>sm", function()
        Snacks.picker.marks()
      end, "Marks")
      map("n", "<leader>sR", function()
        Snacks.picker.resume()
      end, "Resume")
      map("n", "<leader>sp", function()
        Snacks.picker.cliphist()
      end, "System Cliphist")
      map("n", "<leader>sq", function()
        Snacks.picker.qflist()
      end, "Quickfix List")
      map("n", "<leader>su", function()
        Snacks.picker.undo()
      end, "Undo History")
      map("n", "<leader>uC", function()
        require("config.pack").load_colorschemes()
        Snacks.picker.colorschemes()
      end, "Colorschemes")
      map("n", "gd", function()
        Snacks.picker.lsp_definitions()
      end, "Goto Definition")
      map("n", "gD", function()
        Snacks.picker.lsp_declarations()
      end, "Goto Declaration")
      map("n", "gr", function()
        Snacks.picker.lsp_references({ layout = { fullscreen = true } })
      end, "References", { nowait = true })
      map("n", "gI", function()
        Snacks.picker.lsp_implementations()
      end, "Goto Implementation")
      map("n", "gy", function()
        Snacks.picker.lsp_type_definitions()
      end, "Goto T[y]pe Definition")
      map("n", "<leader>ss", function()
        Snacks.picker.lsp_symbols()
      end, "LSP Symbols")
      map("n", "<leader>sS", function()
        Snacks.picker.lsp_workspace_symbols()
      end, "LSP Workspace Symbols")
    end,
  },

  {
    name = "which-key",
    "https://github.com/folke/which-key.nvim",
    on = "ui",
    config = function()
      local opts = {
        ---@type false | "classic" | "modern" | "helix"
        preset = "helix",
        icons = {
          group = "",
        },
        defaults = {},
        spec = {
          {
            mode = { "n", "v" },
            { "gp", group = "Preview" },
            { "<leader><tab>", group = "Tabs" },
            { "<leader>c", group = "Code" },
            { "<leader>d", group = "Debug", icon = " " },
            { "<leader>e", group = "Explorer", icon = "󰙅 " },
            { "<leader>f", group = "File/Find", icon = " " },
            { "<leader>g", group = "Git", icon = "󰊢 " },
            { "<leader>q", group = "Quit" },
            { "<leader>r", group = "Remote", icon = "󰢹 " },
            { "<leader>s", group = "Search/Session" },
            { "<leader>t", group = "Terminal" },
            { "<leader>u", group = "UI", icon = { icon = "󰙵 ", color = "cyan" } },
            { "<leader>x", group = "Diagnostics/Quickfix", icon = { icon = "󱖫 ", color = "green" } },
            { "[", group = "Prev" },
            { "]", group = "Next" },
            { "g", group = "Goto" },
            { "gs", group = "Surround" },
            { "z", group = "Fold" },
            {
              "<leader>b",
              group = "Buffer",
              expand = function()
                return require("which-key.extras").expand.buf()
              end,
            },
            {
              "<leader>w",
              group = "Windows",
              proxy = "<c-w>",
              expand = function()
                return require("which-key.extras").expand.win()
              end,
            },
            -- better descriptions
            { "gx", desc = "Open with system app" },
          },
        },
      }

      require("which-key").setup(opts)
    end,
  },

  {
    name = "noice",
    "https://github.com/folke/noice.nvim",
    on = "ui",
    needs = { "nui" },
    config = function()
      require("noice").setup({
        cmdline = {
          enabled = true, -- enables the Noice cmdline UI
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
          bottom_search = false, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = true, -- enables an input dialog for inc-rename.nvim
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
      })
    end,
  },

  {
    name = "lualine",
    "https://github.com/nvim-lualine/lualine.nvim",
    on = "file",
    needs = { "nvim-web-devicons" },
    config = function()
      local lualine = require("lualine")
      local icons = require("config.icons").icons

      local function diff_source()
        ---@diagnostic disable-next-line: undefined-field
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
          }
        end
      end

      local colors = {
        bg = "#202328",
        fg = "#bbc2cf",
        yellow = "#ECBE7B",
        springYellow = "#e0af68",
        cyan = "#008080",
        darkblue = "#081633",
        green = "#98be65",
        orange = "#FF8800",
        violet = "#a9a1e1",
        magenta = "#c678dd",
        blue = "#51afef",
        springBlue = "#7FB4CA",
        red = "#ec5f67",
        pink = "#d27e99",
      }

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand("%:p:h")
          local gitdir = vim.fn.finddir(".git", filepath .. ";")
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }

      -- Config
      local config = {
        options = {
          component_separators = "",
          section_separators = "",
          -- globalstatus = vim.o.laststatus == 3,
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha" } },
          theme = {
            normal = { c = { fg = colors.fg } },
            inactive = { c = { fg = colors.fg } },
          },
        },
        sections = {
          -- these are to remove the defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          -- These will be filled later
          lualine_c = {},
          lualine_x = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
        extensions = {
          "aerial",
          "toggleterm",
          "nvim-dap-ui",
          "man",
          "mason",
          "quickfix",
          "trouble",
          "symbols-outline",
        },
      }

      -- Inserts a component in lualine_c at left section
      local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
      end

      -- Inserts a component in lualine_x at right section
      local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
      end

      local mode_color = {
        n = colors.blue,
        i = colors.green,
        v = colors.red,
        [""] = colors.red,
        V = colors.red,
        c = colors.magenta,
        no = colors.blue,
        s = colors.orange,
        S = colors.orange,
        [""] = colors.orange,
        ic = colors.yellow,
        R = colors.violet,
        Rv = colors.violet,
        cv = colors.red,
        ce = colors.red,
        r = colors.cyan,
        rm = colors.cyan,
        ["r?"] = colors.cyan,
        ["!"] = colors.red,
        t = colors.red,
      }

      ins_left({
        function()
          return icons.ui.Separator
        end,
        color = { fg = colors.blue },
        padding = { left = 0, right = 2 },
      })
      ins_left({
        function()
          return ""
        end,
        color = function()
          return { fg = mode_color[vim.fn.mode()] }
        end,
        padding = { right = 1 },
      })
      ins_left({
        "mode",
        color = function()
          return { fg = mode_color[vim.fn.mode()], gui = "bold" }
        end,
        padding = { left = 0, right = 1 },
      })
      ins_left({
        "filesize",
        cond = conditions.buffer_not_empty,
        color = { fg = colors.green, gui = "bold" },
      })
      ins_left({
        "branch",
        icon = icons.ui.Branch,
        color = { fg = colors.violet, gui = "bold" },
        on_click = function()
          vim.cmd([[Gitsigns toggle_signs]])
        end,
      })
      -- ins_left({
      --   "diff",
      --   colored = true,
      --   symbols = { added = icons.git.added, modified = icons.git.modified, removed = icons.git.removed },
      --   diff_color = {
      --     added = { fg = colors.green },
      --     modified = { fg = colors.orange },
      --     removed = { fg = colors.red },
      --   },
      --   sources = diff_source,
      --   cond = conditions.hide_in_width,
      -- })
      -- ins_left({
      --   "filetype",
      --   icon_only = true,
      --   padding = { left = 1, right = 0 },
      --   color = { gui = "bold" },
      -- })
      -- ins_left({
      --   "filename",
      --   padding = { left = 0 },
      --   cond = conditions.buffer_not_empty,
      --   color = { gui = "bold" },
      -- })
      -- Insert mid section. You can make any number of sections in neovim :)
      -- for lualine it's any number greater then 2
      ins_left({
        function()
          return "%="
        end,
      })

      ins_left({
        "lsp_status",
        icon = icons.ui.Gear,
        symbols = { done = "", separator = " " },
        ignore_lsp = {},
        show_name = true,
        color = { fg = colors.orange, gui = "bold" },
      })

      -- Add components to right sections
      -- ins_right({
      --   "diagnostics",
      --   sources = { "nvim_diagnostic" },
      --   symbols = {
      --     error = icons.diagnostics.Error,
      --     warn = icons.diagnostics.Warn,
      --     info = icons.diagnostics.Info,
      --     hint = icons.diagnostics.Hint,
      --   },
      --   diagnostics_color = {
      --     color_error = { fg = colors.red },
      --     color_warn = { fg = colors.yellow },
      --     color_info = { fg = colors.cyan },
      --   },
      -- })
      ins_right({
        function()
          local reg = vim.fn.reg_recording()
          return "󰃽 [" .. reg .. "]"
        end,
        cond = function()
          return vim.fn.reg_recording() ~= ""
        end,
        color = { fg = colors.magenta, gui = "bold" },
      })
      ins_right({
        "searchcount",
        color = { fg = colors.green, gui = "bold" },
      })
      ins_right({
        "venv-selector",
        color = { fg = colors.cyan, gui = "bold" },
      })
      ins_right({
        "o:encoding",
        cond = conditions.hide_in_width,
        color = { fg = colors.violet, gui = "bold" },
      })
      ins_right({
        "fileformat",
        icons_enabled = true,
        color = { fg = colors.springYellow, gui = "bold" },
      })
      ins_right({ "location", color = { fg = colors.springBlue, gui = "bold" } })
      ins_right({
        "progress",
        color = { fg = colors.green, gui = "bold" },
        on_click = function()
          vim.cmd("1")
        end,
      })
      ins_right({
        function()
          return icons.ui.Separator
        end,
        color = { fg = colors.blue },
        padding = { left = 1 },
      })
      lualine.setup(config)
    end,
  },

  {
    name = "bufferline",
    "https://github.com/akinsho/bufferline.nvim",
    on = "file",
    config = function()
      require("bufferline").setup({
        options = {
          themable = true,
          show_close_icon = true,
          numbers = "ordinal",
          buffer_close_icon = "",
          modified_icon = "●",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
          separator_style = { "", "" },
          indicator_icon = " ",
          always_show_bufferline = true,
          diagnostics = false,
          offsets = {
            {
              filetype = "neo-tree",
              text = "EXPLORER",
              text_align = "center",
              highlight = "Directory",
              separator = " ",
              padding = 0,
            },
            {
              filetype = "NvimTree",
              text = "EXPLORER",
              text_align = "center",
              highlight = "Directory",
              padding = 0,
            },
            {
              filetype = "snacks_layout_box",
            },
          },
        },
      })

      vim.api.nvim_create_autocmd("BufAdd", {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })

      local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { desc = desc, silent = true })
      end

      map("<leader>bp", "<Cmd>BufferLineTogglePin<CR>", "Toggle pin")
      map("<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", "Delete non-pinned buffers")
      map("<leader>bq", "<cmd>BufferLinePickClose<cr>", "Close target buffer")
      map("<leader>bn", "<cmd>enew<cr>", "Create new buffer")
      map("<leader>bh", "<cmd>BufferLineCloseLeft<cr>", "Close all left buffers")
      map("<leader>bl", "<cmd>BufferLineCloseRight<cr>", "Close all right buffers")
      map("<leader>bo", function()
        vim.cmd("BufferLineCloseLeft")
        vim.cmd("BufferLineCloseRight")
      end, "Close all other buffers")
      map("<leader>ba", function()
        vim.cmd("BufferLineCloseLeft")
        vim.cmd("BufferLineCloseRight")
        vim.cmd("BufferDelete")
      end, "Close all buffers")
      map("<leader>bj", "<cmd>BufferLinePick<cr>", "Pick Buffer")
      map("<leader>bs", "<cmd>BufferLineSortByExtension<cr>", "Buffers sort (by extension)")
      map("<A-1>", "<cmd>BufferLineGoToBuffer 1<cr>", "Go to buffer 1")
      map("<A-2>", "<cmd>BufferLineGoToBuffer 2<cr>", "Go to buffer 2")
      map("<A-3>", "<cmd>BufferLineGoToBuffer 3<cr>", "Go to buffer 3")
      map("<A-4>", "<cmd>BufferLineGoToBuffer 4<cr>", "Go to buffer 4")
      map("<A-5>", "<cmd>BufferLineGoToBuffer 5<cr>", "Go to buffer 5")
      map("<A-6>", "<cmd>BufferLineGoToBuffer 6<cr>", "Go to buffer 6")
      map("<A-7>", "<cmd>BufferLineGoToBuffer 7<cr>", "Go to buffer 7")
      map("<A-8>", "<cmd>BufferLineGoToBuffer 8<cr>", "Go to buffer 8")
      map("<A-9>", "<cmd>BufferLineGoToBuffer 9<cr>", "Go to buffer 9")
      map("<A-,>", "<cmd>BufferLineMovePrev<cr>", "Move current buffer to left")
      map("<A-.>", "<cmd>BufferLineMoveNext<cr>", "Move current buffer to right")
      map("<S-h>", "<cmd>BufferLineCyclePrev<cr>", "Prev Buffer")
      map("<S-l>", "<cmd>BufferLineCycleNext<cr>", "Next Buffer")
    end,
  },

  {
    name = "incline",
    "https://github.com/b0o/incline.nvim",
    on = "file",
    needs = { "nvim-web-devicons" },
    config = function()
      local devicons = require("nvim-web-devicons")
      local mine_icons = require("config.icons").icons
      require("incline").setup({
        window = {
          margin = {
            horizontal = 0,
            vertical = 1,
          },
          placement = {
            horizontal = "right",
            vertical = "top",
          },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.api.nvim_get_option_value("modified", { buf = props.buf })

          local function get_git_diff()
            local signs = vim.b[props.buf].gitsigns_status_dict
            local labels = {}
            if signs == nil then
              return labels
            end
            local icons = {
              { kind = "added", icon = mine_icons.git.added },
              { kind = "changed", icon = mine_icons.git.modified },
              { kind = "removed", icon = mine_icons.git.removed },
            }
            local diff_color = {
              added = "#b8db87",
              changed = "#7ca1f2",
              removed = "#e26a75",
            }
            for _, item in pairs(icons) do
              local name = item.kind
              if tonumber(signs[name]) and signs[name] > 0 then
                table.insert(labels, { item.icon .. signs[name] .. " ", guifg = diff_color[name] })
              end
            end
            if #labels > 0 then
              table.insert(labels, { "| ", guifg = "grey" })
            end
            return labels
          end

          local function get_diagnostic_label()
            local label = {}
            local icons = {
              { severity = "Hint", icon = mine_icons.diagnostics.Hint },
              { severity = "Info", icon = mine_icons.diagnostics.Info },
              { severity = "Warn", icon = mine_icons.diagnostics.Warn },
              { severity = "Error", icon = mine_icons.diagnostics.Error },
            }
            for _, item in pairs(icons) do
              local severity = item.severity
              local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
              if n > 0 then
                table.insert(label, { item.icon .. n .. " ", group = "DiagnosticSign" .. severity })
              end
            end
            if #label > 0 then
              table.insert(label, { "| ", guifg = "grey" })
            end
            return label
          end

          return {
            { get_diagnostic_label(), guibg = nil },
            { get_git_diff(), guibg = nil },
            { (ft_icon or "") .. " ", guifg = ft_color, guibg = nil },
            {
              filename,
              gui = modified and "bold,italic" or "bold",
              guibg = nil,
            },
          }
        end,
      })
    end,
  },

  {
    name = "neo-tree",
    "https://github.com/nvim-neo-tree/neo-tree.nvim",
    version = "v3.x",
    needs = { "plenary", "nui", "nvim-web-devicons" },
    cmd = "Neotree",
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ source = "filesystem", toggle = true })
        end,
        desc = "Explorer NeoTree",
      },
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ source = "filesystem", toggle = true })
        end,
        desc = "Explorer NeoTree",
      },
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "Git explorer",
      },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Buffer explorer",
      },
    },
    config = function()
      local icons = require("config.icons").icons

      require("neo-tree").setup({
        sources = { "filesystem", "buffers", "git_status" },
        source_selector = {
          winbar = false,
          statusline = false,
        },
        enable_diagnostics = false,
        open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
        default_component_configs = {
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "",
            folder_empty_open = "",
            use_filtered_colors = true,
          },
          modified = { symbol = "" },
          git_status = { symbols = icons.git },
          diagnostics = { symbols = icons.diagnostics },
        },
        filesystem = {
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
          filtered_items = {
            show_hidden_count = false,
            hide_by_pattern = {
              "__pycache__",
            },
          },
        },
      })
    end,
  },

  {
    name = "outline",
    "https://github.com/hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    keys = { { "<leader>2", "Outline", desc = "Toggle Outline" } },
    config = function()
      local kind_filter = {
        default = {
          "Class",
          "Constructor",
          "Enum",
          "Field",
          "Function",
          "Interface",
          "Method",
          "Module",
          "Namespace",
          "Package",
          "Property",
          "Struct",
          "Trait",
        },
        markdown = false,
        help = false,
        lua = {
          "Class",
          "Constructor",
          "Enum",
          "Field",
          "Function",
          "Interface",
          "Method",
          "Module",
          "Namespace",
          "Property",
          "Struct",
          "Trait",
        },
      }

      local icons = require("config.icons").icons

      local defaults = require("outline.config").defaults
      local opts = {
        symbols = {
          icons = {},
          filter = vim.deepcopy(kind_filter),
        },
        keymaps = {
          up_and_jump = "<up>",
          down_and_jump = "<down>",
        },
      }

      for kind, symbol in pairs(defaults.symbols.icons) do
        opts.symbols.icons[kind] = {
          icon = icons.lspkind[kind] or symbol.icon,
          hl = symbol.hl,
        }
      end

      require("outline").setup(opts)
    end,
  },

  {
    name = "trouble",
    "https://github.com/folke/trouble.nvim",
    version = "main",
    on = "file",
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    keys = {
      { "<leader>xX", "Trouble diagnostics toggle", desc = "Diagnostics (Trouble)" },
      { "<leader>xx", "Trouble diagnostics toggle filter.buf=0", desc = "Buffer Diagnostics (Trouble)" },
      {
        "<leader>cS",
        "Trouble lsp toggle focus=false win.position=right",
        desc = "LSP references/definitions/... (Trouble)",
      },
      { "<leader>xL", "Trouble loclist toggle", desc = "Location List (Trouble)" },
      { "<leader>xQ", "Trouble qflist toggle", desc = "Quickfix List (Trouble)" },
    },
    config = function()
      require("trouble").setup({
        focus = true,
      })

      local snacks_ok, snacks_actions = pcall(require, "trouble.sources.snacks")
      if snacks_ok and package.loaded.snacks then
        local snacks = require("snacks")
        snacks.config.picker.actions =
          vim.tbl_extend("force", snacks.config.picker.actions or {}, snacks_actions.actions)
        local win = snacks.config.picker.win or {}
        win.input = win.input or {}
        win.input.keys = vim.tbl_extend("force", win.input.keys or {}, {
          ["<c-t>"] = { "trouble_open", mode = { "n", "i" } },
        })
        snacks.config.picker.win = win
      end
    end,
  },

  {
    name = "markdown",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "Avante", "codecompanion" },
    config = function()
      require("render-markdown").setup({
        file_types = { "markdown", "Avante", "codecompanion" },
      })
    end,
  },

  {
    name = "colorizer",
    "https://github.com/brenoprata10/nvim-highlight-colors",
    on = "file",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "background",
        enable_named_colors = false,
        enable_tailwind = true,
      })
    end,
  },

  {
    name = "rainbow",
    "https://github.com/HiPhish/rainbow-delimiters.nvim",
    on = "file",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")

      require("rainbow-delimiters.setup").setup({
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          commonlisp = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          latex = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
        blacklist = {},
      })
    end,
  },

  {
    name = "pack-ui",
    "https://github.com/jtprogru/pack-ui.nvim",
    cmd = { "PackStatus", "PackUpdate", "PackUpdateAll" },
    keys = {
      { "<leader>ps", "PackStatus", desc = "Plugins" },
      { "<leader>pU", "PackUpdateAll", desc = "Update plugins" },
    },
    config = function()
      require("pack_ui").setup({
        border = "rounded",
      })
    end,
  },

  {
    name = "startuptime",
    "https://github.com/dstein64/vim-startuptime",
    cmd = "StartupTime",
  },
}
