---@diagnostic disable: undefined-global
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "folke/which-key.nvim",
    { "folke/neoconf.nvim",         cmd = "Neoconf" },
    "folke/neodev.nvim",

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- Tree sitter
    {
        "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"
    },


    -- Undo tree
    { 'mbbill/undotree' },

    -- Telescope icons
    { 'nvim-tree/nvim-web-devicons' },

    -- Theme
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },

    -- Git related plugins
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-rhubarb' },

    -- Harpoon
    { 'ThePrimeagen/harpoon' },

    -- LSP Zero
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {
                'neovim/nvim-lspconfig',
            },                                       -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    },

    -- Indentation guides
    {
        -- Add indentation guides even on blank Lines
        "lukas-reineke/indent-blankline.nvim",
        -- Enable 'Lukas-reineke/indent-bLanRLine. nvim
        -- See :help indent_bLankLine. txt'

        opts = {
            char = "|",
            show_traiting_blankline_indent = false,
        },
    },

    -- Auto pairs
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function

    }
})