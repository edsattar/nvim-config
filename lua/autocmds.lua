-- [[ Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

-- Remember folds
local remember_folds = vim.api.nvim_create_augroup("remember_folds", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
  pattern = "*.*",
  group = remember_folds,
  command = "if &ft !=# 'help' | mkview | endif",
})
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = "*.*",
  group = remember_folds,
  command = "if &ft !=# 'help' | silent! loadview | endif",
})

