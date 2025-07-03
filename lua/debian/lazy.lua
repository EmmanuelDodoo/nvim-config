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

    -- Themes
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    { "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false, priority = 1000 },

    {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    },

    { "bluz71/vim-moonfly-colors",  name = "moonfly",  lazy = false, priority = 1000 },

    -- Git related plugins
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-rhubarb' },
    { 'lewis6991/gitsigns.nvim' },

    -- Harpoon
    { 'ThePrimeagen/harpoon' },

    -- LSP Zero
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        dependencies = {
            -- LSP Support
            {
                'neovim/nvim-lspconfig',
            },                                       -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            { 'kevinhwang91/nvim-ufo',            dependencies = 'kevinhwang91/promise-async' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    },

    -- Auto pairs
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function

    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    },

    -- Markview
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        preview = {
            icon_provider = "devicons", -- "mini" or "devicons"
        }

    },

    { 'echasnovski/mini.icons', version = false },

})
