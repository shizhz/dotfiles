return {
  -- { "ellisonleao/gruvbox.nvim" },
  {
    "navarasu/onedark.nvim",
    opts = {
      style = "deep",
      highlights = {
        -- Java的Semantic Token高亮配置将keyword, type, modifier等Token全都标记成了黄色，导致整个文件看起来一片黄，这里将其改为紫色，与treesitter的配色一致
        -- 详细配置可参考onedard的highlight.lua文件的配置
        -- 更多参考信息：https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316
        ["@lsp.type.modifier.java"] = { fg = "#c75ae8" },
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
  -- {
  --   "LukasPietzschmann/telescope-tabs",
  --   config = function()
  --     require("telescope").load_extension("telescope-tabs")
  --     require("telescope-tabs").setup({
  --       -- Your custom config :^)
  --     })
  --   end,
  --   dependencies = { "nvim-telescope/telescope.nvim" },
  -- },
}
