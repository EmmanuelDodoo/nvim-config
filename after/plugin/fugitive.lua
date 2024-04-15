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

vim.keymap.set("n", "<leader>gca", function()
    vim.cmd("Git commit --amend")
end, { desc = "[g]it [c]ommit [a]mend" })

vim.keymap.set("n", "<leader>gps", function()
    vim.cmd("Git push")
end, { desc = "[g]it [p]u[s]h" })

vim.keymap.set("n", "<leader>gpl", function()
    vim.cmd("Git pull")
end, { desc = "[g]it [p]ul[l]" })

vim.keymap.set("n", "<leader>gra", function()
    vim.cmd("Git reset")
end, { desc = "[g]it [r]eset [a]ll" })
