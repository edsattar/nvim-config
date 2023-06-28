vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.icons_enabled = true
_G.user_terminals = {}

require("lazy-nvim")
require('keymaps')
vim.cmd.colorscheme("rose-pine-moon")
require('options')

