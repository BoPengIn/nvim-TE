------------------------------------------------------------------------------
--  nvim-TE
--  Copyright (C) 2021  Peng Bo <pengbo@twtwo.com>
-- 
--  This program is free software: you can redistribute it and/or modify
--  it under the terms of the GNU Affero General Public License as published
--  by the Free Software Foundation, either version 3 of the License, or
--  (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU Affero General Public License for more details.
--
--  You should have received a copy of the GNU Affero General Public License
--  along with this program.  If not, see <https://www.gnu.org/licenses/>.
------------------------------------------------------------------------------

local pluginList = {
    {"neovim/nvim-lspconfig",config = function()
		--Customizing how diagnostics are displayed
		vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,{
			virtual_text = true,
			signs = true,
			underline = true,
			update_in_insert = false
		})
	end},
    {"ray-x/lsp_signature.nvim", after = "nvim-lspconfig"},
	{"glepnir/lspsaga.nvim",after = "nvim-lspconfig",config = function ()
		require("lspsaga").init_lsp_saga()
		vim.o.updatetime = 250
		vim.api.nvim_command "autocmd CursorHold * Lspsaga show_line_diagnostics" 
	end},
	{"nvim-treesitter/nvim-treesitter",run = ":TSUpdate",config = function()
		require("nvim-treesitter.configs").setup {
	    	ensure_installed = require("languageConfig").list(),
	    	textobjects = {
				select = {
		    		enable = true,
		    		keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
		    		}
				},
				move = {
		    		enable = true,
		    		set_jumps = true,
		    		goto_next_start = {
						["]]"] = "@function.outer",
						["]m"] = "@class.outer"
		    		},
		    		goto_next_end = {
						["]["] = "@function.outer",
						["]n"] = "@class.outer"
		    		},
		    		goto_previous_start = {
						["[["] = "@function.outer",
						["[m"] = "@class.outer"
		    		},
		    		goto_previous_end = {
						["[]"] = "@function.outer",
						["[n"] = "@class.outer"
		    		}
				}
	    	},
	   		matchup = {
				enable = true --vim-matchup
	    	},
	    	highlight = {
				enable = true,
				use_languagetree = true,
	    	},
		}
    end},
   {"nvim-treesitter/nvim-treesitter-textobjects",after = "nvim-treesitter"},
    --{"romgrk/nvim-treesitter-context",after = "nvim-treesitter"},
    {"andymass/vim-matchup",after = "nvim-treesitter"},
    {"kyazdani42/nvim-web-devicons",config = function()
		require("nvim-web-devicons").setup {
			default = true;
		}
    end},
	{"nvim-lualine/lualine.nvim", after = {"nvim-web-devicons"},config = function()
		require("lualine").setup {
	    	options = {
				icons_enabled = true,
				theme = "nord",
				disabled_filetypes = {},
				always_divide_middle = true,
	    	},
	    	sections = {
				lualine_a = {"mode"},
				lualine_b = {"branch","diff"},
				lualine_c = {"filename"},
				lualine_x = {
		    		{
						"diagnostics",
						source = {"nvim_lsp"},
						update_in_insert = true,
						always_visible = false,
		    		},
		    		{"encoding"},
					{"fileformat"},
		    		{"filetype"}
				},
				lualine_y = {"progress"},
				lualine_z = {"location"}
	    	},
	    	inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {"filename"},
				lualine_x = {"location"},
				lualine_y = {},
				lualine_z = {}
	    	},
	    	tabline = {},
	    	extensions = {}
		}
    end},
    {"kyazdani42/nvim-tree.lua", after = "nvim-web-devicons",config = function()
	    vim.g.nvim_tree_gitignore = 1
	    vim.g.nvim_tree_quit_on_open = 1
	    vim.g.nvim_tree_indent_markers = 1
	    vim.g.nvim_tree_git_hl = 1
	    vim.g.nvim_tree_highlight_opened_files = 1
	    vim.g.nvim_tree_root_folder_modifier = ':~'
	    vim.g.nvim_tree_add_trailing = 0
	    vim.g.nvim_tree_group_empty = 0
		vim.g.nvim_tree_show_icons = {
			git = 1,
			folders = 1,
			files = 1,
			folder_arrows = 0,
	    }
	    local tree_cb = require("nvim-tree.config").nvim_tree_callback
	    require "nvim-tree".setup {
			disable_netrw = true,
			hijack_netrw = true,
			open_on_setup = false,
			ignore_ft_on_setup = {},
			auto_close = true,
			open_on_tab = false,
			update_to_buf_dir = {
		    	enable = true,
		    	auto_open = true
			},
			hijack_cursor = true,
			update_cwd = true,
			diagnostics = {
		    	enable = false,
		    	icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				}
	    	},
	    	update_focused_file = {
				enable = true,
				update_cwd = true,
				ignore_list = {}
	    	},
	    	system_open = {
				cmd = nil,
				args = {}
	    	},
			filters = {
				dotfiles = true,
				custom = {'.git','.tar.gz','.cache','.ccls-cache'}
			},
			view = {
				width = 30,
				height = 30,
				hide_root_folder = false,
				side = 'left',
				auto_resize = false,
				mappings = {
		    		custom_only = false,
		    		list = {
						{key = "v",cb = tree_cb "vsplit"}
		    		}
				}
	    	},
		}
    end},
	{"akinsho/bufferline.nvim",after = "nvim-web-devicons",config = function()
		require("bufferline").setup {
			options = {
				numbers = function(opts)
					return string.format('%s·%s',opts.raise(opts.id),opts.lower(opts.ordinal))
				end,
				indicator_icon = '▎',
				buffer_close_icon = '',
				modified_icon = '●',
				close_icon = '',
				left_trunc_marker = '',
				right_trunc_marker = '',
				max_name_length = 12,
				max_prefix_length = 10,
				tab_size = 18,
				diagnostics = "nvim_lsp",
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				show_tab_indicators = true,
				separator_style = "slant",
				--enforce_regular_tabs = true,
				always_show_bufferline = true,
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						highlight = "Directory",
						text_align = "left",
						padding =  1
					}
				}
			}
		}
	end},
	{"folke/trouble.nvim",after = "nvim-web-devicons",config = function ()
		require("trouble").setup {
			fold_open = "", -- icon used for open folds
			fold_closed = "", -- icon used for closed folds
			indent_lines = true,
			signs = {
				error = "",
				warning = "",
				hint = "",
				information = "",
				other = "﫠"
			}
		}
	end},
	{"nvim-telescope/telescope.nvim",
		requires = {
			{"nvim-lua/plenary.nvim"},
			{"nvim-telescope/telescope-fzy-native.nvim"},
		},
		config = function ()
			require("telescope").setup {
				defaults = {
					layout_strategy = "horizontal",
					layout_config = {
						preview_cutoff = 1,
						horizontal = { prompt_position = "bottom",results_width = 0.6,preview_width = 0.55},
						vertical = {mirror = false}
					},
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
					qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
					color_devicons = true,
					use_less = 1,
					winblend = 0,
					path_display = {"absolute"},
				},
				extensions = {
					fzy_native = {
						override_generic_sorter = false,
						override_file_sorter = true,
					}
				}
			}
			require("telescope").load_extension("fzy_native")
		end
	},
	{"L3MON4D3/LuaSnip",requires = "rafamadriz/friendly-snippets",config = function()
		require("luasnip").config.set_config {
			history = true,
			updateevents = "TextChanged,TextChangedI"
		}
		require("luasnip/loaders/from_vscode").load()
	end},
	{"hrsh7th/nvim-cmp",
		requires = {
			{"onsails/lspkind-nvim"},
	    	{"saadparwaiz1/cmp_luasnip",after = "LuaSnip"},
	    	{"hrsh7th/cmp-buffer"},
	    	{"hrsh7th/cmp-nvim-lsp"},
	    	{"hrsh7th/cmp-nvim-lua"},
	    	{"hrsh7th/cmp-path"},
			{"f3fora/cmp-spell"},
			{"kdheepak/cmp-latex-symbols"}
		},
    	config = function()
			local succ,cmp = pcall(require,"cmp")
			if not succ then
	    		return
			end
			local has_words_before = function()
	    		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	    		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col,col):match("%s") == nil
			end
			vim.opt.completeopt = "menuone,noselect"
			vim.opt.spell = true
			vim.opt.spelllang = { 'en_us' }
			cmp.setup {
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				formatting = {
					format =  require("lspkind").cmp_format({with_text = true, menu = ({
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						luasnip = "[LuaSnip]",
						nvim_lua = "[Lua]",
						path = "[Path]",
						spell = "[Spell]",
						latex_symbols = "[Latex]"
					})}),
				},
				mapping = {
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-y>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					},
					["<C-j>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif require("luasnip").expand_or_jumpable() then
							require("luasnip").expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end,{"i","s"}),
					["<C-k>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif require("luasnip").jumpable(-1) then
							require("luasnip").jump(-1)
						else
							fallback()
						end
					end,{"i","s"}),
				},
				sources = {
					{name = "nvim_lsp"},
					{name = "luasnip"},
					{name = "buffer"},
					{name = "nvim_lua"},
					{name = "path"},
					{name = "spell"},
					{name = "latex_symbols" }
				},
			}
    	end
	},
    {"windwp/nvim-autopairs",after = "nvim-cmp",config = function()
		require("nvim-autopairs").setup()
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")
		cmp.event:on("confirm_done",cmp_autopairs.on_confirm_done())
	end},
    {"terrortylor/nvim-comment",config = function()
    	require("nvim_comment").setup()
    end},
    {"lukas-reineke/indent-blankline.nvim",config = function ()
    	require("indent_blankline").setup {
	    	indent_blankline_enabled = 1,
	    	filetype_exclude = {
				"help",
				"terminal",
				"packer",
				"lspinfo",
				"NvimTree",
				"help",
				"log",
				"git",
				"markdown",
				"txt",
				"json"
			},
			buftype_exclude = {"termainal","nofile"},
			show_trailing_blankline_indent = false,
		}
		vim.cmd "autocmd CursorMoved * IndentBlanklineRefresh"
    end},
    {"max397574/better-escape.nvim",config = function()
		require("better_escape").setup()
    end},
	{"folke/lsp-colors.nvim",config = function ()
		require("lsp-colors").setup {
			Error = "#db4b4b",
			Warning = "#e0db9d7",
			Information = "#0db9d7",
			Hint = "#10B981"
		}
	end},
	{"sainnhe/sonokai",config = function()
		vim.g.sonokai_style = "Atlantis"
		vim.g.sonokai_disable_italic_comment = 1
		vim.g.sonokai_enable_italic = 1
		vim.g.sonokai_better_performance = 1
	end},
}
return pluginList
