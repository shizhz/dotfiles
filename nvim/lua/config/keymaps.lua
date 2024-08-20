-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local del = vim.keymap.del

-- Unmap default mappings in LazyVim
--
-- Use <leader>l as prefix for lsp mappings
del("n", "<leader>l")
-- Use <C-\> to open floating terminal
-- del("n", "<C-/>")
-- Use <leader>bn instead
del("n", "<leader>fn")
-- Use <leader><tab>p instead
del("n", "<leader><tab>[")
-- Use <leader><tab>n instead
del("n", "<leader><tab>]")

-- windows
map("n", "<leader>wq", "<C-w>q", { desc = "Quit window" })
map("n", "<leader>wd", "<cmd>lua require('config.utils').windo()<CR>", { desc = "Windo" })

map("n", "<leader><tab>n", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>p", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Motions
map("n", "<C-d>", "<C-d>zz<CR>", { desc = "Always put the current line in the middle of screen" })
map("n", "<C-u>", "<C-u>zz<CR>", { desc = "Always put the current line in the middle of screen" })
map("n", "n", "nzzzv", { desc = "Put the cursor in the middle" })
map("n", "N", "Nzzzv", { desc = "Put the cursor in the middle" })
map("n", "*", "*zz")
map("n", "*", "*zz")
map("n", "#", "#zz")
map("n", "g*", "g*zz")
map("n", "g#", "g#zz")
map("n", "gX", "<cmd>UrlView<CR>", { desc = "Open urls in current buffer selectively" })
map("n", "<leader>gb", "<cmd>G blame<CR>", { desc = "Git blame" })
-- map("n", "<C-a>", "gg<S-v>G", { desc = "Select All" })

-- Keep the register clean
-- vim.keymap.set("n", "x", '"_x')
map("n", "c", '"_c')
map("n", "dd", function()
  if vim.fn.getline(".") == "" then
    return '"_dd'
  end
  return "dd"
end, { expr = true })

-- Line editing
map("n", "J", "mzJ`z")
-- map("v", "<", "<gv")
-- map("v", ">", ">gv")
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move up" })
map("i", "<S-CR>", "<ESC>o", { desc = "Start a new line" })
-- Replace the word under cursor
map("n", "<C-r>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- 1. quit visual mode; 2. yank the word under cursor to register a; 3. resume visual block; 4. enter command line mode and complete the replace command
-- otherwise <C-r><C-w>will always get the first word of the current line, which is not what I want
map("v", "<C-r>", [[<ESC>"ayiwgv:s/\<<C-r>a\>/<C-r>a/gI<Left><Left><Left>]])

map("x", "p", [["_dP]])
map({ "n", "v" }, "<leader>dd", [["_d]], { desc = "Throw to blackhole" })

map("i", "<C-b>", "<Left>", { desc = "Move Left" })
map("i", "<C-f>", "<Right>", { desc = "Move Right" })
map("i", "<C-a>", "<ESC>^i", { desc = "Move Beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Move End of line" })
map("i", "<C-h>", "<Left>", { desc = "Move Left" })
map("i", "<C-l>", "<Right>", { desc = "Move Right" })
map("i", "<C-j>", "<Down>", { desc = "Move Down" })
map("i", "<C-k>", "<Up>", { desc = "Move Up" })
map("i", "<C-s>", "<ESC>:w<CR>a", { desc = "Save File in insert mode" })

-- Buffers
map("n", "<leader>bnn", "<cmd>enew<CR>", { desc = "New Buffer" })
map("n", "<leader>bnv", "<cmd>vsplit enew<CR>", { desc = "New Buffer Vsplit" })
map("n", "<leader>bns", "<cmd>split enew<CR>", { desc = "New Buffer Split" })

-- For command line mode
-- Tips: use <C-f> to enter a normal buffer and <C-c> to quit
map("c", "<C-a>", "<Home>", { desc = "Goto begin of command line" })
map("c", "<C-b>", "<Left>", { desc = "Move left in command line" })
map("c", "<C-h>", "<Left>", { desc = "Move right in command line" })
map("c", "<C-l>", "<Right>", { desc = "Move right in command line" })

-- Align
-- xmap ga <Plug>(EasyAlign)
map("x", "ga", "<Plug>(EasyAlign)", { desc = "Align Text" })

-- Customize
map({ "v", "n" }, "<leader>pp", "<cmd>lua require('config.utils').smart_prettier()<CR>", { desc = "Prettier content" })
map({ "n" }, "<leader>pj", ":%!jq<CR><cmd>set ft=json<CR>", { desc = "Prettier json" })
map(
  "n",
  "<leader>pd",
  "<cmd>vsplit enew<CR>p:windo diffthis<CR>",
  { desc = "Diff current buffer with content in clipboard" }
)
map({ "v" }, "<leader>pj", ":'<,'>!jq<CR><cmd>set ft=json<CR>", { desc = "Prettier json" })
map({ "n" }, "<leader>ps", ":%!sleek<CR><cmd>set ft=sql<CR>", { desc = "Prettier SQL" })
map({ "v" }, "<leader>ps", ":'<,'>!sleek<CR><cmd>set ft=sql<CR>", { desc = "Prettier SQL" })

-- Diff
map("n", "do", "<cmd>windo diffthis<CR>", { desc = "Diff On" })
map("n", "dx", "<cmd>windo diffoff<CR>", { desc = "Diff Off" })

map(
  "n",
  "<leader>li",
  "<cmd>lua require('config.utils').show_lsp_capabilities()<CR>",
  { desc = "Show lsp capabilities" }
)
