-- Add/delete/change surrounding pairs
-- Function calls and HTML tags out-of-the-box
-- Dot-repeat previous actions
return { -- https://github.com/kylechui/nvim-surround
  "kylechui/nvim-surround",
  event = "VeryLazy",
  config = function()
    -- Examples - https://github.com/kylechui/nvim-surround/blob/main/doc/nvim-surround.txt
    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
      -- Defaults - https://github.com/kylechui/nvim-surround/blob/main/lua/nvim-surround/config.lua
    })
  end
}
