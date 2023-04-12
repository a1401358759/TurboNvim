return {
  "nvim-tree/nvim-tree.lua",
  lazy = true,
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local icons = require("lazyvim.config").icons
    require("nvim-tree").setup({
      auto_reload_on_write = true,
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = false,
      sync_root_with_cwd = true,
      sort_by = "name",
      root_dirs = {},
      prefer_startup_root = false,
      reload_on_bufenter = false,
      respect_buf_cwd = false,
      on_attach = "disable",
      remove_keymaps = false,
      select_prompts = false,
      update_cwd = true,
      notify = {
        threshold = vim.log.levels.WARN,
      },
      update_focused_file = {
        enable = true,
        update_cwd = false,
      },
      view = {
        side = "left",
        adaptive_size = true,
        width = 30,
        centralize_selection = false,
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        mappings = {
          list = {
            { key = "?", action = "toggle_help" },
          },
        },
        float = {
          enable = false,
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 30,
            height = 30,
            row = 1,
            col = 1,
          },
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          error = icons.diagnostics.Error,
          warning = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = true,
          restrict_above_cwd = false,
        },
        open_file = {
          resize_window = true,
          window_picker = {
            enable = true,
          },
        },
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
      filters = {
        dotfiles = false,
        custom = { "node_modules", "\\.cache", "__pycache__", "^.git$", "^.github$" },
        exclude = {},
      },
      renderer = {
        add_trailing = true,
        highlight_git = true,
        highlight_opened_files = "none",
        indent_width = 2,
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
        icons = {
          webdev_colors = true,
          git_placement = "before",
          padding = " ",
          symlink_arrow = "  ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            git = {
              unstaged = "",
              staged = "",
              unmerged = "",
              renamed = "",
              untracked = "",
              deleted = "",
              ignored = "",
            },
            folder = {
              arrow_open = "",
              arrow_closed = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
          },
        },
      },
    })
  end,
  keys = {
    {
      "<leader>1",
      function()
        vim.cmd("NvimTreeToggle")
      end,
      desc = "Open File Explorer",
    },
    {
      "<leader>fc",
      function()
        vim.cmd("NvimTreeFindFile")
      end,
      desc = "Find the current file and open it in file explorer",
    },
  },
}
