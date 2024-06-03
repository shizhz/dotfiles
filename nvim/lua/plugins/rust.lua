return {
  -- 解决rustaceanvim与nvim-lspconfig都配置lsp的问题，详见:h rustaceanvim.mason
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        rust_analyzer = function()
          return true
        end,
      },
    },
  },
}
