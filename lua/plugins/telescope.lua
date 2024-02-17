-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
return {
  "nvim-telescope/telescope.nvim",
  branch = '0.1.x',
  event = "VeryLazy",
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  },
  config = function()
    local actions = require("telescope.actions")
    require('telescope').setup({
      extensions  = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
            -- even more opts
          },
        }
      },
      defaults = {
        prompt_prefix = "   ",
        initial_mode = "insert",
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
    })
    require("telescope").load_extension("ui-select")
    require('telescope').load_extension('fzf')
  end,
}
