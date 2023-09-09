
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pd", vim.cmd.Ex)

-- Line(s) movement
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Copying and appending line below to current line, keeping cursor in place
vim.keymap.set("n", "J", "mzJ`z")

-- Keeps search terms in center of screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Effectively, delete the highlighted word and continuously
-- paste yanked word.
vim.keymap.set("x", "<leader>p", "\"_dp")

-- Deleting to void buff
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Yanks into system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>y", "\"+Y")
vim.keymap.set("v", "<leader>y", "\"+y")

-- Quick Switching between projects. Requires tmux.
-- tmux not available on Windows it seems
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end, {desc = '[f]ormat current buffer'})

-- Find and replace current word across file
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Open a terminal in side window
vim.keymap.set("n", "<leader>tm", function ()
   vim.cmd("vsp")
   vim.cmd("wincmd w")
   vim.cmd("term")
end, {desc="open a new window [t]er[m]inal to the right"})

-- Exit insert mode in the terminal
vim.keymap.set("t", '<Esc>', '<C-\\><C-n>')
