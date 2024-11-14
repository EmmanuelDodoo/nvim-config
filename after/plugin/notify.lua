local vim = vim
local notify = require("notify")

notify.setup({
    stages = "fade",
    timeout = 0
})

local function RecallPreviousNotification()
    local records = notify.history()
    local len = #records

    if len < 1 then
        notify.notify("No previous notification to show.")
    else
        local prev = records[len]
        local opts = { timeout = 2000, hide_from_history = true }
        notify.notify(prev.message, prev.level, opts)
    end
end

vim.keymap.set("n", "<leader>nd", function()
    notify.dismiss()
end, { desc = "Dismiss all currently displayed notify notifications" })

vim.keymap.set("n", "<leader>pn", RecallPreviousNotification, { desc = "Recall [p]revious [n]otification" })
