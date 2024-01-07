local vim = vim

function ColorMePlease(color)
    color = color or "nightfly"
    vim.cmd(' colorscheme ' .. color)
end

function Dark()
    ColorMePlease("moonfly")
end

ColorMePlease()
