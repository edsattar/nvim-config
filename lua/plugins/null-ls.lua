  return {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = {
		"jay-babu/mason-null-ls.nvim",
	},
	config = function()
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
		local null_ls = require("null-ls")

		local code_actions = null_ls.builtins.code_actions
		local diagnostics = null_ls.builtins.diagnostics
		local formatting = null_ls.builtins.formatting
		local hover = null_ls.builtins.hover
		local completion = null_ls.builtins.completion

		null_ls.setup({
			sources = {
				formatting.black,
				formatting.prettier,
				-- diagnostics.mypy,
				-- diagnostics.ruff.with({
				--   extra_args = { "--config", vim.fn.expand("~/.config/nvim/lua/plugins/null-ls/ruff.toml"),
				--   },
				-- }),
			},
		})

		-- https://github.com/jay-babu/mason-null-ls.nvim#setup
		require("mason-null-ls").setup({
			ensure_installed = { "black", "prettier" },
			automatic_installation = true,
		})
	end,
}
