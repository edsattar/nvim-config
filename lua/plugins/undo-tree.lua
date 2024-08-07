-- https://github.com/mbbill/undotree
return {
  "mbbill/undotree",
  event = "VeryLazy",
  keys = {
    {
      "<leader>u",
      vim.cmd.UndotreeToggle,
      desc = "toggle undotree view",
    },
  },
}
