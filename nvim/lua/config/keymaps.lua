local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "Q", "<nop>", opts)
map("n", "q:", "<nop>", opts)
map("n", "q/", "<nop>", opts)
map("n", "q?", "<nop>", opts)

--map("n", "<Esc>", "<cmd>noh<CR><Esc>", { silent = true })
map("n", "<leader><Esc>", "<cmd>noh<CR>", { silent = true, desc = "Clear search highlight" })

map("n", "<C-s>", ":w<CR>", opts)
map("i", "<C-s>", "<Esc>:w<CR>a", opts)
map("v", "<C-s>", "<Esc>:w<CR>gv", opts)

map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "<C-p>", ":FZF<CR>", opts)
map("n", "<C-o>", "o<ESC>", opts)

-- Map both <C-/> and <C-_> for cross-platform compatibility (macOS sends <C-/>)
map("n", "<C-/>", "<cmd>call nerdcommenter#Comment('n', 'Toggle')<CR>", opts)
map("v", "<C-/>", ":call nerdcommenter#Comment('x', 'Toggle')<CR>gv", opts)
map("n", "<C-_>", "<cmd>call nerdcommenter#Comment('n', 'Toggle')<CR>", opts)
map("v", "<C-_>", ":call nerdcommenter#Comment('x', 'Toggle')<CR>gv", opts)

map("n", "<leader>a", "ggVG", opts)

map("n", "<leader>y", '"+y', opts)
map("v", "<leader>y", '"+y', opts)
map("n", "<leader>Y", '"+Y', opts)
map("v", "<leader>Y", '"+Y', opts)

map("n", "<leader>p", '"+p', opts)
map("v", "<leader>p", '"+p', opts)
map("n", "<leader>p", '"+P', opts)
map("v", "<leader>p", '"+P', opts)

map("n", "<C-Tab>", ":bnext<CR>", opts)
map("n", "<C-S-Tab>", ":bprevious<CR>", opts)
map("n", "<S-L>", ":bnext<CR>", opts)
map("n", "<S-H>", ":bprevious<CR>", opts)

map("n", "<leader>bn", ":bnext<CR>", { silent = true, desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { silent = true, desc = "Previous buffer" })

map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })

map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

map("n", "<leader>bo", function()
	Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })

map("n", "<leader>gm", "<cmd>GitOpenModified<cr>", { desc = "Open all modified on git" })
map("n", "<leader>gg", function()
	Snacks.lazygit()
end, { desc = "Lazygit (cwd)" })
