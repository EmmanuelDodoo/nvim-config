local lualine = require("lualine")

lualine.setup {
    options = {
        icons_enabled = false,
        theme = 'nightfly',
        component_separators = { left = '|', right = '|' },
        section_separators = { left = ' >', right = '< ' },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
}
