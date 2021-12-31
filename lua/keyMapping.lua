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
--keymap
local normalKeymap = {	-- normal mode
	["<C-s>"] = "<cmd>w<CR>",
	["<C-h>"] = "<Home>",
	["<C-l>"] = "<End>",
	--lspconfig
	["<leader>h"] = "<cmd>ClangdSwitchSourceHeader<CR>",
	["gd"] = "<cmd>lua vim.lsp.buf.definition()<CR>",
	["gs"] = "<cmd>lua vim.lsp.buf.declaration()<CR>",
	["gt"] = "<cmd>lua vim.lsp.buf.type_definition()<CR>",
	["gr"] = "<cmd>lua vim.lsp.buf.references()<CR>",
	["gi"] = "<cmd>lua vim.lsp.buf.implementation()<CR>",
	["K"] = "<cmd>lua vim.lsp.buf.hover()<CR>",
	["<space>f"] = "<cmd>lua vim.lsp.buf.formatting()<CR>",
	--lspsaga
	["gh"] = "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>",
	["[e"] = "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>",
	["]e"] = "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>",
	["<C-t>"] = "<cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>",
	["<leader>pd"] = "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>",
	["<leader>rf"] = "<cmd>lua require('lspsaga.rename').rename()<CR>",
	--nvim-tree
	["<C-n>"] = "<cmd>NvimTreeToggle<CR>",
	--bufferline
	["[b"] = "<cmd>BufferLineCycleNext<CR>",
	["b]"] = "<cmd>BufferLineCyclePrev<CR>",
	["gb"] ="<cmd>BufferLinePick<CR>",
	["bd"] ="<cmd>BufferLinePickClose<CR>",
	["bh"] ="<cmd>BufferLineCloseLeft<CR>",
	["bl"] ="<cmd>BufferLineCloseRight<CR>",
	["<A-1>"] ="<cmd>BufferLineGoToBuffer 1<CR>",
	["<A-2>"] ="<cmd>BufferLineGoToBuffer 2<CR>",
	["<A-3>"] ="<cmd>BufferLineGoToBuffer 3<CR>",
	["<A-4>"] ="<cmd>BufferLineGoToBuffer 4<CR>",
	["<A-5>"] ="<cmd>BufferLineGoToBuffer 5<CR>",
	["<A-6>"] ="<cmd>BufferLineGoToBuffer 6<CR>",
	["<A-7>"] ="<cmd>BufferLineGoToBuffer 7<CR>",
	["<A-8>"] ="<cmd>BufferLineGoToBuffer 8<CR>",
	["<A-9>"] ="<cmd>BufferLineGoToBuffer 9<CR>",
	--Trouble 
	["<leader>xx"] ="<cmd>TroubleToggle<CR>",
	["<leader>xd"] ="<cmd>TroubleClose<CR>",
	["<leader>xr"] ="<cmd>TroubleRefresh<CR>",
	--telescope
	["<leader>fb"] ="<cmd>Telescope buffers<CR>",
	["<leader>ff"] ="<cmd>Telescope find_files<CR>",
	["<leader>fg"] ="<cmd>Telescope live_grep<CR>",
	["<leader>fh"] ="<cmd>Telescope help_tags<CR>",
	--nvim-comment
	["m"] ="<cmd>CommentToggle<CR>",
}

local visualSelectKeymap  = { -- visual and select mode

}

local selectKeymap = { -- select mode

}

local visualKeymap = { -- visual mode
	--nvim-comment
	["m"] ="<cmd>CommentToggle<CR>",
}

local operatorKeymap = { -- operator mode

}

local insertCommandKeymap = { -- insert mode and command-line mode

}

local insertKeymap = { -- insert mode
	["<A-h>"] = "<Left>",
	["<A-j>"] = "<Down>",
	["<A-k>"] = "<Up>",
	["<A-l>"] = "<Right>",
	["<A-d>"] = "<Delete>",
	["<C-s>"] = "<ESC><cmd>w<CR>",
	["<C-d>"] = "<ESC><C-d>i",
	["<C-u>"] = "<ESC><C-u>i",
	["<C-h>"] = "<Home>",
	["<C-l>"] = "<End>",
	--nvim-comment
	["<A-m>"] ="<cmd>CommentToggle<CR>",
}

local commandKeymap = { -- command-line mode

}

local termainalKeymap = { -- terminal mode
	--lspsaga
	["<C-t>"] = "<C-\\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>",
}

--------------------------------------------------------
local _M = {}

local defaultOpt = { noremap = true, silent = true }

local function mode_keymap(mode,keymap)
	local nvim_set_keymap = vim.api.nvim_set_keymap
	local opt
	for k, v in pairs(keymap) do
		opt = defaultOpt
		if type(v) == "table" then
			opt  = v[2]
			v = v[1]
		end
		nvim_set_keymap(mode,k,v,opt)
	end
end

local function keymap_config()
	local modeKeymap = {
		normalKeymap,
		visualSelectKeymap,
		selectKeymap,
		visualKeymap,
		operatorKeymap,
		insertCommandKeymap,
		insertKeymap,
		{},
		commandKeymap,
		termainalKeymap,
	}

	local modeChar = {
		'n','v','s','x','o','!','i','l','c','t'
	}

	for k,v in pairs(modeKeymap) do
		mode_keymap(modeChar[k],v)
	end

end

function _M.setup()	
	vim.g.mapleader = ","
	keymap_config()
end

return _M
