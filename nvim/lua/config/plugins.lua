return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local parsers = {
				"lua",
				"php",
				"python",
				"javascript",
				"typescript",
				"bash",
				"markdown",
				"json",
				"yaml",
				"html",
				"css",
				"vim",
			}
			require("nvim-treesitter").install(parsers)
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},

	{ "airblade/vim-gitgutter" },

	{ "mg979/vim-visual-multi", branch = "master" },

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "onedark",
				},
				sections = {
					lualine_c = {
						{ "filename", path = 3 },
					},
				},
			})
		end,
	},

	{ "yggdroot/indentline" },

	{ "junegunn/fzf", build = "./install --all" },

	{ "ervandew/supertab" },

	{ "jiangmiao/auto-pairs" },

	{
		"folke/snacks.nvim",
		opts = {
			lazygit = {},
			inputs = {},
			indent = {
				animate = {
					enabled = true,
					style = "out",
					duration = {
						step = 50,
						total = 750,
					},
				},
			},
			dim = {},
			buffdelete = {},
			dashboard = {},
            git = {}
		},
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	{
		"folke/noice.nvim",
		opts = {
			cmdline = {
				enabled = true,
				view = "cmdline_popup",
			},
            routes = {
              {
                filter = {
                  event = "msg_show",
                  any = {
                    { find = "%d+L, %d+B" },
                    { find = "; after #%d+" },
                    { find = "; before #%d+" },
                  },
                },
                view = "mini",
              },
            },
            presets = {
              bottom_search = true,
              command_palette = true,
              long_message_to_split = true,
            },
		},
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
			delay = 100,
			win = {
				border = "rounded",
			},
		},
	},

	{ "preservim/nerdcommenter" },

	{ "tpope/vim-surround" },

	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "dark", -- or darker 'dark', 'cool', 'deep', 'warm', 'warmer'
				transparent = true,
			})
			require("onedark").load()
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					hidden = true,
					file_ignore_patterns = { "%.git/" },
					mappings = {
						["i"] = {
							["<CR>"] = utils.plugins.telescope_open_single_or_multi,
						},
					},
				},
				pickers = {
					find_files = {
						hidden = true,
					},
					live_grep = {
						additional_args = { "--hidden" },
					},
				},
			})
		end,

		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
			{ "<leader>fs", "<cmd>Telescope git_status<cr>", desc = "Git status" },
		},
	},

	{
		"OXY2DEV/markview.nvim",
		lazy = false,
	},

	{
		"mikavilpas/yazi.nvim",
		version = "*", -- use the latest stable version
		event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = true },
		},
		keys = {
			{
				"<leader>e",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				-- Open in the current working directory
				"<leader>E",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
		},
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = {
			-- add any custom options here
		},
	},

	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers", -- or "tabs"
					separator_style = "slant", -- options: "slant" | "slope" | "thick" | "thin"
					always_show_bufferline = true,
					show_buffer_close_icons = true,
					show_close_icon = true,
					color_icons = true,
				},
			})
		end,
	},
	{
		"tpope/vim-fugitive",
		config = function()
			-- Set a shortcut for the main Git status window
			vim.keymap.set("n", "<leader>gd", vim.cmd.Gdiffsplit)
		end,
	},
	{
		"MagicDuck/grug-far.nvim",
		opts = { headerMaxWidth = 80 },
		cmd = { "GrugFar", "GrugFarWithin" },
		keys = {
			{
				"<leader>sr",
				function()
					local grug = require("grug-far")
					local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
					grug.open({
						transient = true,
						prefills = {
							filesFilter = ext and ext ~= "" and "*." .. ext or nil,
						},
					})
				end,
				mode = { "n", "x" },
				desc = "Search and Replace",
			},
		},
	},
}
