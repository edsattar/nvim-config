return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			panel = {
				auto_refresh = false,
				keymap = {
					refresh = "gc",
				},
			},
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = "<M-cr>",
					accept_word = "<M-k>",
					accept_line = "<M-j>",
					next = "<M-l>",
					prev = "<M-h>",
				},
			},
			filetypes = {
				yaml = true,
				markdown = true,
			},
		})
	end,
}
