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

local function switch_source_header_splitcmd(bufnr,splitcmd,nvimLspConfig)
	bufnr = nvimLspConfig.util.validate_bufnr(bufnr)
	local params = { uri = vim.uri_from_bufnr(bufnr) }
	vim.lsp.buf_request(
		bufnr,
		"textDocument/switchSourceHeader",
		params,
		nvimLspConfig.util.compat_handler(function (err,result)
			--if err then error(tostring(err)) end --Temporarily avoid bugs
			if err then print(tostring(err)) return end
			if not result then print("Corresponding file can't be determined") return end
			vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
		end)
	)
end

function _M.setup(lspConfig,clientCapabilities)

    lspConfig.clangd.setup {
		capabilities = clientCapabilities,
		flags = { debounce_text_changes = 500},
		commands = {
			ClangdSwitchSourceHeader = {
				function()
					switch_source_header_splitcmd(0,"edit",lspConfig)
				end,
				description = "Open source/header in current buffer"
			},
			ClangdSwitchSourceHeaderVSplit = {
				function()
					switch_source_header_splitcmd(0,"vsplit",lspConfig)
				end,
				description = "Open source/header in new vsplit"
			},
			ClangdSwitchSourceHeaderSplit = {
				function()
					switch_source_header_splitcmd(0,"split",lspConfig)
				end,
				description = "Open source/header in new split"
			},
		},
    }
end

return _M
