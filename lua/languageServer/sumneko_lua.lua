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

local nvim_fn = vim.fn

function _M.setup(lspConfig,clientCapabilities)

     -- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
    local sumneko_root_path = nvim_fn.stdpath('data')..'/lsp/lua-language-server'
    local sumneko_binary = sumneko_root_path.."/bin/lua-language-server"
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    lspConfig.sumneko_lua.setup {
		capabilities = clientCapabilities,
		flags = { debounce_text_changes = 500},
		cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
		settings = {
	    	Lua = {
				runtime = {
		    		version = 'Lua 5.4',
		    		-- Setup your lua path
		    		path = runtime_path,
				},
            	diagnostics = {
		    		globals = {'vim'},
				},
				workspace = {
		    		-- Make the server aware of Neovim runtime files
		    		library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
		    		enable = false,
				},
	    	},
		},
    }
end

return _M
