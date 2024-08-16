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
  config = function ()
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_TreeNodeShape = ''
    vim.g.undotree_TreeVertShape = '│'
    vim.g.undotree_ShortIndicators = 1
  end
}
