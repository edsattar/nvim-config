vim.g.loaded_netrw = 1       -- Disable netrw for neo-tree
vim.g.loaded_netrwPlugin = 1 -- Disable netrwPlugin for neo-tree

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.icons_enabled = true
_G.user_terminals = {}


vim.g.markdown_recommended_style = 0
-- vim.g.vim_markdown_conceal = 2
-- vim.g.vim_markdown_conceal_code_blocks = 0

require("lazy-nvim")
require('keymaps')
require('options')
