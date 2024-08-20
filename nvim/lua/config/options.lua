-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
if vim.g.neovide then
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_cursor_trail_size = 0 -- I don't like the animation trail
end
vim.cmd("language en_US")
