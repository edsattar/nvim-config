return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable "make" == 1, build = "make" }
  },
  config = function()
    local actions = require "telescope.actions"
    require('telescope').setup {
      defaults = {
        prompt_prefix = "   ",
        initial_mode = "normal",
        path_display = { "truncate" },
        layout_strategy = "flex",
        layout_config = {
          horizontal = {
            -- prompt_position = "top",
            preview_cutoff = 80,
            preview_width = 0.55,
            width = 0.95,
            height = 0.80,
          },
          vertical = {
            width = 0.95,
            height = 0.95,
          },
        },
        mappings = {
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      }
    }
  end,
}
