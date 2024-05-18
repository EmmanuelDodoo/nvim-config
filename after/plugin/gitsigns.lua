local vim = vim
local signs = require("gitsigns")

signs.setup {
    signs                        = {
        add          = { text = '+' },
        change       = { text = 'δ' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir                 = {
        follow_files = true
    },
    attach_to_untracked          = true,
    current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority                = 6,
    update_debounce              = 100,
    status_formatter             = nil,   -- Use default
    max_file_length              = 40000, -- Disable if file is longer than this (in lines)
    preview_config               = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    yadm                         = {
        enable = false
    },

    on_attach                    = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end
        -- Actions
        map("n", "<leader>gdf", gs.diffthis, { desc = "Git diff" })
        map('n', '<leader>ghs', gs.stage_hunk, { desc = "Git Stage hunk" })
        map('n', '<leader>ghv', gs.preview_hunk, { desc = "Git view hunk" })
        map('n', '<leader>gbs', gs.stage_buffer, { desc = "Git Stage Buffer" })
        map('n', '<leader>ghr', gs.reset_hunk, { desc = "Git Reset hunk" })
        map('n', '<leader>gbr', gs.reset_buffer, { desc = "Git Reset Buffer" })
        map('n', '<leader>ghn', function()
            gs.nav_hunk("next")
        end, { desc = "Git Next hunk" })
        map('n', '<leader>ghp', function()
            gs.nav_hunk("prev")
        end, { desc = "Git Previous hunk" })
        map('n', '<leader>ghu', gs.undo_stage_hunk, { desc = "Git undo last stage hunk" })
        map('v', '<leader>gsh', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
        map('v', '<leader>grh', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
    end

}
