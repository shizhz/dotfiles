-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local function augroup(name)
  return vim.api.nvim_create_augroup("shizhz_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("set_identation_size"),
  pattern = {
    "java",
    "go",
    "rs",
    -- "ts",
    -- "js",
    -- "tsx",
    -- "jsx",
    -- "scss",
    -- "html",
    -- "css",
    -- "javascript",
    -- "javascriptreact",
    -- "javascript.jsx",
    -- "typescript",
    -- "typescriptreact",
    -- "typescript.tsx",
    "json",
  },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

-- Fix <tab> problem: https://github.com/L3MON4D3/LuaSnip/issues/258
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*",
  callback = function()
    if
      ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
      and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require("luasnip").session.jump_active
    then
      require("luasnip").unlink_current()
    end
  end,
})
