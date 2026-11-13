-- 语言工具。

return {
  {
    name = "mason",
    src = {
      "https://github.com/mason-org/mason.nvim",
      "https://github.com/mason-org/mason-lspconfig.nvim",
    },
    on = "file",
    cmd = "Mason",
    keys = { { "<leader>cm", "Mason", desc = "Mason" } },
    config = function()
      -- mason.nvim 负责安装除 lsp server 之外的其他工具
      -- mason-lspconfig 负责安装 lsp server

      local opts = {
        ensure_installed = {
          -- python
          "ruff",
          "isort",
          "black",
          -- go
          "golangci-lint",
          -- frontend
          "biome",
          -- lua
          "stylua",
          -- shell & bash
          "shfmt",
          "shellcheck",
          -- sql
          "sql-formatter",
          -- json
          "fixjson",
          -- dap
          "delve",
          "debugpy",
          -- dockerfile
          "hadolint",
          -- markdown
          "markdownlint",
          "markdown-toc",
          "marksman",
        },
        pip = {
          upgrade_pip = true,
        },
        ui = {
          border = "rounded",
          width = 0.8,
          height = 0.8,
          icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
          },
        },
      }

      require("mason").setup(opts)
      require("mason-lspconfig").setup({
        automatic_enable = false,
        ensure_installed = {
          -- python
          "pyright",
          "ty",
          -- go
          "gopls",
          -- frontend
          "html",
          "cssls",
          "emmet_ls",
          "vue_ls",
          "vtsls",
          "tailwindcss",
          -- lua
          "lua_ls",
          -- shell & bash
          "bashls",
          -- vim
          "vimls",
          -- json
          "jsonls",
          -- docker
          "dockerls",
          "docker_compose_language_service",
          -- yamal
          "yamlls",
          -- latex
          "ltex_plus",
        },
      })
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          vim.api.nvim_exec_autocmds("FileType", {
            buffer = vim.api.nvim_get_current_buf(),
            modeline = false,
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },

  {
    name = "lspconfig",
    "https://github.com/neovim/nvim-lspconfig",
    on = "file",
    needs = { "mason" },
    config = function()
      ---@diagnostic disable: missing-fields
      local diag_icons = require("config.icons").icons.diagnostics

      local opts = {
        diagnostics = {
          underline = true,
          update_in_insert = false,
          severity_sort = true,
          virtual_text = false,
          virtual_lines = {
            current_line = true,
          },
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = diag_icons.Error,
              [vim.diagnostic.severity.WARN] = diag_icons.Warn,
              [vim.diagnostic.severity.INFO] = diag_icons.Info,
              [vim.diagnostic.severity.HINT] = diag_icons.Hint,
            }, -- neovim/neovim#26193 (0.10.0+)
          },
        },
        inlay_hints = {
          enabled = true,
          exclude = { "go", "lua" }, -- filetypes for which you don't want to enable inlay hints
        },
        codelens = {
          enabled = false,
        },
        -- Enable lsp cursor word highlighting
        document_highlight = {
          enabled = true,
        },
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        -- add any global capabilities here
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        },
      }

      vim.schedule(function()
        require("lspconfig.ui.windows").default_options.border = "rounded"
        -- add capabilities
        local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        local has_blink, blink = pcall(require, "blink.cmp")
        local capabilities = vim.tbl_deep_extend(
          "force",
          {},
          vim.lsp.protocol.make_client_capabilities(),
          has_cmp and cmp_nvim_lsp.default_capabilities() or {},
          has_blink and blink.get_lsp_capabilities() or {},
          opts.capabilities or {}
        )
        -- add on_attach
        local on_attach = function(client, bufnr)
          if client.name == "ruff" or client.name == "ruff_lsp" then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end
          if opts.codelens.enabled then
            if client:supports_method("textDocument/codeLens") then
              vim.lsp.codelens.enable(true)
              vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                buffer = bufnr,
                callback = vim.lsp.codelens.enable(true),
              })
            end
          end
          if opts.inlay_hints.enabled then
            if
              vim.api.nvim_buf_is_valid(bufnr)
              and vim.bo[bufnr].buftype == ""
              and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[bufnr].filetype)
            then
              if client:supports_method("textDocument/inlayHint") then
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
              end
            end
          end
        end
        -- setup lspservers
        local mason_lspconfig = require("mason-lspconfig")
        for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
          local require_path = string.format("%s%s", "lspservers/", server_name)
          local ok, settings = pcall(require, require_path)
          if not ok then
            settings = {}
          end
          if settings.enabled ~= false then
            settings.on_attach = on_attach
            settings.capabilities = capabilities
            vim.lsp.config(server_name, settings)
            vim.lsp.enable(server_name)
          end
        end

        -- diagnostics for neovim < 0.10.0
        if vim.fn.has("nvim-0.10.0") == 0 then
          for name, icon in pairs(diag_icons) do
            name = "DiagnosticSign" .. name
            vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
          end
        end
        vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
      end)
    end,
  },

  {
    name = "treesitter",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
    on = "file",
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    config = function()
      local opts = {
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
      }

      local nvim_treesitter = require("nvim-treesitter")
      nvim_treesitter.setup()

      local pattern = {}
      for _, parser in ipairs(opts.ensure_installed) do
        local has_parser, _ = pcall(vim.treesitter.language.inspect, parser)

        if not has_parser then
          -- 需要通过系统的包管理器安装 tree-sitter-cli
          nvim_treesitter.install(parser)
        else
          vim.list_extend(pattern, vim.treesitter.language.get_filetypes(parser))
        end
      end

      local group = vim.api.nvim_create_augroup("NvimTreesitterFt", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = pattern,
        callback = function(ev)
          local max_filesize = 100 * 1024
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
          if not (ok and stats and stats.size > max_filesize) then
            vim.treesitter.start()
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })

      -- In markdown files, the rendered output would only display the correct highlight if the code is set to scheme
      -- However, this would result in incorrect highlight in neovim
      -- Therefore, the scheme language should be linked to query
      vim.treesitter.language.register("query", "scheme")

      vim.api.nvim_exec_autocmds("FileType", { group = "NvimTreesitterFt" })
    end,
  },

  {
    name = "conform",
    "https://github.com/stevearc/conform.nvim",
    on = "file",
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cF",
        function()
          require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    config = function()
      require("conform").setup({
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if not vim.g.autoformat and not vim.b[bufnr].autoformat then
            return
          end
          return { timeout_ms = 500, lsp_fallback = true }
        end,
        format = {
          timeout_ms = 3000,
          async = false,
          quiet = false,
          lsp_fallback = true,
        },
        formatters_by_ft = {
          lua = { "stylua" },
          fish = { "fish_indent" },
          sh = { "shfmt" },
          javascript = { "biome" },
          typescript = { "biome" },
          javascriptreact = { "biome" },
          typescriptreact = { "biome" },
          css = { "prettier", "prettierd" },
          html = { "prettier", "prettierd" },
          json = { "jq", "fixjson" },
          yaml = { "prettier", "prettierd" },
          markdown = { "prettierd", "prettier", "markdownlint", "markdown-toc" },
          graphql = { "prettier", "prettierd" },
          python = function(bufnr)
            if require("conform").get_formatter_info("ruff_format", bufnr).available then
              return { "ruff_fix", "ruff_organize_imports", "ruff_format" }
            else
              return { "isort", "black" }
            end
          end,
          go = { "golangcilint" },
        },
        formatters = {
          injected = { options = { ignore_errors = true } },
          black = { prepend_args = { "--line-length", "150", "--fast" } },
          ruff_format = {
            args = {
              "format",
              "--config",
              vim.fn.stdpath("config") .. "/pyproject.toml",
              "--force-exclude",
              "--stdin-filename",
              "$FILENAME",
              "-",
            },
          },
          ruff_fix = { append_args = { "--config", vim.fn.stdpath("config") .. "/pyproject.toml" } },
        },
      })
    end,
  },

  {
    name = "lint",
    "https://github.com/mfussenegger/nvim-lint",
    on = "file",
    config = function()
      local options = require("config.options")
      require("lint").linters_by_ft = {
        fish = { "fish" },
        javascript = { "biomejs" },
        typescript = { "biomejs" },
        javascriptreact = { "biomejs" },
        typescriptreact = { "biomejs" },
        python = { "ruff" },
        dockerfile = { "hadolint" },
        go = { "golangcilint" },
      }

      -- ruff
      local ruff = require("lint").linters.ruff
      ruff.args = options.ruff_args

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },

  {
    name = "lazydev",
    src = {
      "https://github.com/Bilal2453/luvit-meta",
      "https://github.com/folke/lazydev.nvim",
    },
    ft = "lua",
    cmd = "LazyDev",
    config = function()
      require("lazydev").setup({
        library = {
          { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
      })
    end,
  },

  {
    name = "nvim-java",
    src = {
      { "https://github.com/JavaHello/spring-boot.nvim", version = "218c0c26c14d99feca778e4d13f5ec3e8b1b60f0" },
      "https://github.com/nvim-java/nvim-java",
    },
    needs = { "nui" },
    ft = "java",
    config = function()
      require("java").setup({
        jdk = { auto_install = false, version = "17" },
      })
      vim.lsp.config("jdtls", {})
      vim.lsp.enable("jdtls")
    end,
  },

  {
    name = "venv-selector",
    "https://github.com/linux-cultist/venv-selector.nvim",
    ft = "python",
    cmd = "VenvSelect",
    config = function()
      require("venv-selector").setup({
        options = {
          notify_user_on_venv_activation = true,
          override_notify = false,
          picker = "snacks",
          picker_options = {
            snacks = {
              layout = { fullscreen = false },
            },
          },
          statusline_func = {
            lualine = function()
              local venv_path = require("venv-selector").venv()
              if not venv_path or venv_path == "" then
                return ""
              end

              local venv_name = vim.fn.fnamemodify(venv_path, ":t")
              if not venv_name then
                return ""
              end

              return "🐍 " .. venv_name
            end,
          },
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function(ev)
          vim.keymap.set(
            "n",
            "<leader>cv",
            "<cmd>VenvSelect<cr>",
            { buffer = ev.buf, desc = "Select VirtualEnv", silent = true }
          )
        end,
      })
    end,
  },

  {
    name = "gitsigns",
    "https://github.com/lewis6991/gitsigns.nvim",
    on = "file",
    enabled = function()
      return vim.fn.executable("git") == 1
    end,
    config = function()
      require("gitsigns").setup({
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
          untracked = { text = "▎" },
        },
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 100,
          ignore_whitespace = false,
        },
        preview_config = {
          border = "rounded" or "none",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        on_attach = function(buffer)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
          end

          -- stylua: ignore start
          map("n", "]h", function() gs.nav_hunk("next") end, "Next Hunk")
          map("n", "[h", function() gs.nav_hunk("prev") end, "Prev Hunk")
          map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
          map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
          map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
          map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
          map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
          map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
          map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
          map("n", "<leader>gp", gs.preview_hunk_inline, "Preview Hunk Inline")
          map("n", "<leader>gb", function() require("utils.ui").blame_line() end, "Git Blame Line")
          map("n", "<leader>gd", gs.diffthis, "Diff This")
          map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
          map({ "n" }, "<leader>gl", "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle current line blame")
        end,
      })
    end,
  },

  {
    name = "dropbar",
    "https://github.com/Bekaboo/dropbar.nvim",
    on = "file",
    enabled = function()
      return vim.fn.has("nvim-0.11") == 1
    end,
    config = function()
      local remove_dropbar_color = function()
        -- 防止 dropbar 显示 cmp 的背景颜色
        local dropbar_groups = {
          "DropBarIconKindVariable",
          "DropBarIconKindClass",
          "DropBarIconKindConstructor",
          "DropBarIconKindDeclaration",
          "DropBarIconKindEnum",
          "DropBarIconKindEnumMember",
          "DropBarIconKindEvent",
          "DropBarIconKindField",
          "DropBarIconKindIdentifier",
          "DropBarIconKindInterface",
          "DropBarIconKindMethod",
          "DropBarIconKindModule",
          "DropBarIconKindPackage",
          "DropBarIconKindProperty",
          "DropBarIconKindReference",
          "DropBarIconKindStruct",
          "DropBarIconKindTypeParameter",
          "DropBarIconKindType",
          "DropBarIconKindUnit",
          "DropBarKindVariable",
          "DropBarKindIdentifier",
        }
        for _, v in pairs(dropbar_groups) do
          vim.api.nvim_set_hl(0, v, { link = "" })
        end
        vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE" })
      end

      require("dropbar").setup({
        bar = {
          enable = function(buf, win, _)
            buf = vim._resolve_bufnr(buf)
            if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_win_is_valid(win) then
              return false
            end

            if
              not vim.api.nvim_buf_is_valid(buf)
              or not vim.api.nvim_win_is_valid(win)
              or vim.fn.win_gettype(win) ~= ""
              or vim.wo[win].winbar ~= ""
              or vim.bo[buf].ft == "help"
              or vim.bo[buf].ft == "neo-tree"
            then
              return false
            end

            local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf))
            if stat and stat.size > 1024 * 1024 then
              return false
            end

            return vim.bo[buf].bt == "terminal"
              or vim.bo[buf].ft == "markdown"
              or pcall(vim.treesitter.get_parser, buf)
              or not vim.tbl_isempty(vim.lsp.get_clients({
                bufnr = buf,
                method = "textDocument/documentSymbol",
              }))
          end,
        },
      })

      remove_dropbar_color()
    end,
  },
}
