local vim = vim
local api = vim.api
local M = {}

-- Storage path
M.path = vim.fn.stdpath("data") .. '/notes/'

-- Create path if it doesn't exist
vim.fn.mkdir(M.path, "p")

local function Open_Float(title)
    local buf = api.nvim_create_buf(false, false)

    local width = 50
    local height = 25

    local ui = api.nvim_list_uis()[1]

    local opts = {
        relative = 'editor',
        width = width,
        height = height,
        row = (ui.height / 2) - (height / 2),
        col = (ui.width / 2) - (width / 2),
        anchor = 'NW',
        style = 'minimal',
        border = 'double',
        title = title,
        title_pos = 'center'
    }

    return api.nvim_open_win(buf, true, opts)
end


function M.open()
    local curr_project = vim.fn.getcwd()

    local filename = curr_project:gsub("/", '_') .. '_notes.txt'

    local note_path = M.path .. filename

    local title = vim.fn.fnamemodify(curr_project, ":t") .. " Notes"

    local _ = Open_Float(title)

    vim.cmd('e ' .. note_path)
end

vim.keymap.set("n", "<leader>n", M.open, { desc = "Open the notes for this project" })

return M
