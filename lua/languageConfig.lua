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

local _M = {}

function _M.list()
	return {"lua","c","cpp","cmake"}
end

function _M.setup()
	local succ, lspConfig = pcall(require, "lspconfig") 
	if not succ then
		return
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local completionItem = capabilities.textDocument.completion.completionItem
	completionItem.documentationFormat = {"markdown","plaintext"}
	completionItem.snippetSupport = true
	completionItem.preselectSupport = true
	completionItem.insertReplaceSupport = true
	completionItem.labelDetailsSupport = true
	completionItem.deprecatedSupport = true
	completionItem.commitCharactersSupport = true
	completionItem.tagSupport = { valueSet = {1}}
	completionItem.resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits"
		}
	}

	vim.cmd [[packadd lsp_signature.nvim]]

	require("languageServer.sumneko_lua").setup(lspConfig,capabilities)
	require("languageServer.clangd").setup(lspConfig,capabilities)
	require("languageServer.ccls").setup(lspConfig,capabilities)
	require("languageServer.cmake").setup(lspConfig,capabilities)
   
	require("lsp_signature").setup {
		bind = true,
		doc_lines = 0,
		max_height = 32,
		hint_enable = false,
		handler_opts = {
			border = "single"
		},
		zindex = 200,
	}

	vim.cmd [[colorscheme sonokai]]
end


return _M

