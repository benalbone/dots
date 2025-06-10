-- EDITOR SETTINGS --

-- disable netrw for nvim-tree

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- sets large cursor for edit mode
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

-- adds the bar on the right ------------------------------------------------>
vim.opt.colorcolumn = "80"

-- editor asthetic
vim.opt.termguicolors = true -- improves colours

-- sets colorscheme
-- vim.cmd.colorscheme "vague"
vim.cmd.colorscheme "catppuccin-mocha"

-- sets background to transparent using the term colour
vim.cmd [[
highlight Normal guibg=NONE
highlight NonText guibg=NONE
highlight Normal ctermbg=NONE
highlight NonText ctermbg=NONE
]]
