return {
  "ibhagwan/fzf-lua",
  lazy = true,
  cmd = "FzfLua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local actions = require("fzf-lua.actions")

    local img_previewer ---@type string[]?
    for _, v in ipairs({
      { cmd = "ueberzug", args = {} },
      { cmd = "chafa", args = { "{file}", "--format=symbols" } },
      { cmd = "viu", args = { "-b" } },
    }) do
      if vim.fn.executable(v.cmd) == 1 then
        img_previewer = vim.list_extend({ v.cmd }, v.args)
        break
      end
    end

    -- calling `setup` is optional for customization
    require("fzf-lua").setup({
      winopts = {
        border = "rounded",
        preview = {
          layout = "horizontal",
          scrollchars = { "┃", "" },
        },
        fullscreen = true,
      },
      fzf_colors = true,
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      keymap = {
        builtin = {
          ["<c-f>"] = "toggle-fullscreen",
          ["<c-r>"] = "toggle-preview-wrap",
          ["<c-p>"] = "toggle-preview",
          ["<c-y>"] = "preview-page-down",
          ["<c-l>"] = "preview-page-up",
          ["<S-left>"] = "preview-page-reset",
        },
        fzf = {
          ["esc"] = "abort",
          ["ctrl-h"] = "unix-line-discard",
          ["ctrl-k"] = "half-page-down",
          ["ctrl-b"] = "half-page-up",
          ["ctrl-n"] = "beginning-of-line",
          ["ctrl-a"] = "end-of-line",
          ["alt-a"] = "toggle-all",
          ["f3"] = "toggle-preview-wrap",
          ["f4"] = "toggle-preview",
          ["shift-down"] = "preview-page-down",
          ["shift-up"] = "preview-page-up",
          ["ctrl-e"] = "down",
          ["ctrl-u"] = "up",
        },
      },
      previewers = {
        git_diff = {
          cmd_deleted = "git diff --color HEAD --",
          cmd_modified = "git diff --color HEAD",
          cmd_untracked = "git diff --color --no-index /dev/null",
          pager = "delta", -- if you have `delta` installed
        },
        builtin = {
          syntax = true, -- preview syntax highlight?
          syntax_limit_l = 0, -- syntax limit (lines), 0=nolimit
          syntax_limit_b = 1024 * 1024, -- syntax limit (bytes), 0=nolimit
          extensions = {
            ["png"] = img_previewer,
            ["jpg"] = img_previewer,
            ["jpeg"] = img_previewer,
            ["gif"] = img_previewer,
            ["webp"] = img_previewer,
          },
          ueberzug_scaler = "fit_contain",
        },
      },
      files = {
        -- previewer      = "bat",          -- uncomment to override previewer
        -- (name from 'previewers' table)
        -- set to 'false' to disable
        prompt = "  ",
        multiprocess = true, -- run command in a separate process
        git_icons = true, -- show git icons?
        file_icons = true, -- show file icons?
        color_icons = true, -- colorize file|git icons
        cwd_prompt = false,
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },
      buffers = {
        prompt = "Buffers❯ ",
        file_icons = true, -- show file icons?
        color_icons = true, -- colorize file|git icons
        sort_lastused = true, -- sort buffers() by last used
      },
      grep = {
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },
      code_actions = {
        previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
      },
    })
  end,
  keys = {
    { "<esc>", "<esc>", ft = "fzf", mode = "t", nowait = true },
    { "<C-p>", "<cmd>lua require('fzf-lua').files()<cr>", desc = "FzfLua files" },
    { "<C-g>", "<cmd>lua require('fzf-lua').live_grep()<cr>", desc = "FzfLua live_grep" },
    { "<C-e>", "<cmd>lua require('fzf-lua').lsp_document_diagnostics()<cr>", desc = "FzfLua builtin" },
    { "<A-r>", "<cmd>FzfLua lsp_references jump_to_single_result=true ignore_current_line=true<cr>", desc = "FzfLua references" },
    { "<A-d>", "<cmd>FzfLua lsp_definitions jump_to_single_result=true ignore_current_line=true<cr>", desc = "FzfLua definitions" },
    { "gI", "<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>", desc = "Goto Implementation" },
    { "gy", "<cmd>FzfLua lsp_typedefs jump_to_single_result=true ignore_current_line=true<cr>", desc = "Goto T[y]pe Definition" },
    { "<leader>fo", "<cmd>FzfLua oldfiles<CR>", desc = "Find files history" },
    { "<leader>fh", "<cmd>FzfLua live_grep_resume<CR>", desc = "Find last lookup" },
    { "<leader>fw", "<cmd>FzfLua grep_cword<CR>", desc = "Find all help document tags" },
    { "<leader>fm", "<cmd>FzfLua marks<CR>", desc = "Find marks in the current workspace" },
    { "<leader>fi", "<cmd>FzfLua highlights<CR>", desc = "Find all neovim highlights" },
    { "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "Find all buffers" },
    { "<leader>f/", "<cmd>FzfLua search_history<CR>", desc = "Find all search history" },
    { "<leader>f:", "<cmd>FzfLua command_history<CR>", desc = "Find all command history" },
    { "<leader>fd", "<cmd>FzfLua diagnostics_workspace<CR>", desc = "Find diagnostics in the current workspace" },
    { "<leader>cs", "<cmd>FzfLua colorschemes<CR>", { desc = "Switch colorscheme" } },
    {
      "<leader>fs",
      "<cmd>FzfLua spell_suggest<cr>",
      desc = "Find spelling suggestions",
    },
  },
}
