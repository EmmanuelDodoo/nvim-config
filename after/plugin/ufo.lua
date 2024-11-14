---@diagnostic disable: undefined-global
-- Folds
vim.opt.foldmethod = "expr"
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local prefix = ('+--  %d lines: '):format(endLnum - lnum)
    local suffix = " "
    local prefWidth = vim.fn.strdisplaywidth(prefix)
    local targetWidth = width - prefWidth
    local curWidth = 0

    table.insert(newVirtText, { prefix, 'Folded' })

    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, { chunkText, 'Folded' })
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            table.insert(newVirtText, { chunkText, 'Folded' })
            break
        end
        curWidth = curWidth + chunkWidth
    end

    if curWidth < targetWidth then
        suffix = suffix .. ('•'):rep(targetWidth - curWidth)
    end

    table.insert(newVirtText, { suffix, 'Folded' })
    return newVirtText
end

local ufo = require('ufo')

ufo.setup({
    fold_virt_text_handler = handler,
    provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
    end

})

-- Using ufo provider need remap `zR` and `zM`.
vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)
