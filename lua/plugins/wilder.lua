return {
  "gelguy/wilder.nvim",
  lazy = true,
  event = "CmdlineEnter", -- 懒加载：首次进入cmdline时载入
  config = function()
    local wilder = require("wilder")
    wilder.setup({ modes = { ":", "/", "?" } })
    vim.api.nvim_command("silent! UpdateRemotePlugins") -- 需要载入一次py依赖 不然模糊过滤等失效
    -- 设置source
    wilder.set_option("pipeline", {
      wilder.branch(
        -- 当默认无输入时 展示15条历史记录
        {
          wilder.check(function(_, x)
            return vim.fn.empty(x)
          end),
          wilder.history(10),
        },
        -- 当输入时 展示所有匹配项(模糊匹配)
        wilder.cmdline_pipeline({
          fuzzy = 1,
          set_pcre2_pattern = 1,
          fuzzy_filter = wilder.vim_fuzzy_filter(),
        }),
        wilder.python_search_pipeline({
          pattern = "fuzzy",
        }),
        -- pipeline for search
        wilder.search_pipeline()
      ),
    })
    -- 设置样式
    wilder.set_option(
      "renderer",
      wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
        -- 'single', 'double', 'rounded' or 'solid'
        -- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
        border = "rounded",
        highlights = {
          accent = "WilderAccent",
          selected_accent = "WilderSelectedAccent",
        },
        highlighter = wilder.basic_highlighter(),
        left = { " ", wilder.popupmenu_devicons() }, -- 左侧加入icon
        right = { " ", wilder.popupmenu_scrollbar() }, -- 右侧加入滚动条
        max_height = "75%", -- max height of the palette
        min_height = 0, -- set to the same as 'max_height' for a fixed height window
        max_width = "40%",
        min_width = "40%",
        prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
        reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
      }))
    )
    -- 设置高亮
    vim.api.nvim_set_hl(0, "WilderAccent", { fg = "#5f87ff" })
    vim.api.nvim_set_hl(0, "WilderSelectedAccent", { fg = "#5f87ff", bg = "#4e4e4e" })
    -- 设置快捷键
    vim.api.nvim_set_keymap(
      "c",
      "<tab>",
      [[wilder#in_context() ? wilder#next() : '<tab>']],
      { noremap = true, expr = true }
    )
    vim.api.nvim_set_keymap(
      "c",
      "<Down>",
      [[wilder#in_context() ? wilder#next() : '<down>']],
      { noremap = true, expr = true }
    )
    vim.api.nvim_set_keymap(
      "c",
      "<up>",
      [[wilder#in_context() ? wilder#previous() : '<up>']],
      { noremap = true, expr = true }
    )
    vim.api.nvim_set_keymap("c", "0", "0", {}) -- 不清楚原因导致0无法使用 强制覆盖
  end,
}
