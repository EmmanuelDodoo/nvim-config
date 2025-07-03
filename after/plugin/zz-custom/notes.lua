local vim = vim
local dir_sep = package.config:sub(1, 1)

local M = {}

-- Storage path
M.path = vim.fn.stdpath("data") .. dir_sep .. 'notes' .. dir_sep

-- Create path if it doesn't exist
vim.fn.mkdir(M.path, "p")

local function create_float(title)
    local popup = require("plenary").popup
    local width = 60
    local height = 25

    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    local bufnr = vim.api.nvim_create_buf(false, false)

    local win_id, win = popup.create(bufnr, {
        title = title,
        highlight = "HarpoonWindow",
        minwidth = width,
        minheight = height,
        borderchars = borderchars,
        focusable = true,
        wrap = true,
    })

    vim.api.nvim_win_set_option(
        win.border.win_id,
        "winhl",
        "Normal:Folded"
    )

    return {
        bufn = bufnr,
        win_id = win_id,
    }
end

function M.open()
    local is_windows = dir_sep == '\\'
    local curr_project = vim.fn.getcwd()

    local filename = curr_project:gsub(dir_sep, '_') .. '_notes.txt'

    if is_windows then
        filename = filename:sub(3)
    end

    local note_path = M.path .. filename
    local content = {}
    if vim.loop.fs_stat(note_path) ~= nil then
        content = vim.fn.readfile(note_path)
    end

    local title = vim.fn.fnamemodify(curr_project, ":t"):gsub("^%l", string.upper) .. " Notes"


    local float = create_float(title)
    local bufn = float.bufn
    local win_id = float.win_id

    vim.api.nvim_win_set_option(win_id, "number", true)
    vim.api.nvim_win_set_option(win_id, "relativenumber", true)
    vim.api.nvim_buf_set_name(bufn, "notes-buffer")
    vim.api.nvim_buf_set_text(bufn, 0, 0, -1, -1, content)
    vim.api.nvim_win_set_cursor(win_id, { 1, 1 })
    vim.api.nvim_buf_set_option(bufn, 'modified', false)
    vim.api.nvim_buf_set_option(bufn, 'textwidth', 55)
    vim.api.nvim_buf_set_option(bufn, "filetype", "text")
    vim.api.nvim_buf_set_option(bufn, "buftype", "acwrite")
    vim.api.nvim_buf_set_option(bufn, "bufhidden", "delete")

    vim.api.nvim_create_autocmd("BufWriteCmd", {
        buffer = bufn,
        callback = function()
            local is_modified = vim.api.nvim_buf_get_option(bufn, 'modified')
            if is_modified then
                local notes = vim.api.nvim_buf_get_text(bufn, 0, 0, -1, -1, {})
                local success = vim.fn.writefile(notes, note_path)

                if success == 0 then
                    -- Mark buffer as not modified after successful write
                    vim.api.nvim_buf_set_option(bufn, 'modified', false)
                else
                    print("Save failed")
                end
            end
        end,
    })

    vim.keymap.set("n", "q", function()
        vim.cmd("wq")
    end, { silent = true, buffer = bufn })
end

vim.keymap.set("n", "<leader>n", M.open, { desc = "Open the [n]otes for this project" })

return M
