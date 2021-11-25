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
local vim = vim

local options =
{
    --encoding
    encoding = "utf-8",
    fileencoding = "utf-8",
    --file
    backup = false,
    swapfile = false,
	autoread = true,
	autowrite = false,
	--cursor line
	cursorline = true,
    relativenumber = true,
    number = true,
	scrolloff = 2,
	sidescrolloff = 6,
	--tab
    expandtab = false,
	shiftwidth = 4,
    tabstop = 4,
    smarttab = true,
	--search
	ignorecase = true,
	incsearch = true,
	wrapscan = true,
    --ui
    showmode = false,
    showtabline = 2,
	showcmd = false,
    splitbelow = true,
    splitright = true,
	pumheight = 16,
	foldenable = true,
    foldmethod = "manual", --nvim_treesitter
    foldexpr = "",
    termguicolors = true,
    title = true,
	--other
	backspace = "indent,eol,start",
	completeopt  = {"menuone","noselect"},
	conceallevel = 0,
	history = 4096,
	smartcase = true,
	smartindent = false,
	clipboard = "unnamedplus",
	mouse = 'a',
	redrawtime = 2000,
	timeout = true,
	timeoutlen = 500,
	ttimeout = true,
	ttimeoutlen = 0,
	wildignorecase = true,
	wrap = false,
	shortmess = "atI",
}

function _M.setup()
    local opt = vim.opt
    for k, v in pairs(options) do
		opt[k] = v
    end
	opt.whichwrap:append "<>[]hl"
end

return _M
