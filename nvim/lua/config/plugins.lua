return {
  { "morhetz/gruvbox", lazy = false, priority = 1000, config = function()
      vim.g.gruvbox_italic = 1
      vim.g.gruvbox_invert_selection = 0
      --vim.cmd.colorscheme("gruvbox")
    end
  },
  { "airblade/vim-gitgutter" },
  { "preservim/nerdtree" },
  { "mg979/vim-visual-multi", branch = "master" },
  { "vim-airline/vim-airline", config = function()
      vim.g["airline#extensions#tabline#enabled"] = 1
    end
  },
  { "yggdroot/indentline" },
  { "sheerun/vim-polyglot" },
  { "junegunn/fzf", build = "./install --all" },
  { "ervandew/supertab" },
  { "jiangmiao/auto-pairs" },
  { "preservim/nerdcommenter" },
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = "dark", -- or darker 'dark', 'cool', 'deep', 'warm', 'warmer'
        transparent = false,
      })
      require("onedark").load()
    end
  }
}
