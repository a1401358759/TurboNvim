return {
  "nvim-java/nvim-java",
  ft = "java",
  dependencies = {
    "nvim-java/lua-async-await",
    "nvim-java/nvim-java-core",
    "nvim-java/nvim-java-test",
    "nvim-java/nvim-java-dap",
    "MunifTanjim/nui.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
    {
      "williamboman/mason.nvim",
      opts = {
        registries = {
          "github:nvim-java/mason-registry",
          "github:mason-org/mason-registry",
        },
      },
    },
  },
  config = function()
    require("java").setup({
      --  list of file that exists in root of the project
      root_markers = {
        "settings.gradle",
        "settings.gradle.kts",
        "pom.xml",
        "build.gradle",
        "mvnw",
        "gradlew",
        "build.gradle",
        "build.gradle.kts",
        ".git",
      },

      -- load java test plugins
      java_test = {
        enable = true,
      },

      -- load java debugger plugins
      java_debug_adapter = {
        enable = true,
      },

      spring_boot_tools = {
        enable = true,
      },

      jdk = {
        -- install jdk using mason.nvim
        auto_install = true,
      },

      notifications = {
        -- enable 'Configuring DAP' & 'DAP configured' messages on start up
        dap = true,
      },

      -- We do multiple verifications to make sure things are in place to run this
      -- plugin
      verification = {
        -- nvim-java checks for the order of execution of following
        -- * require('java').setup()
        -- * require('lspconfig').jdtls.setup()
        -- IF they are not executed in the correct order, you will see a error
        -- notification.
        -- Set following to false to disable the notification if you know what you
        -- are doing
        invalid_order = true,

        -- nvim-java checks if the require('java').setup() is called multiple
        -- times.
        -- IF there are multiple setup calls are executed, an error will be shown
        -- Set following property value to false to disable the notification if
        -- you know what you are doing
        duplicate_setup_calls = true,

        -- nvim-java checks if nvim-java/mason-registry is added correctly to
        -- mason.nvim plugin.
        -- IF it's not registered correctly, an error will be thrown and nvim-java
        -- will stop setup
        invalid_mason_registry = true,
      },
    })
    require("lspconfig").jdtls.setup({})
  end,
}
