-- WhichKey is a lua plugin for Neovim 0.5 that
-- displays a popup with possible key bindings
-- of the command you started typing.
return {
	"folke/which-key.nvim",
	event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "echasnovski/mini.icons",

  },
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = function()
    local wk = require("which-key")
		wk.setup({
			icons = {
				separator = "", -- symbol used between a key and it's label
				group = "", -- symbol prepended to a group
        mappings = false,
			},
		})

		vim.cmd([[nmap ; <C-w>]]) -- Change ; to window commands

		-- Document existing key chains
    wk.add({
      { "<leader>b", group = "󰓩 Buffers" },
      { "<leader>g", group = "󰊢 Git" },
      { "<leader>t", group = " Terminal" }
    })
		-- require("which-key").register({
		-- 	b = { name = " 󰓩 Buffers" },
		-- 	g = { name = " 󰊢 Git" },
		-- 	l = { name = " 󰏖 Lazy" },
		-- 	t = { name = "  Terminal" },
		-- 	-- ["c"] = { name = "[C]ode", _ = "which_key_ignore" },
		-- 	-- ["d"] = { name = "[D]ocument", _ = "which_key_ignore" },
		-- 	-- ["r"] = { name = "[R]ename", _ = "which_key_ignore" },
		-- 	-- ["w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
		-- 	-- ['t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
		-- 	-- ["h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
		-- }, { prefix = "<Leader>" })
	end,
}
