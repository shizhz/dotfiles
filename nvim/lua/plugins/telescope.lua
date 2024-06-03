-- TODO: Impl picker cycle functionality, refer to  https://gist.github.com/sublipri/b9ee91d24483840cc6325240e2c3e5e1
-- https://github.com/nvim-telescope/telescope.nvim/issues/576
-- https://github.com/nvim-telescope/telescope.nvim/issues/2160
return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        path_display = {
          "truncate",
          -- "shorten",
          -- "absolute",
        },
      },
    },
    -- keys = {
    --   {
    --     "<leader><space>",
    --     LazyVim.telescope("files", { path_display = { "truncate" } }),
    --     desc = "Find Files (Root Dir)",
    --   },
    --   { "<leader>ff", LazyVim.telescope("files", { path_display = { "truncate" } }), desc = "Find Files (Root Dir)" },
    --   {
    --     "<leader>fF",
    --     LazyVim.telescope("files", { cwd = false, path_display = { "truncate" } }),
    --     desc = "Find Files (cwd)",
    --   },
    --   {
    --     "<leader>fg",
    --     ":lua require('telescope.builtin').git_files{ path_display = { 'truncate' }}<CR>",
    --     desc = "Find Files (git-files)",
    --   },
    --   {
    --     "<leader>fr",
    --     ":lua require('telescope.builtin').oldfiles{ path_display = { 'truncate' }}<CR>",
    --     desc = "Recent",
    --   },
    --   {
    --     "<leader>fR",
    --     LazyVim.telescope("oldfiles", { cwd = vim.uv.cwd(), path_display = { "truncate" } }),
    --     desc = "Recent (cwd)",
    --   },
    --
    --   { "<leader>sg", LazyVim.telescope("live_grep", { path_display = { "truncate" } }), desc = "Grep (Root Dir)" },
    --   {
    --     "<leader>sG",
    --     LazyVim.telescope("live_grep", { cwd = false, path_display = { "truncate" } }),
    --     desc = "Grep (cwd)",
    --   },
    --   {
    --     "<leader>sw",
    --     LazyVim.telescope("grep_string", { word_match = "-w", path_display = { "truncate" } }),
    --     desc = "Word (Root Dir)",
    --   },
    --   {
    --     "<leader>sW",
    --     LazyVim.telescope("grep_string", { cwd = false, word_match = "-w", path_display = { "truncate" } }),
    --     desc = "Word (cwd)",
    --   },
    --   {
    --     "<leader>sw",
    --     LazyVim.telescope("grep_string"),
    --     { path_display = { "truncate" } },
    --     mode = "v",
    --     desc = "Selection (Root Dir)",
    --   },
    --   {
    --     "<leader>sW",
    --     LazyVim.telescope("grep_string", { cwd = false, path_display = { "truncate" } }),
    --     mode = "v",
    --     desc = "Selection (cwd)",
    --   },
    -- },
  },

  -- {
  --   "nvim-telescope/telescope-file-browser.nvim",
  --   dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  --   config = function()
  --     local ok, telescope = pcall(require, "telescope")
  --     if ok then
  --       telescope.load_extension("file_browser")
  --     end
  --   end,
  -- },
}
