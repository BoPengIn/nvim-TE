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

local pluginList = require "pluginList"

local _M = {}

local fn = vim.fn
local installPath = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packageRoot = fn.stdpath('data')..'/site/pack'

function _M.setup(proxyMirror)

	vim.g.loaded_matchit = 1
	vim.g.loaded_matchparen = 1
	vim.g.matchup_matchparen_offscreen = {'method',"popup"}

	local packerUrl = "https://github.com/wbthomason/packer.nvim"
	local defaultUrlFormat = "https://github.com/%s.git"

	if proxyMirror then
		packerUrl = proxyMirror .. packerUrl
		defaultUrlFormat = proxyMirror .. defaultUrlFormat
	end

    local packerBootstrap = nil

    if fn.empty(fn.glob(installPath)) > 0 then
		packerBootstrap = fn.system({'git', 'clone', '--depth', '1', packerUrl, installPath})
	end

    local packer = require('packer')

    packer.init ({
		package_root = packageRoot,
		git = {
			clone_timeout = 300,
	    	default_url_format =  defaultUrlFormat
		},
		display = {
	    	open_fn = function()
				return require("packer.util").float({border = "single"})
	    	end
		},
		auto_clean = true,
		compile_on_sync = true,
    })

    packer.startup(function(use)

		use 'wbthomason/packer.nvim'

		if pluginList then
	    	for _,plugin in ipairs(pluginList) do
				use(plugin)
	    	end
		end

		if packerBootstrap then
	    	require('packer').sync()
		end
    end)
end

return _M

