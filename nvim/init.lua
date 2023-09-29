-- Lazy plugin manager setup:
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    "max397574/better-escape.nvim",
    "github/copilot.vim",
    {"neoclide/coc.nvim", branch="release"},
    "akinsho/toggleterm.nvim",
    "ellisonleao/gruvbox.nvim",
    "windwp/nvim-autopairs",
    "tpope/vim-surround",
    "tpope/vim-repeat",
    "tpope/vim-unimpaired",
    "ggandor/leap.nvim",
    "numToStr/Comment.nvim",
    "kyazdani42/nvim-web-devicons",
    "nvim-lualine/lualine.nvim",
    "lervag/vimtex",
    "kshenoy/vim-signature",
    {"nvim-neo-tree/neo-tree.nvim", branch = "v2.x", dependencies = {"MunifTanjim/nui.nvim"}},
    "nvim-lua/plenary.nvim",
    {"nvim-treesitter/nvim-treesitter", build=":TSUpdate"},
    {"nvim-telescope/telescope.nvim", tag="0.1.2"},
    {"nvim-telescope/telescope-fzf-native.nvim", build="make" },
    "fannheyward/telescope-coc.nvim",
    "nmac427/guess-indent.nvim",
    "NvChad/nvim-colorizer.lua",
    { "folke/which-key.nvim",
          event = "VeryLazy",
          init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
          end,
          opts = {}
    }
})

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.termguicolors = true
vim.opt.hidden = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 8
vim.opt.mouse = "a"
