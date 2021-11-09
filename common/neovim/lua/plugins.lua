local setup = function()
	local packer_install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if #vim.fn.glob(packer_install_path) == 0 then
		vim.fn.system {'git', 'clone', 'https://github.com/wbthomason/packer.nvim', packer_install_path}
		vim.api.nvim_command'packadd packer.nvim'
	end

	vim.g.polyglot_disabled = {'cue'}

	local packer = require'packer'
	packer.startup(function()
		local plugins = {
			'wbthomason/packer.nvim',
			'editorconfig/editorconfig-vim',
			'tpope/vim-sleuth',
			'vim-scripts/LargeFile',
			'vim-scripts/restore_view.vim',
			'christoomey/vim-tmux-navigator',
			'tpope/vim-fugitive',
			'tpope/vim-rhubarb',
			'tpope/vim-commentary',
			'tpope/vim-repeat',
			'machakann/vim-sandwich',
			'michaeljsmith/vim-indent-object',
			'wellle/targets.vim',
			'bkad/CamelCaseMotion',
			'ludovicchabant/vim-gutentags',
			'tpope/vim-obsession',
			'dhruvasagar/vim-prosession',
			{'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}},
			'joshdick/onedark.vim',
			'lukas-reineke/indent-blankline.nvim',
			{'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}},
			'neovim/nvim-lspconfig',
			'hrsh7th/nvim-compe',
			'jjo/vim-cue',
			'sheerun/vim-polyglot',
			{'neoclide/coc.nvim', branch = 'release'},
		}
		for _,plugin in ipairs(plugins) do
			packer.use(plugin)
		end
	end)
end

return {setup = setup}
