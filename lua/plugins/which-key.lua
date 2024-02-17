-- WhichKey is a lua plugin for Neovim 0.5 that
-- displays a popup with possible key bindings
-- of the command you started typing.
return {
  "folke/which-key.nvim",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    icons = { 
      group = vim.g.icons_enabled and "" or "+", 
      separator = "" },
    -- disable = { filetypes = { "TelescopePrompt" } },
  }
}
