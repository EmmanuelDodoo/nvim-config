local vim = vim
local comment_chars = {
    default = "//",
    python = "#",
    lua = "--",
    ocaml = "(*",
    css = "/*",
    html = "<!--",
    sh = "#"
}

local ending = {
    default = "",
    ocaml = "*)",
    css = "*/",
    html = "-->",
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
        local prior_spacing = current_text:sub(1, starting_index)
        local remainder = current_text:sub(starting_index + 1)
        if ending_char ~= "" then
            --             local commented = cmt_char .. " " .. current_text .. " " .. ending_char
            local commented = prior_spacing .. cmt_char .. " " .. remainder .. " " .. ending_char
            vim.fn.setline(current_line, commented)
        else
            --             local commented = cmt_char .. " " .. current_text
            local commented = prior_spacing .. cmt_char .. " " .. remainder
            vim.fn.setline(current_line, commented)
        end

        -- Remove comments
    elseif current_text:sub(starting_index + 1, starting_index + #cmt_char) == cmt_char then
        -- Accounts for extra space after cmt_char
        local space_after = current_text:sub(starting_index + #cmt_char + 1, starting_index + #cmt_char + 1) == " "

        if ending[filetype] then
            -- Accounts for extra space before ending cmt_char
            local space_before = current_text:sub(- #ending_char - 1):sub(1, 1) == " "

            local beg_space_offset = 1
            local end_space_offset = 1

            if space_after then
                beg_space_offset = 2
            end

            if space_before then
                end_space_offset = 2
            end

            local removed = current_text:sub(0, starting_index) ..
                current_text:sub(starting_index + #cmt_char + beg_space_offset, - #ending_char - end_space_offset)
            vim.fn.setline(current_line, removed)
        else
            local space_offset = 1

            if space_after then
                space_offset = 2
            end

            local removed = current_text:sub(0, starting_index) ..
                current_text:sub(starting_index + #cmt_char + space_offset)
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
