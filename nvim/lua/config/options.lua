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
opt.ruler = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.clipboard = "unnamedplus"
--opt.clipboard = "unnamed"
opt.listchars = {
  tab = "→ ",
  eol = "↲",
  nbsp = "␣",
  trail = "•",
  extends = "⟩",
  precedes = "⟨",
  space = "."
}
opt.foldmethod = "indent"
opt.foldenable = false
opt.background = "dark"
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

-- Cursor styles
vim.cmd([[
let &t_SI = "\<esc>[5 q"
let &t_EI = "\<esc>[2 q"
let &t_SR = "\<esc>[3 q"
]])

local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    --['+'] = paste,
    --['*'] = paste,
  },
}

