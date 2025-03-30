return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "proto" } },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "protols" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        protols = {
          -- Optional: add any bufls‑specific settings here
          settings = {
            -- example: customize logging level or other settings as per bufls docs
          },
        },
      },
    },
  },
}
