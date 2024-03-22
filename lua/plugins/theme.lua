return {
	{
		-- "rose-pine/neovim",
		-- name = "rose-pine",
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
    config = function()
      vim.cmd.colorscheme("onedark")
    end,
	},
	-- { "rebelot/kanagawa.nvim", name = "kanagawa"},
	-- { "catppuccin/nvim",       name = "catppuccin" },
	-- { "folke/tokyonight.nvim", name = "tokyonight" }
}
