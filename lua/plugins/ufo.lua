return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
    "VonHeikemen/lsp-zero.nvim", },
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
  end
}
