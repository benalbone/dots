-- REMAPS --
vim.g.mapleader = " "

-- move selected block text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- cursor positioning
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy to clipboard
vim.keymap.set('v', '<leader>y', '"+y', { noremap = true })
vim.keymap.set('n', '<leader>Y', '"+yg_', { noremap = true })
vim.keymap.set('n', '<leader>y', '"+y', { noremap = true })
vim.keymap.set('n', '<leader>yy', '"+yy', { noremap = true })

-- Paste from clipboard
vim.keymap.set('n', '<leader>p', '"+p', { noremap = true })
vim.keymap.set('n', '<leader>P', '"+P', { noremap = true })
vim.keymap.set('v', '<leader>p', '"+p', { noremap = true })
vim.keymap.set('v', '<leader>P', '"+P', { noremap = true })

-- turns Ctrl + C into Esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-------------------------------------------------------------------------------

-- EDITOR SETTINGS --
vim.opt.guicursor = ""

-- enables line number and relative line number
vim.opt.nu = true
vim.opt.relativenumber = true

-- spaces/tabs/indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- disables word wrap
vim.opt.wrap = false

-- stops vim making history/undofiles (mainly for undotree)
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- searching
vim.opt.hlsearch = false -- disables highlighting
vim.opt.incsearch = true -- enables incremental search

-- puts 8 lines between top and bottom of window whilst scrolling
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- changes to a fast update time
vim.opt.updatetime = 50

-- adds the bar on the right ----------------------------------------------->
vim.opt.colorcolumn = "80"

-- editor asthetic
vim.opt.termguicolors = true -- improves colours

-- sets background to transparent using the term colour
vim.cmd [[
highlight Normal guibg=NONE
highlight NonText guibg=NONE
highlight Normal ctermbg=NONE
highlight NonText ctermbg=NONE
]]

-------------------------------------------------------------------------------
