return {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  enabled = false,
  cmd = "Telescope",
  version = false,
  opts = function()
    local open_with_trouble = function(...)
      return require("trouble.sources.telescope").open(...)
    end
    local actions = require("telescope.actions")

    return {
      defaults = {
        mappings = {
          i = {
            ["<c-t>"] = open_with_trouble,
            ["<a-t>"] = open_with_trouble,
            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<C-f>"] = actions.preview_scrolling_down,
            ["<C-b>"] = actions.preview_scrolling_up,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },
    }
  end,
  config = function()
    local function find_command()
      if 1 == vim.fn.executable("rg") then
        return { "rg", "--files", "--color", "never", "-g", "!.git" }
      elseif 1 == vim.fn.executable("fd") then
        return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("fdfind") then
        return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
        return { "find", ".", "-type", "f" }
      elseif 1 == vim.fn.executable("where") then
        return { "where", "/r", ".", "*" }
      end
    end

    require("telescope").setup({
      defaults = {
        prompt_prefix = "  ",
        selection_caret = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal", -- bottom_pane
        color_devicons = true,
        entry_prefix = " ",
        multi_icon = "  ",
        file_ignore_patterns = { "node_modules" },
        -- open files in the first window that is an actual file.
        -- use the current window if no other window is available.
        get_selection_window = function()
          local wins = vim.api.nvim_list_wins()
          table.insert(wins, 1, vim.api.nvim_get_current_win())
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == "" then
              return win
            end
          end
          return 0
        end,
      },
      pickers = {
        find_files = {
          find_command = find_command,
          hidden = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
    })
  end,
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files in the current workspace" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Find string in the current workspace" },
    { "<leader>/", "<cmd>Telescope live_grep<CR>", desc = "Find string in the current workspace" },
    { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Find files history" },
    { "<leader>fh", "<cmd>Telescope resume<CR>", desc = "Find last lookup" },
    { "<leader>ft", "<cmd>Telescope help_tags<CR>", desc = "Find all help document tags" },
    { "<leader>fm", "<cmd>Telescope marks<CR>", desc = "Find marks in the current workspace" },
    { "<leader>fi", "<cmd>Telescope highlights<CR>", desc = "Find all neovim highlights" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find all buffers" },
    { "<leader>f/", "<cmd>Telescope search_history<CR>", desc = "Find all search history" },
    { "<leader>f:", "<cmd>Telescope command_history<CR>", desc = "Find all command history" },
    { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Find diagnostics in the current workspace" },
    {
      "<leader>fs",
      "<cmd>lua require('telescope.builtin').spell_suggest()<cr>",
      desc = "Find spelling suggestions",
    },
  },
}
