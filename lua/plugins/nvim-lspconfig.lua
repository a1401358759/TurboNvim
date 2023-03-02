local ignore_list = {
  "W391",
  "E701",
  "E266",
  "E309",
  "E306",
  "E501",
  "C901",
  "C0301",
  "W0142",
  "W0401",
  "W0402",
  "R0201",
  "E1101",
  "E1102",
  "C0103",
  "R0901",
  "R0903",
  "R0904",
  "C1001",
  "W0223",
  "W0232",
  "W0201",
  "E1103",
  "R0801",
  "C0111",
  "E722",
  "W292",
  "E402",
  "F821",
  "W503",
  "E203",
}
return {
  "neovim/nvim-lspconfig",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
    { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
      "hrsh7th/cmp-nvim-lsp",
      cond = function()
        return require("lazyvim.util").has("nvim-cmp")
      end,
    },
  },
  ---@class PluginLspOpts
  opts = {
    -- options for vim.diagnostic.config()
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = { spacing = 4, prefix = "●" },
      severity_sort = true,
    },
    -- Automatically format on save
    autoformat = false,
    -- options for vim.lsp.buf.format
    -- `bufnr` and `filter` is handled by the LazyVim formatter,
    -- but can be also overridden when specified
    format = {
      formatting_options = nil,
      timeout_ms = nil,
    },
    -- LSP Server Settings
    ---@type lspconfig.options
    servers = {
      jsonls = {
        mason = true,
      },
      lua_ls = {
        mason = true, -- set to false if you don't want this server to be installed with mason
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
      gopls = {
        mason = true,
        settings = {
          cmd = { "gopls" },
          single_file_support = true,
          filetypes = { "go", "gomod", "gotmpl" },
        },
      },
      pylsp = {
        mason = true,
        settings = {
          pylsp = {
            configurationSources = { "flake8" },
            plugins = {
              flake8 = {
                enabled = true,
                ignore = ignore_list,
                maxLineLength = 140,
              },
              pycodestyle = {
                enable = false,
                ignore = ignore_list,
                maxLineLength = 140,
              },
              autopep8 = {
                enable = false,
                ignore = ignore_list,
                maxLineLength = 140,
              },
              pyflakes = {
                enable = false,
                ignore = ignore_list,
                maxLineLength = 140,
              },
              mccabe = {
                enable = false,
                threshold = 100,
              },
              pylint = {
                enable = false,
                ignore = ignore_list,
                maxLineLength = 140,
              },
            },
          },
        },
      },
    },
    -- you can do any additional lsp server setup here
    -- return true if you don't want this server to be setup with lspconfig
    ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
    setup = {
      -- example to setup with typescript.nvim
      -- tsserver = function(_, opts)
      --   require("typescript").setup({ server = opts })
      --   return true
      -- end,
      -- Specify * to use this function as a fallback for any server
      -- ["*"] = function(server, opts) end,
    },
  },
  ---@param opts PluginLspOpts
  config = function(plugin, opts)
    -- setup autoformat
    require("lazyvim.plugins.lsp.format").autoformat = opts.autoformat
    -- setup formatting and keymaps
    require("lazyvim.util").on_attach(function(client, buffer)
      require("lazyvim.plugins.lsp.format").on_attach(client, buffer)
      require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
    end)

    -- diagnostics
    for name, icon in pairs(require("lazyvim.config").icons.diagnostics) do
      name = "DiagnosticSign" .. name
      vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
    end
    vim.diagnostic.config(opts.diagnostics)

    local servers = opts.servers
    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

    local function setup(server)
      local server_opts = vim.tbl_deep_extend("force", {
        capabilities = vim.deepcopy(capabilities),
      }, servers[server] or {})

      if opts.setup[server] then
        if opts.setup[server](server, server_opts) then
          return
        end
      elseif opts.setup["*"] then
        if opts.setup["*"](server, server_opts) then
          return
        end
      end
      require("lspconfig")[server].setup(server_opts)
    end

    -- temp fix for lspconfig rename
    -- https://github.com/neovim/nvim-lspconfig/pull/2439
    local mappings = require("mason-lspconfig.mappings.server")
    if not mappings.lspconfig_to_package.lua_ls then
      mappings.lspconfig_to_package.lua_ls = "lua-language-server"
      mappings.package_to_lspconfig["lua-language-server"] = "lua_ls"
    end

    local mlsp = require("mason-lspconfig")
    local available = mlsp.get_available_servers()

    local ensure_installed = {} ---@type string[]
    for server, server_opts in pairs(servers) do
      if server_opts then
        server_opts = server_opts == true and {} or server_opts
        -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
        if server_opts.mason == false or not vim.tbl_contains(available, server) then
          setup(server)
        else
          ensure_installed[#ensure_installed + 1] = server
        end
      end
    end

    require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
    require("mason-lspconfig").setup_handlers({ setup })
  end,
}
