-- some defaults
local o = vim.opt
o.mouse = 'a'
o.belloff = 'all'
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true
o.smartcase = true
o.swapfile = false
o.backup = false
local cache_home = os.getenv("XDG_CACHE_HOME")  
if cache_home == nil then cache_home = "/home/paul/.cache" end
o.undodir = cache_home.. "/nvim/undodir" -- this does not work if env is not set
o.undofile = true
o.incsearch = true
o.encoding = 'utf-8'
o.conceallevel = 2 -- show latex and markdown math symbols as unicode symbols
--line numbers on the side
o.number = true
o.relativenumber = true

-- use systemc clipboard
o.clipboard = 'unnamedplus'

-- splitting
o.splitbelow = true
o.splitright = true

-- scroll by screen lines instead of actual lines 
-- o.smoothscroll = true

--show spaces as dots
vim.cmd("set lcs+=space:·")
o.list = true

-- only one statusline
o.laststatus = 3

-- faster load times
vim.loader.enable()

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("user.plugins")

----------------------------
-- Include the Lua config
----------------------------
require('user.keymap')
-------------
-- NOTES
--------------
--[[

# Search

n next item in search
N previous
:noh no more highlight after search


--]]
