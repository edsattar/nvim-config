return {
	"hrsh7th/nvim-cmp", -- https://github.com/hrsh7th/nvim-cmp
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- https://github.com/hrsh7th/cmp-nvim-lsp
		"hrsh7th/cmp-buffer", -- https://github.com/hrsh7th/cmp-buffer
		"hrsh7th/cmp-path", -- https://github.com/hrsh7th/cmp-path
		"hrsh7th/cmp-cmdline", -- https://github.com/hrsh7th/cmp-cmdline
		"petertriho/cmp-git", -- provide completions from git source https://github.com/petertriho/cmp-git
		"L3MON4D3/LuaSnip", -- Snippets plugin https://github.com/L3MON4D3/LuaSnip
		"onsails/lspkind-nvim", -- adds vscode-like pictograms https://github.com/onsails/lspkind-nvim
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- check if line is empty
		local check_backspace = function()
			local col = vim.fn.col(".") - 1
			return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
		end

		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local select_opts = { behavior = cmp.SelectBehavior.Select }
		cmp.setup({
			snippet = {
				expand = function(args)
					-- For `luasnip` users.
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "buffer" },
				{ name = "luasnip" },
				--   { name = 'cmdline' },
			},
			mapping = cmp.mapping.preset.insert({
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<C-k>"] = cmp.mapping.select_prev_item(select_opts),
				["<C-j>"] = cmp.mapping.select_next_item(select_opts),
				["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
				["<Tab>"] = cmp.mapping(
					-- If the line is "empty", insert a Tab character.
					-- If the completion menu is visible, move to the next item.
					-- If the cursor is inside a word, trigger the completion menu.
					function(fallback)
						if cmp.visible() then
							cmp.select_next_item(select_opts)
						elseif luasnip.expandable() then
							luasnip.expand()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif check_backspace() then
							fallback()
						else
							cmp.complete()
						end
					end,
					{ "i", "s" }
				),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = require("lspkind").cmp_format({
					mode = "symbol", -- show only symbol annotations
					maxwidth = 50, -- prevent the popup from showing more than provided characters
					ellipsis_char = "…", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
					menu = {
						buffer = "[Buf]",
						nvim_lsp = "[LSP]",
						luasnip = "[LuaSnip]",
						nvim_lua = "[Lua]",
						-- latex_symbols = "[Latex]",
					},
				}),
			},
		})
		-- -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})
		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
				{ name = "cmdline" },
			}),
		})
		-- Set configuration for specific filetype.
		-- You can specify the `git` source if installed
		-- (https://github.com/petertriho/cmp-git).
		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "git" },
				{ name = "buffer" },
			}),
		})
	end,
}
