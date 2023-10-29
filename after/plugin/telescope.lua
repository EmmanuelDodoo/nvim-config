---@diagnostic disable: undefined-global
require("telescope").setup {
    defaults = {
        file_ignore_patterns = { "^node_modules/*", "^.git/*", "^_build/", "^target/" }
    }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', function()
    builtin.find_files({ hidden = true })
end, { desc = "[f]ind a [f]le. Hidden files/directories are also searched" })
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set("n", "<leader>lg", builtin.live_grep, {})
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
