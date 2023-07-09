return {
  -- amongst your other plugins
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup {
      --   size = 20,
      open_mapping = [[<C-\>]],
      insert_mappings = true, -- mappings enabled in insert mode
      start_in_insert = true,
    }

  end
}
