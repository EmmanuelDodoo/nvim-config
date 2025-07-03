-- Runs the config file in a project
function Run_config(config)
    local config_file = config or ".nvim/config.lua"
    local path = vim.fn.getcwd() .. "/" .. config_file

    -- Check if the Lua config exists and run it
    if vim.fn.filereadable(path) == 1 then
        vim.cmd('luafile ' .. path)
    end
end

Run_config()

vim.keymap.set("n", "<C-c>", function()
    vim.cmd("edit .nvim/config.lua")
end)

-- Format Folding
if vim.g.format_fold then
    vim.keymap.set("n", "<leader>f", function()
        Format_fold()
    end)

    vim.keymap.set("n", "<leader>fs", function()
        Format_fold()
        vim.cmd("w")
    end)
end
