return {
  "nvim-java/nvim-java",
  ft = { "java" },
  config = function()
    require("java").setup({
      jdtls = {
        version = "v1.46.1",
      },
      jdk = { auto_install = false },
    })
  end,
}
