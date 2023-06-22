return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    "windwp/nvim-ts-autotag",
    "JoosepAlviste/nvim-ts-context-commentstring"
  },
  config = function()
    require('nvim-treesitter.configs').setup {
      highlight = {
        enable = true,
        disable = function(_, bufnr) return vim.api.nvim_buf_line_count(bufnr) > 10000 end,
      },
      indent = { enable = true },
      autotag = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
      ensure_installed = {
        "bash",
        "c",
        "html",
        "javascript",
        "json",
        'lua',
        'markdown',
        'python',
        'rust',
        'tsx',
        'typescript',
        'vimdoc',
        'vim'
      },
    }
    -- vim.opt.foldmethod = 'expr'
    -- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
  end
}
