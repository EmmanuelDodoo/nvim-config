vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>gac", function()
    local buf_path = vim.fn.expand("%")
    vim.cmd("Git add " .. buf_path)
end, { desc = "[g]it [a]dd the [c]urrent buffer" })

vim.keymap.set("n", "<leader>gaa", function()
    vim.cmd("Git add .")
end, { desc = "[g]it [a]dd [a]ll " })

vim.keymap.set("n", "<leader>gc", function()
    vim.cmd("Git commit")
end, { desc = "[g]it commit" })
