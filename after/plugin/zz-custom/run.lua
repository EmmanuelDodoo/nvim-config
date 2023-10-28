-- This is for running things like build commands without having to
-- open a terminal and run from there

function Run(cmd)
    if cmd and cmd ~= "" then
        print(vim.fn.system(cmd))
    else
        print("No or empty command provided")
    end
end
