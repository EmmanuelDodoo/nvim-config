local vim = vim

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pd", vim.cmd.Ex)

-- Save
vim.keymap.set("n", "<leader>s", vim.cmd.w, { desc = "[s]ave the current buffer" })
vim.keymap.set("n", "<leader>se", function()
    vim.cmd("w")
    vim.cmd("q")
end
, { desc = "[s]ave and [e]xit" })
vim.keymap.set("n", "<leader>ss", function()
    vim.cmd("w")
    vim.cmd("so")
end, { desc = "[s]ave and [s]ource current buffer" })


-- Redo
vim.keymap.set('n', "U", "<C-r>")
vim.keymap.set('v', "U", "<C-r>")

-- Format
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end, { desc = '[f]ormat current buffer' })
vim.keymap.set("n", "<leader>fs", function()
    vim.lsp.buf.format()
    vim.cmd("w")
end
, { desc = "[f]ormat and [s]ave the current buffer" })

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

-- Paste from system clipboard
vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>p", "\"+P")
vim.keymap.set("v", "<leader>p", "\"+p")

-- Quick Switching between projects. Requires tmux.
-- tmux not available on Windows it seems
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Find and replace current word across file
vim.keymap.set("n", "<leader>r", [[:let @/='\V\<' . escape(expand('<cword>'), '\') . '\>'<CR>:noh<CR>]],
    { desc = "[f]in[d] the word under the cursor" })

-- Search the current word under the cursor
vim.keymap.set("n", "<leader>fd", [[:let @/='\V\<' . escape(expand('<cword>'), '\') . '\>'<CR>:noh<CR>]],
    { desc = "[f]in[d] the word under the cursor" })

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Open a terminal in side window
vim.keymap.set("n", "<leader>tm", function()
    vim.cmd("vsp")
    vim.cmd("wincmd w")
    vim.cmd("term")
end, { desc = "open a new window [t]er[m]inal to the right" })

-- Exit insert mode in the terminal
vim.keymap.set("t", '<Esc>', '<C-\\><C-n>')

-- Close next window
vim.keymap.set("n", "<leader>cl", function()
    vim.cmd("wincmd w")
    vim.cmd("q")
end, { desc = "Close the next window" })

-- For marks
vim.keymap.set("n", "'", "`")
