return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                -- typeCheckingMode = "off",
                reportUnknownMemberType = "none",
                reportDuplicateImport = true,
                reportAttributeAccessIssue = "none",
              },
            },
          },
        },
      },
    },
  },
}
