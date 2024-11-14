---@diagnostic disable: undefined-global
function Dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. Dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

function Format_fold()
    -- Get UFO instance
    local ufo = require('ufo')

    -- Store which folds are open
    local closed_folds = {}
    local bufnr = vim.api.nvim_get_current_buf()

    -- Get all folds in the buffer
    local folds = ufo.getFolds(bufnr, 'treesitter')

    for _, fold in ipairs(folds) do
        local start_line = fold.startLine + 1
        if vim.fn.foldclosed(start_line) == start_line then
            table.insert(closed_folds, start_line)
        end
    end

    -- Do the formatting
    vim.lsp.buf.format()

    -- Wait a bit for UFO to create the folds
    vim.defer_fn(function()
        -- Open the folds that were previously open
        for _, line in ipairs(closed_folds) do
            -- local ok, _ = pcall(vim.cmd, string.format('%dfoldc', line))
            pcall(vim.cmd, string.format('%dfoldc', line))
        end
    end, 500)
end
