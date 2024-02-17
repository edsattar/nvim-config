-- https://github.com/nvim-neo-tree/neo-tree.nvim
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()

    ---------- Keymaps ----------
    local map = require('utils').map
    map.n('<Leader>e', "<cmd>Neotree toggle<cr>", 'Toggle file explorer')

    require('neo-tree').setup {
      window = {
        position = "left",
        width = 20,
      }
    }
  end
}