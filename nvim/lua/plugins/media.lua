return {
  {
    "nvim-telescope/telescope-media-files.nvim",
    dependencies = { -- optional packages
      "nvim-telescope/telescope.nvim",
    },
    init = function()
      local ok, utils = pcall(require, "config.utils")
      if ok then
        utils.ensure_installed("chafa")
      end
    end,
    config = function(_, opts)
      local ok, telescope = pcall(require, "telescope")
      if ok then
        telescope.load_extension("media_files")
      end
    end,
    keys = {
      { "<leader>fm", "<cmd>Telescope media_files<CR>", desc = "Find media files" },
    },
  },
  -- {
  --   "vhyrro/luarocks.nvim",
  --   priority = 1001, -- this plugin needs to run before anything else
  --   opts = {
  --     rocks = { "magick" },
  --   },
  --   init = function()
  --     local ok, utils = pcall(require, "config.utils")
  --     if ok then
  --       utils.ensure_installed("imagemagick")
  --     end
  --   end,
  -- },
  -- {
  --   "3rd/image.nvim",
  --   dependencies = { "luarocks.nvim" },
  --   config = function()
  --     local ok, image = pcall(require, "image")
  --     if ok then
  --       image.setup()
  --     end
  --   end,
  -- },
}
