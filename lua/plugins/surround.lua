-- Add/delete/change surrounding pairs
-- Function calls and HTML tags out-of-the-box
-- Dot-repeat previous actions
return { -- https://github.com/kylechui/nvim-surround
  "kylechui/nvim-surround",
  event = "VeryLazy",
  config = function()
    -- Configuration here, or leave empty to use defaults
    -- https://github.com/kylechui/nvim-surround/blob/main/doc/nvim-surround.txt
    require("nvim-surround").setup({
    keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "S",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
    },
    aliases = {
        ["a"] = ">",
        ["b"] = ")",
        ["B"] = "}",
        ["r"] = "]",
        ["q"] = { '"', "'", "`" },
        ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
    },
    })
  end
}
