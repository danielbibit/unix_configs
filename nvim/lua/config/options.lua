-- Disable netrw (built-in file explorer)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- No buffer when entering a directory
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.fn.isdirectory(vim.fn.expand("%")) == 1 then
      vim.cmd("bwipeout!")
    end
  end,
})

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

opt.colorcolumn = "120"

vim.o.syntax = "on"
vim.o.filetype = "on"

vim.o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr-o:hor20"

local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

-- vim.g.clipboard = {
--   name = 'OSC 52',
--   copy = {
--     ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
--     ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
--   },
--   paste = {
--     ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
--     ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
--     --['+'] = paste,
--     --['*'] = paste,
--   },
-- }
-- Disable conceal for markdown files (indentline sets conceallevel)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

