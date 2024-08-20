return {
  {
    -- override some keymaps, copied from LazyVim extras file, search for dap.lua
    "mfussenegger/nvim-dap",
    desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

    dependencies = {
      "rcarriga/nvim-dap-ui",
      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },

    -- stylua: ignore
    keys = {
      { "<leader>d5", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>d6", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>d7", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>d8", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>d9", function() require("dap").terminate()  end, desc = "Terminate" },
      { "<leader>d0", function() require'dap'.clear_breakpoints() end, desc = "Clear all break points" },
    },
  },
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
