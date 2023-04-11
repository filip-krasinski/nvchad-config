local plugins = {
 {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "jdtls" },
    },
  },
  { "mfussenegger/nvim-jdtls", event = "BufRead" },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        width = 40
      },
      renderer = {
        group_empty = true
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
}
return plugins
