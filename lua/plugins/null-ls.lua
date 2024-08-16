return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
	},
	config = function()
		require("mason-null-ls").setup({
			ensure_installed = { "ruff", "stylua", "prettierd", "eslint_d" },
		})

		local null_ls = require("null-ls")

		local code_actions = null_ls.builtins.code_actions
		local diagnostics = null_ls.builtins.diagnostics
		local formatting = null_ls.builtins.formatting
		local hover = null_ls.builtins.hover
		local completion = null_ls.builtins.completion

		null_ls.setup({
			sources = {
				-- formatting.black, -- python
				formatting.stylua, -- lua
				formatting.prettierd, -- many ...
				-- diagnostics.eslint_d, -- javascript, typescript
			},
		})
	end,
}
