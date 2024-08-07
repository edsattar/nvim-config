return {
  "luckasRanarison/tailwind-tools.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    conceal = {
      symbol = "…", -- 󱏿
    },
  },
  keys = {
    {
      "<A-x>",
      "<CMD>TailwindConcealToggle<CR>",
      desc = "Toggle Tailwind Conceal",
    },
  },
}
