return {
  "jose-elias-alvarez/null-ls.nvim",
  config = function()
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
    local null_ls = require("null-ls")

    local diagnostics = null_ls.builtins.diagnostics
    local formatting = null_ls.builtins.formatting

    null_ls.setup({
      sources = {
        -- formatting.black,
        diagnostics.mypy,
        diagnostics.ruff.with({
          extra_args = { "--config", vim.fn.expand("~/.config/nvim/lua/plugins/null-ls/ruff.toml"),
          },
        }),
      }
    })
  end
}
