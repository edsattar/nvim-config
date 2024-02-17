-- A File Explorer For Neovim Written In Lua
-- https://github.com/nvim-tree/nvim-tree.lua
return {
  "nvim-tree/nvim-tree.lua",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
  config = function()
    local nvimtree = require("nvim-tree")
    local function my_on_attach(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return { 
          desc = "nvim-tree: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true
        }
      end

      -- default mappings --
      api.config.mappings.default_on_attach(bufnr)

      -- remove default mapping
      vim.keymap.del('n', 'g?', { buffer = bufnr })
      vim.keymap.del('n', '<C-v>', { buffer = bufnr })
      vim.keymap.del('n', '<C-x>', { buffer = bufnr })

      -- custom mappings
      vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
      vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
      vim.keymap.set('n', 'h', api.node.open.horizontal, opts('Open: Horizontal Split'))
      vim.keymap.set('n', '<Esc>', api.tree.close, opts('Close'))
      -- vim.keymap.set('n', '<Leader>e', api.tree.toggle, { desc = 'nvim-tree: Toggle' })
    end

    nvimtree.setup({
      on_attach = my_on_attach,
      sort_by = "case_sensitive",
      view = { width = 25, },
      renderer = {
        group_empty = true,
        indent_markers = { enable = true, inline_arrows = false, },
      },
      git = { ignore = false },
    })
  end,
}
