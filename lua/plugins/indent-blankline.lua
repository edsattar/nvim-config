  -- See `:help indent-blankline` ┆¦ █ ┃
return {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    require("indent_blankline").setup {
      char = '',
      --context_char = '+',
      show_current_context = true
    }
  end,
}
