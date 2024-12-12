vim.g.mapleader = " "        -- Must happen before plugins are loaded
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true  -- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.icons_enabled = true
vim.g.loaded_netrw = 1       -- Disable netrw for neo-tree
vim.g.loaded_netrwPlugin = 1 -- Disable netrwPlugin for neo-tree
vim.g.markdown_recommended_style = 0
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_conceal_code_blocks = 0

-- plenary bug workaround
vim.fn.setenv("XDG_RUNTIME_DIR", "/tmp")

if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
  -- For Windows
  vim.g.undotree_DiffCommand = "FC"
end

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
