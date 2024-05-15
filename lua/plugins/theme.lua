return {
	"olimorris/onedarkpro.nvim",
	priority = 1000, -- Ensure it loads first

	init = function()
		vim.cmd.colorscheme("onedark")
	end,
}
-- "rose-pine/neovim",
-- name = "rose-pine",
-- { "rebelot/kanagawa.nvim", name = "kanagawa"},
-- { "catppuccin/nvim",       name = "catppuccin" },
-- { "folke/tokyonight.nvim", name = "tokyonight" }
