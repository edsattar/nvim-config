return {
  "hrsh7th/nvim-cmp", -- https://github.com/hrsh7th/nvim-cmp
  dependencies = {
    {
      "L3MON4D3/LuaSnip", -- Snippets plugin https://github.com/L3MON4D3/LuaSnip
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
    },
    "hrsh7th/cmp-nvim-lsp", -- https://github.com/hrsh7th/cmp-nvim-lsp
    "hrsh7th/cmp-path",   -- https://github.com/hrsh7th/cmp-path
    "hrsh7th/cmp-buffer", -- https://github.com/hrsh7th/cmp-buffer
    "hrsh7th/cmp-cmdline", -- https://github.com/hrsh7th/cmp-cmdline
    "petertriho/cmp-git", -- provide completions from git source https://github.com/petertriho/cmp-git
    "onsails/lspkind-nvim", -- adds vscode-like pictograms https://github.com/onsails/lspkind-nvim
    "nvim-tree/nvim-web-devicons",
    "roobert/tailwindcss-colorizer-cmp.nvim",
    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cursor_at_end = function() -- check if line is empty
      local col = vim.fn.col(".") - 1
      return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
    end
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local select_opts = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = "menu,menuone,noinsert" },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "luasnip" },
        { name = "buffer" },
        --   { name = 'cmdline' },
      },
      -- read `:help ins-completion`
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
        ["<C-n>"] = cmp.mapping.select_next_item(select_opts),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        -- ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item(select_opts)
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.locally_jumpable() then
            luasnip.jump()
          elseif cursor_at_end() then
            fallback()
          else
            cmp.complete()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item(select_opts)
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      formatting = {
        expandable_indicator = true,
        fields = { "kind", "abbr", "menu" },
        format = require("lspkind").cmp_format({
          mode = "symbol", -- show only symbol annotations
          maxwidth = 50, -- prevent the popup from showing more than provided characters
          ellipsis_char = "…", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
          menu = {
            buffer = "[Buf]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            -- latex_symbols = "[Latex]",
          },
          before = require("tailwind-tools.cmp").lspkind_format,
        }),
      },
    })

    require("luasnip.loaders.from_vscode").lazy_load()
    -- -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" },
      }),
    })
    -- Set configuration for specific filetype.
    -- You can specify the `git` source if installed
    -- (https://github.com/petertriho/cmp-git).
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" },
        { name = "buffer" },
      }),
    })
    require("cmp_git").setup()
  end,
}
