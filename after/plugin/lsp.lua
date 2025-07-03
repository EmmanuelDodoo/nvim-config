---@diagnostic disable: undefined-global
vim.opt.signcolumn = 'yes'
local lsp = require('lsp-zero')

require('mason').setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "ocamllsp",
        "pylsp",
        "ts_ls",
        "eslint"
    },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    }
})

local cmp = require('cmp')
local cmp_format = lsp.cmp_format()
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
    },
    mapping = cmp.mapping.preset.insert({
        -- Previous on completion list
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        -- Next on completion list
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        -- Accept completion
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        -- Start the completion
        ['<C-Space>'] = cmp.mapping.complete(),
        -- Scroll documentation window
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    }),
    formatting = cmp_format,
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function()
        local params = vim.lsp.util.make_position_params(0, "utf-8")
        vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, _, _)
            if err or not result then return end

            local location = result[1] or result
            local uri = location.uri or location.targetUri
            local target_file = vim.uri_to_fname(uri)
            local current_file = vim.api.nvim_buf_get_name(0)

            if target_file ~= current_file then
                vim.cmd("vsplit")
            end

            vim.lsp.util.show_document(location, "utf-8", { reuse_win = true, focus = true })
        end)
    end, opts)

    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    -- Move to next error
    vim.keymap.set("n", "<leader>en", function()
        vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, { desc = "Go to the next Error " })

    -- Move to previous error
    vim.keymap.set("n", "<leader>ep", function()
        vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, { desc = "Go to previous Error" })

    -- Turn on inlay hinting
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
end)

lsp.setup({
    lsp_attach = on_attach,
    capabilities = require("cmp_nvim_lsp").default_capabilities()
})
