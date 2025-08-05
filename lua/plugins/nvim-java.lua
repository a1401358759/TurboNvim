return {
  "nvim-java/nvim-java",
  ft = { "java" },
  config = function()
    require("java").setup({
      jdtls = {
        version = "v1.43.0",
      },
      jdk = { auto_install = false },
    })
    require("lspconfig").jdtls.setup({})
  end,
}
