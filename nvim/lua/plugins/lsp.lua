return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = {
        "gr",
        ":lua require('telescope.builtin').lsp_references{ path_display = { 'truncate' }}<CR>",
        desc = "References",
      }
      keys[#keys + 1] = {
        "gI",
        ":lua require('telescope.builtin').lsp_implementations{ reuse_win = true,  path_display = { 'truncate' }}<CR>",
        desc = "Implementations",
      }
      keys[#keys + 1] = {
        "<leader>lo",
        ":lua require('telescope.builtin').lsp_outgoing_calls{ path_display = { 'truncate' }}<CR>",
        desc = "Ougoing Calls",
      }
      keys[#keys + 1] = {
        "<leader>li",
        ":lua require('telescope.builtin').lsp_incoming_calls{ path_display = { 'truncate' }}<CR>",
        desc = "Incoming Calls",
      }
    end,
  },
}
