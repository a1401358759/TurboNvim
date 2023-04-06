return {
  "nvim-tree/nvim-tree.lua",
  lazy = true,
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = function()
    local icons = require("lazyvim.config").icons
    return {
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      auto_reload_on_write = true,
      create_in_closed_folder = false,
      disable_netrw = false,
      hijack_cursor = true,
      hijack_netrw = true,
      hijack_unnamed_buffer_when_opening = true,
      ignore_buffer_on_setup = false,
      open_on_setup = false,
      open_on_setup_file = false,
      open_on_tab = false,
      sort_by = "name",
      notify = {
        threshold = vim.log.levels.WARN,
      },
      ui = {
        confirm = {
          remove = true,
          trash = true,
        },
      },
      update_focused_file = {
        enable = true,
        update_cwd = false,
        update_root = true,
        ignore_list = {},
      },
      view = {
        adaptive_size = true,
        centralize_selection = false,
        width = 30,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        hide_root_folder = false,
        float = {
          enable = false,
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
          global = false,
        },
        open_file = {
          quit_on_open = false,
          resize_window = false,
          window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "terminal", "help" },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
      experimental = {
        git = {
          async = true,
        },
      },
      filters = {
        dotfiles = false,
        custom = { "node_modules", "\\.cache", "__pycache__", "^.git$", "^.github$" },
        exclude = {},
      },
      renderer = {
        add_trailing = true,
        group_empty = true,
        highlight_git = true,
        full_name = true,
        highlight_opened_files = "none",
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "CMakeLists.txt" },
        symlink_destination = true,
        indent_markers = {
          enable = true,
          icons = {
            corner = "└ ",
            edge = "│ ",
            item = "│ ",
            none = "  ",
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
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      ignore_ft_on_setup = {},
    }
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
