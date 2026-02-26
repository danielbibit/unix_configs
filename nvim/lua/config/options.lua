-- Disable netrw (built-in file explorer)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt
opt.encoding = "utf-8"
opt.signcolumn = "yes"
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.showcmd = true
opt.showmatch = true
opt.ignorecase = true
opt.smartcase = true
opt.hidden = true
opt.confirm = true
opt.autoread = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

opt.listchars = {
    tab = "→ ",
    eol = "↲",
    nbsp = "␣",
    trail = "•",
    extends = "⟩",
    precedes = "⟨",
    space = ".",
}
opt.foldmethod = "indent"
opt.foldenable = false
opt.background = "dark"

opt.colorcolumn = "120"

vim.o.syntax = "on"
vim.o.filetype = "on"

vim.o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr-o:hor20"

-- Revisit this if wezterm accepts reading from clipboard.
vim.g.clipboard = {
    name = "OSC 52",
    copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    -- Forces tmux to sync the clipboard to the OS clipboard to respond with the correct data
    paste = {
        ["+"] = function()
            if vim.env.TMUX then
                os.execute("tmux refresh-client -l")
                vim.wait(5)
            end
            return require("vim.ui.clipboard.osc52").paste("+")()
        end,
        ["*"] = function()
            if vim.env.TMUX then
                os.execute("tmux refresh-client -l")
                vim.wait(5)
            end
            return require("vim.ui.clipboard.osc52").paste("*")()
        end,
    },
}
