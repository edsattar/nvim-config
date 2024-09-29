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
					accept_word = "<M-l>",
					next = "<M-j>",
					prev = "<M-k>",
				},
			},
			filetypes = {
				yaml = true,
				markdown = true,
			},
		})
	end,
}
