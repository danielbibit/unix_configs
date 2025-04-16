local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "Q", "<nop>", opts)
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "<C-p>", ":FZF<CR>", opts)
map("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)
map("n", "<C-o>", "o<ESC>", opts)
map("n", "<C-_>", "<Plug>NERDCommenterToggle")
map("v", "<C-_>", "<Plug>NERDCommenterToggle<CR>gv")

map("n", "<leader>y", '"+y', opts)
map("v", "<leader>y", '"+y', opts)
map("n", "<leader>Y", '"+Y', opts)
map("v", "<leader>Y", '"+Y', opts)

map("n", "<leader>p", '"+p', opts)
map("v", "<leader>p", '"+p', opts)
