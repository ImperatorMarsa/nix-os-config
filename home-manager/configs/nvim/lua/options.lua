vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.clipboard = 'unnamed'

vim.o.number = true
vim.o.relativenumber = true

vim.o.signcolumn = 'yes'

-- tabs
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.smartindent = true
-- -- --

-- swap\undo
local os_name = vim.loop.os_uname().sysname
local home_dir = os.getenv("HOME")
if os_name == "Windows" or os_name == "Windows_NT" then
    home_dir = "C:/Windows/Temp"
end

local backupdir = home_dir .. "/.vim/n_backup/"
if vim.fn.isdirectory(backupdir) == 0 then
    vim.fn.mkdir(backupdir, "p", 0755)
end
vim.o.backupdir = backupdir
vim.o.backup = true
vim.o.writebackup = true

local undodir = home_dir .. "/.vim/n_undo/"
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p", 0755)
end
vim.o.undodir = undodir
vim.o.undofile = true

local swapdir = home_dir .. "/.vim/n_swap/"
if vim.fn.isdirectory(swapdir) == 0 then
    vim.fn.mkdir(swapdir, "p", 0755)
end
vim.o.directory = swapdir
vim.o.swapfile = true
-- -- --

vim.o.mouse = 'a'

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 12
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- disable netrt
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Foldings
vim.opt.foldmethod = "indent"
vim.cmd('set nofoldenable')
vim.opt.foldlevel = 99

-- spelling
vim.opt.spell = true
vim.opt.spelllang = 'ru_ru,en_us'
