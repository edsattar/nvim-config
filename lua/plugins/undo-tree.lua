-- https://github.com/mbbill/undotree
return {
  "mbbill/undotree",
  event = "VeryLazy",
  config = function()
    local map = require("utils").map
    map.n("<Leader>u", vim.cmd.UndotreeToggle, "Toggle undo tree")
  end,
}
