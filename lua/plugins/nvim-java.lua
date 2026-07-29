return {
  "nvim-java/nvim-java",
  ft = { "java" },
  config = function()
    require("java").setup({
      jdk = { auto_install = false, version = "17" },
    })
    vim.lsp.config("jdtls", {})
    vim.lsp.enable("jdtls")
  end,
}
