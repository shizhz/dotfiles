local map = vim.keymap.set

map({ "n" }, "<leader>tf", "<cmd>RustTest<CR>", { desc = "Test Func" })
map({ "n" }, "<leader>tF", "<cmd>RustLsp testables<CR>", { desc = "Test Func Selectively" })
map({ "n" }, "<leader>r", "<cmd>RustLsp run<CR>", { desc = "Run Func Selectively" })
map({ "n" }, "<leader>cj", "<cmd>RustLsp joinLines<CR>", { desc = "Join Lines" })
map({ "n" }, "<C-S-j>", "<cmd>RustLsp moveItem down<CR>", { desc = "Move item down" })
map({ "n" }, "<C-S-k>", "<cmd>RustLsp moveItem up<CR>", { desc = "Move item up" })
