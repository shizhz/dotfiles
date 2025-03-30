return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- 自定义provider，详见：https://github.com/yetone/avante.nvim/wiki/Custom-providers#openai-compatible-providers
      -- 代码路径见：avante.config.lua
      -- 这里使用硅基的接口，因此provider必须是 deepseek-ai
      provider = "deepseek-ai",
      vendors = {
        ["deepseek-ai"] = {
          __inherited_from = "openai",
          api_key_name = "SILICON_API_KEY",
          endpoint = "https://api.siliconflow.cn/v1/",
          -- model = "deepseek-ai/DeepSeek-R1",
          model = "Qwen/Qwen2.5-Coder-32B-Instruct",
          timeout = 30000, -- timeout in milliseconds
          temperature = 0, -- adjust if needed
          max_tokens = 4096,
          disable_tools = true,
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
