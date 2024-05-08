-- https://github.com/numToStr/Comment.nvim
return {
  'numToStr/Comment.nvim',
  event = "VeryLazy",
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring', -- A Neovim plugin for setting the commentstring option based on the cursor location in the file.
  },
  -- lazy = false,
  config = function()
    require('ts_context_commentstring').setup {
      enable_autocmd = false,
    }
    vim.g.skip_ts_context_commentstring_module = true
    require('Comment').setup {
      mappings = false,
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    }
  end
}
