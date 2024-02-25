-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/jay-babu/mason-null-ls.nvim#setup
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "󰄳",
					package_pending = "󰍶",
					package_uninstalled = "󰅙",
				},
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "tailwindcss", "tsserver", "emmet_language_server" },
		})

		local lspconfig = require("lspconfig")

		lspconfig.lua_ls.setup({})
		lspconfig.tsserver.setup({})
		lspconfig.tailwindcss.setup({})
		lspconfig.emmet_language_server.setup({
			filetypes = { "html", "javascriptreact", "typescriptreact" },

		})
	end,
}
