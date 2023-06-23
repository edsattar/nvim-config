

vim.opt.autoindent = true     -- Autoindentation
vim.opt.cursorline = true     -- Highlight the text line of the cursor
vim.opt.backup = false        -- Number of space in a tab
vim.opt.breakindent = true    -- Wrap indent to match  line start
vim.opt.expandtab = true      -- Enable the use of space in tab
vim.opt.fillchars = { eob = " " } -- Disable `~` on nonexistent lines
vim.opt.hlsearch = false      -- Disable search highlight
vim.opt.incsearch = true      -- Incremental search
vim.opt.number = true         -- Show numberline
vim.opt.scrolloff = 10        -- Number of lines to keep above and below the cursor
vim.opt.shiftwidth = 2        -- Number of space inserted for indentation
vim.opt.smartindent = true    -- Smarter autoindentation
vim.opt.softtabstop = 2       -- Number of space in a tab
vim.opt.swapfile = false      -- Disable swapfile
vim.opt.tabstop = 2           -- Number of space in a tab
vim.opt.termguicolors = true  -- Enable 24-bit RGB colors
vim.opt.undofile = true       -- Enable persistent undo
vim.opt.wrap = false

-- The following sets Relative line numbering only 
-- in Normal mode, Absolute mode at other times
vim.cmd([[
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
  augroup END
]])
