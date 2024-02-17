-- editor folding
-- https://github.com/kevinhwang91/nvim-ufo
return {
  "kevinhwang91/nvim-ufo",
  event = "VeryLazy",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  config = function()
    local ftMap = {
      vim = 'indent',
      python = { 'indent' },
      git = ''
    }
    require('ufo').setup({
      open_fold_hl_timeout = 150,
      provider_selector = function(bufnr, filetype, buftype)
        -- if you prefer treesitter provider rather than lsp,
        return ftMap[filetype] or {'treesitter', 'indent'}
        -- return ftMap[filetype]

        -- refer to ./doc/example.lua for detail
      end
    })
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)


    -- -- for ufo.nvim
    -- vim.opt.foldcolumn = '1'   -- '0' is not bad
    -- vim.opt.foldlevel = 99     -- Using ufo provider need a large value 
    -- vim.opt.foldlevelstart = -1
    -- vim.opt.foldenable = true
  end
}
