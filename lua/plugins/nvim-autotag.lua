return {
  'windwp/nvim-ts-autotag',
  -- ft = { 'html', 'vue', 'svelte', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  config = function()
    require('nvim-ts-autotag').setup()
  end,
}
