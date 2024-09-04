-- This is for running things like build commands without having to
-- open a terminal and run from there
local vim = vim

function Run(cmd)
    local cmd = cmd or vim.g.builder

    if cmd and cmd ~= "" then
        local buf_is_modifiable = vim.api.nvim_get_option_value("modifiable", { buf = 0 })

        if buf_is_modifiable then
            vim.cmd("w")
        end

        vim.cmd("vsplit | wincmd L | terminal ")
        local command = ':call jobsend(b:terminal_job_id, "' .. cmd .. '\\n")'
        vim.cmd(command)
    else
        print("No or empty command provided")
    end
end

vim.keymap.set("n", "<leader>b", [[:lua Run() <CR>]],
    { desc = "[r]un the build command for this project. Use vim.g.builder to set the command. Saves the current buffer" })
