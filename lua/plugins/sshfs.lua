return {
  "nosduco/remote-sshfs.nvim",
  event = "TurboLoad",
  dependencies = { "nvim-telescope/telescope.nvim" },
  opts = {
    connections = {
      ssh_configs = { -- which ssh configs to parse for hosts list
        vim.fn.expand("$HOME") .. "/.ssh/config",
        "/etc/ssh/ssh_config",
      },
      -- NOTE: Can define ssh_configs similarly to include all configs in a folder
      -- ssh_configs = vim.split(vim.fn.globpath(vim.fn.expand "$HOME" .. "/.ssh/configs", "*"), "\n")
      sshfs_args = { -- arguments to pass to the sshfs command
        "-o reconnect",
        "-o ConnectTimeout=5",
      },
    },
    handlers = {
      on_connect = {
        change_dir = true, -- when connected change vim working directory to mount point
      },
      on_disconnect = {
        clean_mount_folders = true, -- remove mount point folder on disconnect/unmount
      },
      on_edit = {}, -- not yet implemented
    },
  },
  config = function(_, opts)
    local api = require("remote-sshfs.api")
    vim.keymap.set("n", "<leader>rc", api.connect, { desc = "Connect to remote host" })
    vim.keymap.set("n", "<leader>rd", api.disconnect, { desc = "Disconnect from remote host" })
    vim.keymap.set("n", "<leader>re", api.edit, { desc = "Edit ssh config" })

    require("remote-sshfs").setup(opts)
  end,
}
