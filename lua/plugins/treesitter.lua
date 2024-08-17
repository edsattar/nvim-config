-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
-- https://github.com/windwp/nvim-ts-autotag
-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
return {
	-- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects", -- Syntax aware text-objects, select, move, swap, and peek support.
    "nvim-treesitter/playground", -- Treesitter playground
    "hiphish/rainbow-delimiters.nvim", -- Rainbow parentheses
	},
	config = function()
		-- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		-- parser_config.dbml = {
		-- 	install_info = {
		-- 		url = "https://github.com/dynamotn/tree-sitter-dbml", -- local path or git repo
		-- 		files = { "src/parser.c"  }, -- note that some parsers also require src/scanner.c or src/scanner.cc
  --       branch = "main", -- default branch in case of git repo if different from master
		-- 		-- optional entries:
		-- 		requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
		-- 	},
		-- }
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"c",
				"css",
				"html",
				"java",
				"javascript",
				"json",
				"lua",
				"markdown",
				"python",
				"rust",
				"svelte",
				"tsx",
				"typescript",
				"vimdoc",
				"vim",
			},
			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,
			highlight = {
				enable = true,
				-- disable slow treesitter highlight for large files
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
			indent = { enable = true },
      playground = { enable = true },
		})
		-- vim.opt.foldmethod = 'expr'
		-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
	end,
}
