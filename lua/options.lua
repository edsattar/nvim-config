-- [[ Setting options ]]
-- See `:help vim.opt`
-- For more options see `:help option-list`

vim.opt.autoindent = true         -- Autoindentation
vim.opt.backup = false            -- Number of space in a tab
vim.opt.breakindent = true        -- Wrap indent to match line start
vim.opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.
vim.opt.cursorline = true         -- Highlight the text line of the cursor
vim.opt.expandtab = true          -- Enable the use of space in tab
vim.opt.fillchars = { eob = " " } -- Disable `~` on nonexistent lines
vim.opt.foldcolumn = "1"          -- '0' is not bad
vim.opt.foldenable = true         -- enable fold for nvim-ufo
vim.opt.foldlevel = 99            -- set high foldlevel for nvim-ufo
vim.opt.foldlevelstart = 99       -- start with all code unfolded
vim.opt.hlsearch = true           -- Enable search highlight
vim.opt.ignorecase = true         -- Case-insensitive searching
-- vim.opt.inccommand = 'split'      -- Show live preview of :s command
vim.opt.incsearch = true          -- Incremental search
vim.opt.list = true               -- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.number = true             -- Make line numbers default
vim.opt.scrolloff = 10            -- Number of lines to keep above and below the cursor
vim.opt.shiftwidth = 0            -- number of space inserted for indentation; when zero the 'tabstop' value will be used
vim.opt.showmode = false          -- Don't show the mode, since it's already in the status line
-- vim.opt.signcolumn = 'yes'        -- Always show the signcolumn
vim.opt.smartcase = true          -- Override 'ignorecase' if the search pattern contains uppercase characters
vim.opt.smartindent = true        -- Smarter autoindentation
vim.opt.softtabstop = 2           -- Number of space in a tab
vim.opt.splitright = true         -- Configure how new splits should be opened
vim.opt.splitbelow = true         -- Configure how new splits should be opened
vim.opt.swapfile = false          -- Disable swapfile
vim.opt.tabstop = 2               -- Number of space in a tab
vim.opt.termguicolors = true      -- Enable 24-bit RGB colors
vim.opt.timeoutlen = 300          -- Decrease mapped sequence wait time, Displays which-key popup sooner
vim.opt.undofile = true           -- Enable persistent undo
vim.opt.updatetime = 250          -- Decrease update time
vim.opt.wrap = false              -- Wrapping of lines longer than the width of window

vim.opt.conceallevel = 0          -- Disable concealing
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- The following sets Relative line numbering only
-- in Normal mode, Absolute mode at other times
vim.cmd([[
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
  augroup END
]])
