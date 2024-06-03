local map = vim.keymap.set

map({ "n" }, "<leader>tf", "<cmd>GoTestFunc<CR>", { desc = "Test Func" })
map({ "n" }, "<leader>tF", "<cmd>GoTestFunc -s<CR>", { desc = "Test Func Selective" })
map({ "n" }, "<leader>ta", "<cmd>GoAddTest<CR>", { desc = "Add Test Func" })
map({ "n" }, "<leader>at", "<cmd>GoAddTag<CR>", { desc = "Add Tag" })
map({ "n" }, "<leader>as", "<cmd>GoFillStruct<CR>", { desc = "Fill Struct" })
map({ "n" }, "<leader>ac", "<cmd>GoFillSwitch<CR>", { desc = "Fill Switch" })
map({ "n" }, "<leader>ga", "<cmd>GoAlt<CR>", { desc = "Go Alternatives" })
map({ "n" }, "<leader>gv", "<cmd>GoAltV<CR>", { desc = "Go Alternatives Vsplit" })
map({ "n" }, "<leader>dT", "<cmd>lua require('dap-go').debug_test()<CR>", { desc = "Go Alternatives Vsplit" })
