-- https://github.com/microsoft/pyright

local util = require("lspconfig.util")

local root_files = {
  ".git",
  ".gitignore",
}

local ignore_diagnostic_message = {
  '"self" is not accessed',
  '"args" is not accessed',
  '"kwargs" is not accessed',
  '"cls" is not accessed',
}

local filter_publish_diagnostics = function(a, params, client_info, extra_message, config)
  ---@diagnostic disable-next-line: unused-local
  local client = vim.lsp.get_client_by_id(client_info.client_id)

  if extra_message.ignore_diagnostic_message then
    local new_index = 1

    for _, diagnostic in ipairs(params.diagnostics) do
      if not vim.tbl_contains(extra_message.ignore_diagnostic_message, diagnostic.message) then
        params.diagnostics[new_index] = diagnostic
        new_index = new_index + 1
      end
    end

    for i = new_index, #params.diagnostics do
      params.diagnostics[i] = nil
    end
  end

  ---@diagnostic disable-next-line: redundant-parameter
  vim.lsp.diagnostic.on_publish_diagnostics(a, params, client_info, extra_message, config)
end

return {
  filetypes = { "python" },
  single_file_support = true,
  cmd = { "pyright-langserver", "--stdio" },
  ---@diagnostic disable-next-line: deprecated
  root_dir = util.root_pattern(unpack(root_files)),
  handlers = {
    -- If you want to disable pyright's diagnostic prompt, open the code below
    -- ["textDocument/publishDiagnostics"] = function(...) end,
    -- If you want to disable pyright from diagnosing unused parameters, open the function below
    ["textDocument/publishDiagnostics"] = vim.lsp.with(filter_publish_diagnostics, {
      ignore_diagnostic_message = ignore_diagnostic_message,
    }),
  },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off", -- off, basic, strict
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        autoImportCompletions = false,
        diagnosticMode = "openFilesOnly",
        -- https://github.com/microsoft/pyright/blob/main/docs/configuration.md#type-check-diagnostics-settings
        diagnosticSeverityOverrides = {
          strictListInference = true,
          strictDictionaryInference = true,
          strictSetInference = true,
          reportUnusedImport = "warning",
          reportUnusedClass = "warning",
          reportUnusedFunction = "warning",
          reportUnusedVariable = "warning",
          reportUnusedCoroutine = "warning",
          reportDuplicateImport = "warning",
          reportPrivateUsage = "none",
          reportUnusedExpression = "warning",
          reportConstantRedefinition = "error",
          reportUndefinedVariable = "error",
          reportAssertAlwaysTrue = "error",
          reportMissingTypeStubs = "none",
          reportIncompleteStub = "none",
          reportInvalidStubStatement = "none",
          reportMissingModuleSource = "none",
          reportMissingImports = "none",
          reportIncompatibleMethodOverride = "none",
        },
      },
    },
  },
}
