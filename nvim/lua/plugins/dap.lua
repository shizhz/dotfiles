return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      {
        "folke/neodev.nvim",
        opts = {
          -- NOTE: ([nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)) 建议如下配置，但使用如下配置会导致打开lua配置时报错：undefined global variable 'vim'
          -- 暂时disable掉该配置
          library = { plugins = { "nvim-dap-ui" }, types = true },
        },
      },
    },
  },
}
