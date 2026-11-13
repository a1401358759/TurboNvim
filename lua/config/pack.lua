-- Install plugins with vim.pack, then load them from lua/plugins/*.lua.
-- A file returns one spec, or a list of specs of the same kind.
-- `name` defaults to the filename. Set it when a file holds several plugins.
-- `needs` uses that name. Adding a plugin does not require an edit here.
--
--   return {
--     "https://github.com/owner/name",
--     on = "file", -- "start" (startup), "ui" (UIEnter), "file" (first buffer). Omit to load on keys/cmd/ft/event.
--     needs = { "plenary" },
--     cmd = "Name",
--     keys = { { "<leader>x", "<cmd>Name<cr>", desc = "Name" } },
--     config = function()
--       require("name").setup()
--     end,
--   }
--
-- vim.pack has no event loader. `load = false` only registers the plugin.
-- A later :packadd sources it.

local M = {}
package.loaded["config.pack"] = M

local pack_specs = {}
local by_name = {}
local ordered = {}
local paths = {}
local done = {}
local loaded = {}
local stub_owner = {}

local function plugin_name(url)
  return url:match("([^/]+)$")
end

local function append_url(url, version)
  local spec = { src = url, name = plugin_name(url) }
  if version ~= nil then
    spec.version = version
  end
  pack_specs[#pack_specs + 1] = spec
  return spec.name
end

local function as_list(value)
  if value == nil then
    return {}
  end
  if type(value) == "table" then
    return value
  end
  return { value }
end

local function enabled(raw)
  if raw.enabled == nil then
    return true
  end
  if type(raw.enabled) == "function" then
    return raw.enabled()
  end
  return raw.enabled and true or false
end

local function source_names(raw)
  local src = raw.src
  if src == nil and type(raw[1]) == "string" then
    src = raw[1]
  end
  if type(src) == "string" then
    return { append_url(src, raw.version) }
  end
  if type(src) ~= "table" then
    return nil
  end
  local names = {}
  for _, item in ipairs(src) do
    if type(item) == "string" then
      names[#names + 1] = append_url(item)
    else
      names[#names + 1] = append_url(item[1] or item.src, item.version)
    end
  end
  return names
end

local function as_specs(result, name)
  if type(result) ~= "table" then
    return {}
  end
  local single = type(result.src) == "string" or type(result.src) == "table" or type(result[1]) == "string"
  if single then
    if result.name == nil then
      result.name = name
    end
    return { result }
  end
  local list = {}
  for _, item in ipairs(result) do
    if type(item) == "table" then
      if item.name == nil then
        item.name = name
      end
      list[#list + 1] = item
    end
  end
  return list
end

local function register(raw)
  if not enabled(raw) then
    return
  end
  local plugins = source_names(raw)
  if not plugins then
    vim.notify("Plugin spec missing src: " .. raw.name, vim.log.levels.ERROR)
    return
  end
  if by_name[raw.name] then
    vim.notify("Duplicate plugin spec: " .. raw.name, vim.log.levels.ERROR)
    return
  end
  local colors = raw.colorscheme
  if type(colors) == "string" then
    colors = { colors }
  end
  local spec = {
    name = raw.name,
    plugins = plugins,
    needs = raw.needs or {},
    on = raw.on,
    event = raw.event,
    ft = raw.ft,
    cmd = raw.cmd,
    keys = raw.keys,
    colors = colors,
    config = raw.config,
  }
  by_name[spec.name] = spec
  ordered[#ordered + 1] = spec
end

local function packadd(name)
  if loaded[name] then
    return
  end
  local path = paths[name]
  if not path then
    vim.notify("Plugin is not installed: " .. name, vim.log.levels.WARN)
    return
  end
  loaded[name] = true
  vim.cmd.packadd({ name, magic = { file = false } })
  if vim.v.vim_did_enter == 1 then
    local files = vim.fn.glob(path .. "/after/plugin/**/*.{vim,lua}", false, true)
    for _, file in ipairs(files) do
      vim.cmd.source({ file, magic = { file = false } })
    end
  end
end

local function clear_cmds(id)
  for cmd, owner in pairs(stub_owner) do
    if owner == id then
      pcall(vim.api.nvim_del_user_command, cmd)
      stub_owner[cmd] = nil
    end
  end
end

function M.load(id)
  if done[id] then
    return
  end
  local spec = by_name[id]
  if not spec then
    vim.notify("Unknown plugin: " .. id, vim.log.levels.ERROR)
    return
  end
  done[id] = true
  for _, dep in ipairs(spec.needs) do
    M.load(dep)
  end
  clear_cmds(id)
  for _, name in ipairs(spec.plugins) do
    packadd(name)
  end
  if spec.config then
    local ok, err = pcall(spec.config)
    if not ok then
      vim.notify(err, vim.log.levels.ERROR)
    end
  end
end

function M.is_loaded(name)
  return loaded[name] == true
end

function M.loaded_count()
  local n = 0
  for _ in pairs(loaded) do
    n = n + 1
  end
  return n
