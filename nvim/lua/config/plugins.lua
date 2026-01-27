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
        "dockerfile",
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

  { "vim-airline/vim-airline" },

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

      -- Show git diff of current buffer (side-by-side with colors)
      vim.api.nvim_create_user_command("GitDiffBuffer", function()
        local file = vim.fn.expand("%:p")
        local filetype = vim.bo.filetype
        if file == "" then
          vim.notify("No file in current buffer", vim.log.levels.WARN)
          return
        end
        -- Start diff mode on current buffer
        vim.cmd("diffthis")
        -- Open vertical split with git HEAD version
        vim.cmd("vsplit | enew")
        vim.bo.buftype = "nofile"
        vim.bo.bufhidden = "wipe"
        vim.bo.filetype = filetype
        vim.cmd("r !git show HEAD:" .. vim.fn.shellescape(vim.fn.fnamemodify(file, ":.")))
        vim.cmd("1delete")
        vim.cmd("diffthis")
        vim.cmd("normal! gg")
      end, {})

      -- Open all modified git files in buffers
      vim.api.nvim_create_user_command("GitOpenModified", function()
        local handle = io.popen("git diff --name-only 2>/dev/null")
        if not handle then return end
        local result = handle:read("*a")
        handle:close()

        local files = {}
        for file in result:gmatch("[^\r\n]+") do
          if vim.fn.filereadable(file) == 1 then
            table.insert(files, file)
          end
        end

        if #files == 0 then
          vim.notify("No modified git files found", vim.log.levels.INFO)
          return
        end

        for _, file in ipairs(files) do
          vim.cmd("edit " .. vim.fn.fnameescape(file))
        end
        vim.notify("Opened " .. #files .. " modified file(s)", vim.log.levels.INFO)
      end, {})
    end,

    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },

      { "<leader>fs", "<cmd>Telescope git_status<cr>", desc = "Git status" },

      { "<leader>fm", "<cmd>GitOpenModified<cr>", desc = "Open all modified git files" },
      { "<leader>fd", "<cmd>GitDiffBuffer<cr>", desc = "Git diff current buffer" },
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
      -- Set up bufferline
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
  }
}
