# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

# 问题记录
1. 升级jtdls后某些快捷键无法使用，包括gd, <leader>ca？
   jtdls显示不再支持textDocument/definition跟textDocument/codeAction两个方法，可以通过 $HOME/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/lsp/keymaps.lua 中的函数M.on_attach查看逻辑
