return {
  { "morhetz/gruvbox", lazy = false, priority = 1000, config = function()
      vim.g.gruvbox_italic = 1
      vim.g.gruvbox_invert_selection = 0
    end
  },

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
        "vim"
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
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require("lualine").setup {
            options = {
                theme = "onedark"
            },
            sections = {
              lualine_c = {
                { "filename", path = 3 }
              }
            }
        }
    end,
  },

  { "yggdroot/indentline" },

  { "junegunn/fzf", build = "./install --all" },

  { "ervandew/supertab" },

  { "jiangmiao/auto-pairs" },

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
    end
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
              ['i'] = {
                  ["<CR>"] = utils.plugins.telescope_open_single_or_multi
              }
          }
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

      -- Open all modified and untracked git files in buffers
      vim.api.nvim_create_user_command("GitOpenModified", function()
        local files = {}
        local seen = {}

        -- Get modified files
        local handle = io.popen("git diff --name-only 2>/dev/null")
        if handle then
          local result = handle:read("*a")
          handle:close()
          for file in result:gmatch("[^\r\n]+") do
            if vim.fn.filereadable(file) == 1 and not seen[file] then
              table.insert(files, file)
              seen[file] = true
            end
          end
        end

        -- Get untracked files
        handle = io.popen("git ls-files --others --exclude-standard 2>/dev/null")
        if handle then
          local result = handle:read("*a")
          handle:close()
          for file in result:gmatch("[^\r\n]+") do
            if vim.fn.filereadable(file) == 1 and not seen[file] then
              table.insert(files, file)
              seen[file] = true
            end
          end
        end

        if #files == 0 then
          vim.notify("No modified or untracked git files found", vim.log.levels.INFO)
          return
        end

        for _, file in ipairs(files) do
          vim.cmd("edit " .. vim.fn.fnameescape(file))
        end
        vim.notify("Opened " .. #files .. " modified/untracked file(s)", vim.log.levels.INFO)
      end, {})
    end,

    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },

      { "<leader>fs", "<cmd>Telescope git_status<cr>", desc = "Git status" },

      { "<leader>fm", "<cmd>GitOpenModified<cr>", desc = "Open all modified/untracked git files" },
    },
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },

  {
    "OXY2DEV/markview.nvim",
    lazy = false,
  },

  {
    "kelly-lin/ranger.nvim",
    config = function()
      require("ranger-nvim").setup({
          replace_netrw = false,
          ui = {
            border = "rounded",
            height = 0.8,
            width = 0.8,
            x = 0.5,
            y = 0.5
          }
      })
      vim.api.nvim_set_keymap("n", "<leader>e", "", {
        noremap = true,
        callback = function()
          require("ranger-nvim").open(true)
        end,
      })
    end,
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
      -- add any custom options here
    }
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers", -- or "tabs"
          separator_style = "slant", -- options: "slant" | "slope" | "thick" | "thin"
          always_show_bufferline = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          color_icons = true,
        }
      })
    end
  },
  {
      "tpope/vim-fugitive",
      config = function()
        -- Set a shortcut for the main Git status window
        vim.keymap.set("n", "<leader>gd", vim.cmd.Gdiffsplit)
      end
  }
}
