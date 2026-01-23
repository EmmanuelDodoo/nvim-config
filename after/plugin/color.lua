local vim = vim

function ColorMePlease(color)
    -- color = color or "nightfly"
    color = color or "moonfly"
    vim.cmd(' colorscheme ' .. color)
end

function Dark()
    ColorMePlease("moonfly")
end

ColorMePlease()
