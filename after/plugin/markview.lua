local presets = require("markview.presets");
local view = require("markview");

view.setup({
    markdown = {
        headings = presets.headings.marker
    },
    preview = {
        icon_provider = "devicons"
    }
});

vim.keymap.set("n", "<leader>mvt", function()
    vim.cmd("Markview toggle")
end, { desc = "[m]ark[v]iew [t]oggle for current buffer" })
