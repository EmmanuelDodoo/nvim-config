local vim = vim

function WrapCurrentWord()
    -- Get the word under the cursor
    local word = vim.fn.expand("<cword>")
    -- Prompt the user for the characters to add before and after the word
    local before = vim.fn.input("Start: ")
    local after = vim.fn.input("End: ")
    -- Construct the new string with the specified characters
    local new_word = before .. word .. after
    -- Escape the current word and replace it with the new word
    vim.cmd("normal! ciw" .. new_word)
end

function WrapCurentSelection()
    -- Assumptions: This is a single line highlight with the current cursor
    -- position being the end of the highlight

    local before = vim.fn.input("Start: ")
    local after = vim.fn.input("End: ")

    -- Save the current register
    local save_a = vim.fn.getreg('a')
    -- Copy the selected text to register a
    vim.cmd('normal! "ay')
    -- Get the selected text
    local selected_text = vim.fn.getreg('a')
    -- Restore the register
    vim.fn.setreg('a', save_a)
    -- Construct the new string with the specified characters
    local new_text = before .. selected_text .. after
    -- Replace the selected text with the new string
    vim.cmd('normal! gv"ac' .. new_text)
end

vim.keymap.set("n", "<leader>w", WrapCurrentWord, { desc = "[w]rap the current word under the cursor" })
vim.keymap.set("v", "<leader>w", WrapCurentSelection, { desc = "[w]rap the selection under the cursor" })

