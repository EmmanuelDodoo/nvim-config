-- This is for running things like build commands without having to
-- open a terminal and run from there

function Run(cmd)
    local cmd = cmd or vim.g.builder
    if cmd and cmd ~= "" then
        vim.cmd("w")
        print(vim.fn.system(cmd))
    else
        print("No or empty command provided")
    end
end


vim.keymap.set("n", "<leader>r", [[:lua Run() <CR>]], {desc = "[r]un the build command for this project. Use vim.g.builder to set the command. Saves the current buffer"})

