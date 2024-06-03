-- treesitter-parser-norg cannot be installed, there're some compiling errors, ignore norg pulgins for now
return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {
    -- 问题记录：
    -- 1. 安装时无法编译 treesitter-norg：经排查问题为gcc版本问题，通过如下方式解决（详见：https://github.com/nvim-neorg/tree-sitter-norg/issues/7#issuecomment-1538766238）：
    --    brew install gcc@12
    --    CC="/usr/local/Cellar/gcc@12/12.3.0/bin/gcc-12" nvim -c "TSInstallSync norg"
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    lazy = false,
    version = "*",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/org",
              },
              default_workspace = "notes",
            },
          },
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
          ["core.integrations.nvim-cmp"] = {},
        },
      })

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = { "nvim-neorg/neorg" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "neorg" })
    end,
  },
}
