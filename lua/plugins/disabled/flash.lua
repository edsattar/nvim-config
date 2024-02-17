-- flash.nvim lets you navigate your code with search labels, 
-- enhanced character motions, and Treesitter integration.
-- https://github.com/folke/flash.nvim
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {},
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash", },
    -- @ahmed - clashes with surround-nvim,
    -- also I don't understand how it works
    -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter", },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash", },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Flash Treesitter Search", },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search", },
  },
}
