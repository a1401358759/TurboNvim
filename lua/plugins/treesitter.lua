---@type string
local xdg_config = vim.env.XDG_CONFIG_HOME or vim.env.HOME .. "/.config"

---@param path string
local function have(path)
  return vim.uv.fs_stat(xdg_config .. "/" .. path) ~= nil
end

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "TurboLoad", "VeryLazy" },
  init = function(plugin)
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    -- no longer trigger the **nvim-treesitter** module to be loaded in time.
    -- Luckily, the only things that those plugins need are the custom queries, which we make available
    -- during startup.
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  opts_extend = { "ensure_installed" },
  opts = {
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    -- incremental selection
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-cr>",
        node_incremental = "<C-cr>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    textobjects = {
      move = {
        enable = true,
        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
      },
    },
    ensure_installed = {
      "bash",
      "blueprint",
      "c",
      "cmake",
      "comment",
      "cpp",
      "css",
      "cuda",
      "dockerfile",
      "dot",
      "fish",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
      "go",
      "gomod",
      "gowork",
      "gosum",
      "hjson",
      "html",
      "http",
      "java",
      "javascript",
      "jsdoc",
      "json",
      "json5",
      "jsonc",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "ninja",
      "python",
      "rust",
      "scss",
      "sql",
      "toml",
      "typescript",
      "vim",
      "vue",
      "yaml",
      "regex",
      "xml",
    },
  },
  config = function(_, opts)
    local function add(lang)
      if type(opts.ensure_installed) == "table" then
        table.insert(opts.ensure_installed, lang)
      end
    end

    vim.filetype.add({
      extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
      filename = {
        ["vifmrc"] = "vim",
      },
      pattern = {
        [".*/waybar/config"] = "jsonc",
        [".*/mako/config"] = "dosini",
        [".*/kitty/.+%.conf"] = "kitty",
        [".*/hypr/.+%.conf"] = "hyprlang",
        ["%.env%.[%w_.-]+"] = "sh",
      },
    })
    vim.treesitter.language.register("bash", "kitty")
    add("git_config")

    if have("hypr") then
      add("hyprlang")
    end

    if have("fish") then
      add("fish")
    end

    if have("rofi") or have("wofi") then
      add("rasi")
    end
    -- set up treesitter
    require("nvim-treesitter.configs").setup(opts)
  end,
  keys = {
    { "<c-cr>", desc = "Increment selection" },
    { "<bs>", desc = "Schrink selection", mode = "x" },
  },
}
