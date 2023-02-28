return require("packer").startup({
	function(use)
		use({ "wbthomason/packer.nvim" })

		use({
			"navarasu/onedark.nvim",
			config = function()
				require("onedark").setup({
					highlights = {
						["@constructor"] = { fmt = "none" },
						["@text.strong"] = { fmt = "none" },
						["@text.title"] = { fmt = "none" },
						TSConstructor = { fmt = "none" },
						TSStrong = { fmt = "none" },
						TSTitle = { fmt = "none" },
						FloatBorder = { bg = "none" },
						NormalFloat = { bg = "none" },
					},
				})
				vim.cmd.colorscheme("onedark")
			end,
		})

		use({ "neovim/nvim-lspconfig" })
		use({
			"williamboman/mason.nvim",
			config = function()
				require("mason").setup()
			end,
		})
		use({
			"jose-elias-alvarez/null-ls.nvim",
			requires = { "nvim-lua/plenary.nvim" },
		})
		use({
			"glepnir/lspsaga.nvim",
			branch = "main",
			requires = {
				{ "nvim-tree/nvim-web-devicons" },
				{ "nvim-treesitter/nvim-treesitter" },
			},
		})

		use({ "nvim-treesitter/nvim-treesitter" })
		use({ "nvim-treesitter/nvim-treesitter-textobjects" })

		use({
			"nvim-telescope/telescope.nvim",
			requires = { "nvim-lua/plenary.nvim" },
		})
		use({
			"nvim-telescope/telescope-file-browser.nvim",
			requires = {
				"nvim-telescope/telescope.nvim",
				"nvim-lua/plenary.nvim",
			},
		})
		use({
			"nvim-telescope/telescope-fzf-native.nvim",
			run = "make",
		})

		use({ "nvim-lua/popup.nvim" })
		use({ "nvim-lua/plenary.nvim" })
		use({ "kyazdani42/nvim-web-devicons" })
		use({ "nvim-lualine/lualine.nvim" })

		use({ "hrsh7th/nvim-cmp" })
		use({ "hrsh7th/cmp-buffer" })
		use({ "hrsh7th/cmp-path" })
		use({ "hrsh7th/cmp-cmdline" })
		use({ "hrsh7th/cmp-nvim-lsp" })
		use({ "L3MON4D3/LuaSnip" })
		use({ "saadparwaiz1/cmp_luasnip" })
		use({ "onsails/lspkind.nvim" })

		use({ "lewis6991/impatient.nvim" })

		use({ "lewis6991/gitsigns.nvim" })

		use({ "ruifm/gitlinker.nvim" })

		use({
			"sindrets/diffview.nvim",
			opt = true,
			cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		})

		use({
			"nvim-tree/nvim-tree.lua",
			opt = true,
			cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
			config = function()
				require("nvim-tree").setup()
			end,
		})

		use({
			"simrat39/symbols-outline.nvim",
			opt = true,
			cmd = { "SymbolsOutline" },
			config = function()
				require("symbols-outline").setup()
			end,
		})

		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})

		use({ "ojroques/vim-oscyank" })

		use({
			"kylechui/nvim-surround",
			tag = "*",
			config = function()
				require("nvim-surround").setup()
			end,
		})

		use({
			"j-hui/fidget.nvim",
			config = function()
				require("fidget").setup({
					window = { blend = 0 },
				})
			end,
		})

		use({
			"junegunn/fzf",
			run = function()
				vim.fn["fzf#install"]()
			end,
		})

		use({
			"kevinhwang91/nvim-bqf",
			ft = "qf",
			config = function()
				require("bqf").setup({ auto_resize_height = true })
			end,
		})
	end,
	config = {
		display = { prompt_border = "single" },
	},
})
