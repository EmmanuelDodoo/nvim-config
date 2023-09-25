local comment_chars = {
    default = "//",
    python = "#",
    lua = "--",
    ocaml = "(*",
}

local ending = {
    default = "",
    ocaml = "*)"
    -- lua = "--"
}

function SingleLineComment(line_number, filetype)
    local filetype = filetype or vim.bo.filetype
    local cmt_char = comment_chars[filetype] or comment_chars["default"]
    local ending_char = ending[filetype] or ending["default"]

    local current_line = line_number or vim.fn.line(".")
    local current_text = vim.fn.getline(current_line)

    local starting_index = vim.fn.match(current_text, "[^ \t]")

    -- Comment out text
    if current_text:sub(starting_index + 1, starting_index + #cmt_char) ~= cmt_char then
        if ending_char then
            local commented = cmt_char .. " " .. current_text .. " " .. ending_char
            vim.fn.setline(current_line, commented)
        else
            local commented = cmt_char .. " " .. current_text
            vim.fn.setline(current_line, commented)
        end

        -- Remove comments
    elseif current_text:sub(starting_index + 1, starting_index + #cmt_char) == cmt_char then
        if ending[filetype] then
            -- Lua includes the end of the range. The extra offset is for the whitespace
            local removed = current_text:sub(0, starting_index) ..
                current_text:sub(starting_index + #cmt_char + 2, - #ending_char - 2)
            vim.fn.setline(current_line, removed)
        else
            -- Lua includes the end of the range. The extra offset is for the whitespace
            -- The line below is for dealing with trailing whitespace after uncommenting from
            -- not the beginning of the line
            local end_offset = starting_index == 0 and -2 or -1
            local removed = current_text:sub(0, starting_index) ..
                current_text:sub(starting_index + #cmt_char + 2, end_offset)
            vim.fn.setline(current_line, removed)
        end
    end
end

function MultiLineComment()
    local filetype = vim.bo.filetype
    local start_line = vim.fn.getpos("v")[2]
    local end_line = vim.fn.getcurpos("'>")[2]

    if start_line > end_line then
        local temp = start_line
        start_line = end_line
        end_line = temp
    end


    for line = start_line, end_line do
        SingleLineComment(line, filetype)
    end
end

-- MultiLineComment()

-- Bindings
vim.keymap.set("n", "<leader>c", SingleLineComment, { desc = "[c]omment/remove comment from a single line" })
vim.keymap.set("v", "<leader>c", MultiLineComment, { desc = "[c]omment/remove comment from multiple selected lines" })
