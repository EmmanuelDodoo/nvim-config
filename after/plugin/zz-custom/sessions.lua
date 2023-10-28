function Sessions(file)
    local file = file or "sessions.vim"
    local file = vim.fn.getcwd() .. "/.nvim/" .. file

    if vim.fn.filereadable(file) == 1 then
        vim.cmd("source " .. file)
    end

    vim.cmd("autocmd VimLeavePre * mksession! " .. file)
end
