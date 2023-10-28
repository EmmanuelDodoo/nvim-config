function ColorMePlease(color)
--     color = color or "tokyonight-moon"
    color = color or "nightfly"
    vim.cmd(' colorscheme ' .. color)

--     vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMePlease()
