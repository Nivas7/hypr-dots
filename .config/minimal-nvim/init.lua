-- nivaz neovim config
-- keymaps are in lua/config/mappings.lua
-- install a patched font & ensure your terminal supports glyphs
-- enjoy :D

-- auto install vim-plug and plugins, if not found
local data_dir = vim.fn.stdpath("data")
if vim.fn.empty(vim.fn.glob(data_dir .. "/site/autoload/plug.vim")) == 1 then
	vim.cmd(
		"silent !curl -fLo "
			.. data_dir
			.. "/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
	)
	vim.o.runtimepath = vim.o.runtimepath
	vim.cmd("autocmd VimEnter * PlugInstall --sync | source $MYVIMRC")
end

local vim = vim
local Plug = vim.fn["plug#"]

vim.call('plug#begin')

Plug('catppuccin/nvim', { ['as'] = 'catppuccin' }) --colorscheme
Plug('uZer/pywal16.nvim', { [ 'as' ] = 'pywal16' }) --or, pywal colorscheme
Plug('nvim-lualine/lualine.nvim') --statusline
Plug('nvim-tree/nvim-web-devicons') --pretty icons
Plug('lewis6991/gitsigns.nvim') --git
Plug('romgrk/barbar.nvim') --bufferline
Plug('nvim-tree/nvim-tree.lua') --file explorer
Plug('nvim-treesitter/nvim-treesitter') --improved syntax
Plug('ibhagwan/fzf-lua') --fuzzy finder and grep
Plug('numToStr/FTerm.nvim') --floating terminal
Plug('windwp/nvim-autopairs') --autopairs 
Plug('mfussenegger/nvim-lint') --async linter
Plug('folke/which-key.nvim') --mappings popup
  -- LSP Plugins
Plug('neovim/nvim-lspconfig')
Plug('folke/lazydev.nvim')
Plug('neovim/nvim-lspconfig')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('stevearc/conform.nvim')


vim.call('plug#end')


-- move config and plugin config to alternate files
require("config.theme")
require("config.mappings")
require("config.options")
require("config.autocmd")

require("plugins.colorscheme")
require("plugins.lsp.lsp")
require("plugins.nvim-tree")
require("plugins.lualine")
require("plugins.barbar")
require("plugins.autopairs")
require("plugins.gitsigns")
require("plugins.fterm")
require("plugins.fzf-lua")
require("plugins.treesitter")
require("plugins.which-key")

load_theme()
