return {
  "jay-babu/mason-null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "nvimtools/none-ls.nvim",
  },
  config = function()
    require("mason-null-ls").setup({
      ensure_installed = { "ruff", "stylua", "prettier", "eslint_d" },
      automatic_installation = true,
    })

    local null_ls = require("null-ls")

    -- local code_actions = null_ls.builtins.code_actions
    -- local diagnostics = null_ls.builtins.diagnostics
    local formatting = null_ls.builtins.formatting
    -- local hover = null_ls.builtins.hover
    -- local completion = null_ls.builtins.completion

    null_ls.setup({
      sources = {
        formatting.black, -- python
        -- formatting.biome.with({
        --   filetypes = {
        --   },
        -- }),
        formatting.prettier,
        -- formatting.prettierd.with({
        --   filetypes = {
        --     "astro",
        --     "graphql",
        --     "json",
        --     "jsonc",
        --     "svelte",
        --     "vue",
        --     "css",
        --     "handlebars",
        --     "html",
        --     "htmlangular",
        --     "javascript",
        --     "javascriptreact",
        --     "less",
        --     "markdown",
        --     "markdown.mdx",
        --     "scss",
        --     "typescript",
        --     "typescriptreact",
        --     "yaml",
        --   },
        -- }),
        formatting.stylua, -- lua
        -- diagnostics.eslint_d, -- javascript, typescript
      },
    })

    vim.keymap.set("n", "<leader>fn", "<CMD>NullLsInfo<CR>", { noremap = true, silent = true, desc = "NullLs Info" })
  end,
}