end

local function run_rhs(rhs, mode)
  if type(rhs) == "function" then
    return rhs()
  end
  local line = rhs:gsub("^<[Cc]md>", ""):gsub("<[Cc][Rr]>$", "")
  if mode == "x" or mode == "v" then
    line = "'<,'>" .. line
  end
  vim.cmd(line)
end

local function bind(spec, key)
  local lhs = key[1]
  local rhs = key[2]
  local desc = key.desc
  local expr = key.expr
  local modes = key.mode or "n"
  if type(modes) ~= "table" then
    modes = { modes }
  end
  for _, mode in ipairs(modes) do
    local m = mode
    vim.keymap.set(m, lhs, function()
      M.load(spec.name)
      return run_rhs(rhs, m)
    end, { desc = desc, silent = true, expr = expr or nil })
  end
end

local function define_cmd(spec, cmd)
  if stub_owner[cmd] then
    return
  end
  stub_owner[cmd] = spec.name
  vim.api.nvim_create_user_command(cmd, function(args)
    M.load(spec.name)
    local line = cmd .. (args.bang and "!" or "")
    if args.args ~= "" then
      line = line .. " " .. args.args
    end
    local ok, err = pcall(vim.cmd, line)
    if not ok then
      vim.notify(err, vim.log.levels.ERROR)
    end
  end, { nargs = "*", bang = true, desc = cmd })
end

local function wire(spec)
  for _, cmd in ipairs(as_list(spec.cmd)) do
    define_cmd(spec, cmd)
  end
  for _, key in ipairs(spec.keys or {}) do
    bind(spec, key)
  end
  if spec.ft then
    local id = spec.name
    vim.api.nvim_create_autocmd("FileType", {
      pattern = spec.ft,
      callback = function()
        M.load(id)
        return true
      end,
    })
  end
  if spec.event then
    local id = spec.name
    vim.api.nvim_create_autocmd(spec.event, {
      once = true,
      callback = function()
        M.load(id)
      end,
    })
  end
end

local function load_on(phase)
  for _, spec in ipairs(ordered) do
    if spec.on == phase then
      M.load(spec.name)
    end
  end
end

local root = vim.fn.stdpath("config") .. "/lua/plugins/"
local files = vim.fn.glob(root .. "*.lua", false, true)
table.sort(files)
for _, file in ipairs(files) do
  local name = vim.fn.fnamemodify(file, ":t:r")
  local ok, result = pcall(require, "plugins." .. name)
  if not ok then
    vim.notify(result, vim.log.levels.ERROR)
  else
    local specs = as_specs(result, name)
    if #specs == 0 then
      vim.notify("lua/plugins/" .. name .. ".lua did not return a plugin spec", vim.log.levels.WARN)
    end
    for _, spec in ipairs(specs) do
      register(spec)
    end
  end
end

-- `load` is a function, so vim.pack does not :packadd. It only installs.
vim.pack.add(pack_specs, {
  confirm = false,
  load = function(plug)
    paths[plug.spec.name] = plug.path
  end,
})

for _, spec in ipairs(ordered) do
  local current = spec
  wire(current)
end

function M.load_colorscheme(name)
  for _, spec in ipairs(ordered) do
    if spec.colors and vim.tbl_contains(spec.colors, name) then
      M.load(spec.name)
      return
    end
  end
end

function M.load_colorschemes()
  for _, spec in ipairs(ordered) do
    if spec.colors then
      M.load(spec.name)
    end
  end
end

-- Active colorscheme first, then on = "start" (persistence before snacks via needs).
M.load_colorscheme(os.getenv("NVIM_COLORSCHEME") or "tokyonight")
load_on("start")

vim.api.nvim_create_autocmd("CmdlineChanged", {
  callback = function()
    if vim.fn.getcmdtype() ~= ":" then
      return
    end
    local name = vim.fn.getcmdline():match("^%s*colou?rscheme!?%s+(%S+)%s*$")
    if name then
      M.load_colorscheme(name)
    end
  end,
})

vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = function()
    vim.schedule(function()
      load_on("ui")
    end)
  end,
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  once = true,
  callback = function()
    load_on("file")
  end,
})

vim.api.nvim_create_user_command("PackClean", function()
  local keep = {}
  for _, spec in ipairs(pack_specs) do
    keep[spec.src] = true
  end
  local remove = {}
  for _, pack in ipairs(vim.pack.get(nil, { info = false })) do
    if not keep[pack.spec.src] then
      remove[#remove + 1] = pack.spec.name
    end
  end
  if #remove == 0 then
    vim.notify("No plugins to delete")
    return
  end
  table.sort(remove)
  local choice = vim.fn.confirm(
    ("Delete %d plugin(s) not in the list?\n\n%s"):format(#remove, table.concat(remove, "\n")),
    "&Yes\n&No",
    2
  )
  if choice ~= 1 then
    return
  end
  vim.pack.del(remove)
end, { desc = "Delete plugins missing from lua/plugins" })

return M
