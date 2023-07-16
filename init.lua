vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.icons_enabled = true
_G.user_terminals = {}


vim.g.vim_markdown_conceal = 2
vim.g.vim_markdown_conceal_code_blocks = 0

require("lazy-nvim")
require('keymaps')
vim.cmd.colorscheme("rose-pine-moon")
require('options')
