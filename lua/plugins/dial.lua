local M = {}

---@param increment boolean
---@param g? boolean
function M.dial(increment, g)
  local mode = vim.fn.mode(true)
  -- Use visual commands for VISUAL 'v', VISUAL LINE 'V' and VISUAL BLOCK '\22'
  local is_visual = mode == "v" or mode == "V" or mode == "\22"
  local func = (increment and "inc" or "dec") .. (g and "_g" or "_") .. (is_visual and "visual" or "normal")
  local group = vim.g.dials_by_ft[vim.bo.filetype] or "default"
  return require("dial.map")[func](group)
end

---@param s string
function M.str_title(s)
  return (s:gsub("(%a)([%w_']*)", function(f, r)
    return f:upper() .. r:lower()
  end))
end

return {
  "monaqa/dial.nvim",
  recommended = true,
  desc = "Increment and decrement numbers, dates, and more",
  -- stylua: ignore
  keys = {
    { "<C-a>", function() return M.dial(true) end, expr = true, desc = "Increment", mode = {"n", "v"} },
    { "<C-x>", function() return M.dial(false) end, expr = true, desc = "Decrement", mode = {"n", "v"} },
    { "g<C-a>", function() return M.dial(true, true) end, expr = true, desc = "Increment", mode = {"n", "v"} },
    { "g<C-x>", function() return M.dial(false, true) end, expr = true, desc = "Decrement", mode = {"n", "v"} },
  },
  opts = function()
    local augend = require("dial.augend")

    local logical_alias = augend.constant.new({
      elements = { "&&", "||" },
      word = false,
      cyclic = true,
    })

    local ordinal_numbers = augend.constant.new({
      -- elements through which we cycle. When we increment, we go down
      -- On decrement we go up
      elements = {
        "first",
        "second",
        "third",
        "fourth",
        "fifth",
        "sixth",
        "seventh",
        "eighth",
        "ninth",
        "tenth",
      },
      -- if true, it only matches strings with word boundary. firstDate wouldn't work for example
      word = false,
      -- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
      -- Otherwise nothing will happen when there are no further values
      cyclic = true,
    })

    local weekdays = augend.constant.new({
      elements = {
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday",
      },
      word = true,
      cyclic = true,
    })

    local months = augend.constant.new({
      elements = {
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December",
      },
      word = true,
      cyclic = true,
    })

    local group_default = {
      augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
      augend.integer.alias.decimal_int, -- nonnegative and negative decimal number
      augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
      augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
      ordinal_numbers,
      weekdays,
      months,
      augend.constant.alias.bool, -- boolean value (true <-> false)
      logical_alias,
    }

    local word_antisense_switch = {
      { "true", "false" },
      { "on", "off" },
      { "yes", "no" },
      { "disable", "enable" },
      { "enabled", "disabled" },
      { "success", "failure" },
      { "open", "close" },
      { "in", "out" },
      { "resolve", "reject" },
      { "start", "end" },
      { "before", "after" },
      { "from", "to" },
      { "relative", "absolute" },
      { "up", "down" },
      { "left", "right" },
      { "top", "bottom" },
      { "first", "last" },
      { "next", "prev" },
      { "row", "column" },
      { "dark", "light" },
      { "inferior", "superior" },
      { "lower", "upper" },
      { "selected", "unselected" },
      { "active", "inactive" },
      { "white", "black" },
      { "get", "post" },
      { "forward", "backward" },
      { "odd", "even" },
      { "old", "new" },
      { "+", "-" },
      { ">", "<" },
      { "=", "!=" },
    }

    for _, value in ipairs(word_antisense_switch) do
      local upper_words = { string.upper(value[1]), string.upper(value[2]) }
      local title_words = { M.str_title(value[1]), M.str_title(value[2]) }
      table.insert(
        group_default,
        augend.constant.new({
          elements = value,
          word = true,
          cyclic = true,
        })
      )
      table.insert(
        group_default,
        augend.constant.new({
          elements = upper_words,
          word = true,
          cyclic = true,
        })
      )
      table.insert(
        group_default,
        augend.constant.new({
          elements = title_words,
          word = true,
          cyclic = true,
        })
      )
    end

    return {
      dials_by_ft = {
        css = "css",
        vue = "vue",
        javascript = "typescript",
        typescript = "typescript",
        typescriptreact = "typescript",
        javascriptreact = "typescript",
        json = "json",
        lua = "lua",
        markdown = "markdown",
        sass = "css",
        scss = "css",
        python = "python",
      },
      groups = {
        default = group_default,
        vue = {
          augend.constant.new({ elements = { "let", "const" } }),
          augend.hexcolor.new({ case = "lower" }),
          augend.hexcolor.new({ case = "upper" }),
        },
        typescript = {
          augend.constant.new({ elements = { "let", "const" } }),
        },
        css = {
          augend.hexcolor.new({
            case = "lower",
          }),
          augend.hexcolor.new({
            case = "upper",
          }),
        },
        markdown = {
          augend.misc.alias.markdown_header,
        },
        json = {
          augend.semver.alias.semver, -- versioning (v1.1.2)
        },
        lua = {
          augend.constant.new({
            elements = { "and", "or" },
            word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
            cyclic = true, -- "or" is incremented into "and".
          }),
        },
        python = {
          augend.constant.new({
            elements = { "and", "or" },
          }),
        },
      },
    }
  end,
  config = function(_, opts)
    -- copy defaults to each group
    for name, group in pairs(opts.groups) do
      if name ~= "default" then
        vim.list_extend(group, opts.groups.default)
      end
    end
    require("dial.config").augends:register_group(opts.groups)
    vim.g.dials_by_ft = opts.dials_by_ft
  end,
}
