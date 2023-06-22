-- Add/delete/change surrounding pairs
-- Function calls and HTML tags out-of-the-box
-- Dot-repeat previous actions
return { -- https://github.com/kylechui/nvim-surround
  "kylechui/nvim-surround",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
    })
  end
}
