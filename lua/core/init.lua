local opt = vim.opt
local g = vim.g

g.mapleader = " "

opt.showmode = false

opt.clipboard = "unnamedplus"
opt.cursorline = true

-- Indent
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

-- Number
opt.number = true
opt.relativenumber = true

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Wildmode
opt.wildmode = "list:longest,list:full"

opt.termguicolors = true

-- add binaries installed by mason to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

-- Mappings
require("core.utils").load_mapping("base")
