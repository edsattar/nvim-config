vim.g.mapleader =
" "                          -- Set <space> as the leader key, Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true  -- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.icons_enabled = true
vim.g.loaded_netrw = 1       -- Disable netrw for neo-tree
vim.g.loaded_netrwPlugin = 1 -- Disable netrwPlugin for neo-tree
vim.g.markdown_recommended_style = 0
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_conceal_code_blocks = 0
vim.g.undotree_DiffCommand = "FC"

vim.filetype.add({
  pattern = {
    ["%.env%..*"] = "sh",
  },
})

_G.user_terminals = {}

require("options")
require("keymaps")
require("autocmds")
require("lazy-nvim")
