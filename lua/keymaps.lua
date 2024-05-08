-- https://neovim.io/doc/user/lua-guide.html#lua-guide-mappings

local utils = require("utils")
local is_available = utils.is_available
local map = utils.map

local sections = {
  b = { name = " 󰓩 Buffers" },
  g = { name = " 󰊢 Git" },
  l = { name = " 󰏖 Lazy" },
  t = { name = "  Terminal" },
}

-- disable arrow keys
map.niv("<Up>",    "")
map.niv("<Down>",  "")
map.niv("<Right>", "")
map.niv("<Left>",  "")
map.n("k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map.n("j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map.nv("H",           "0",                    "Move to the beginning of the line")
map.nv("L",           "$",                    "Move to the end of the line")
map.n( "J",           "<C-d>zz",              "Move down half page")
map.n( "K",           "<C-u>zz",              "Move up half page")
map.n( "n",           "nzz",                  "Center next match")
map.n( "N",           "Nzz",                  "Center previous match")
map.n( "]b",          ":bn<CR>",              "Next buffer")
map.n( "[b",          ":bp<CR>",              "Previous buffer")
map.n( "<Leader>bb",  ":bd<CR>",              "Delete buffer")
map.n( "<Leader>bn",  ":bn<CR>",              "Next buffer")
map.n( "<Leader>bv",  ":bp<CR>",              "Prev buffer")
map.n( "]t",          ":tabnext<CR>",         "Next tab")
map.n( "[t",          ":tabprevious<CR>",     "Previous tab")
map.v("p",            'p:let @+=@0<CR>:let @"=@0<CR>') -- Don't copy the replaced text after pasting in visual mode
map.v("<Leader>/",    [["hy:%s/<C-r>h/<C-r>h]], "Search and replace selected text")
map.n("<Leader>/",    ":%s/<C-r><C-w>/",      "Search and replace word under cursor")
map.n("vv",           "V",                    "Select whole line")
map.n("V",            "v$",                   "Select to end of line")
map.n("vaf",          "ggVG",                 "Select whole file")
map.n("yaf",          "ggVGy",                "Yank whole file")
map.nv("<Leader>y",   '"+y',                  "Yank to system clipboard")
map.nv("<Leader>pp",  '"+p',                  "Paste from system clipboard")
map.nv("<Leader>po",  '"*p',                  "Paste from selection clipboard")
map.n("<C-Up>",       ":hori res +1<CR>",     "Increase Window Height")
map.n("<C-Down>",     ":hori res -2<CR>",     "Decrease Window Height")
map.n("<C-Right>",    ":vert res +2<CR>",     "Increase Window Width")
map.n("<C-Left>",     ":vert res -2<CR>",     "Decrease Window Width")
map.n("<C-s>",        ":w<CR>",               "Save file")
map.i("<C-s>",        "<Esc>:w<CR>a",         "Save file")
map.n("<C-q>",        ":q<CR>",               "Quit")
map.n("<C-Q>",        ":qall<CR>",            "Quit All")
map.n("<A-j>",        ":m+1<CR>",             "Move line down")
map.n("<A-k>",        ":m-2<CR>",             "Move line up")
map.v("<A-j>",        ":m'>+1<CR>gv=gv",      "Move line down")
map.v("<A-k>",        ":m'<-2<CR>gv=gv",      "Move line up")
map.v("<A-h>",        "xhP`[v`]",             "Move selection left")
map.v("<A-l>",        "xp`[v`]",              "Move selection left")
map.n("<A-h>",        "J",                    "Join lines")
map.n("<A-z>",        utils.toggle_wrap,       "Toggle Wrap")
map.n("Q",          "@q", "Macro q")
map.n("[e",         vim.diagnostic.goto_prev, "Previous diagnostic",  "nvim-lspconfig")
map.n("]e",         vim.diagnostic.goto_next, "Next diagnostic",      "nvim-lspconfig")
map.n("<Leader>e",  ":Neotree toggle<CR>",    "Toggle file explorer", "neo-tree.nvim")
map.n("<Leader>e",  ":NvimTreeToggle<CR>",    "Toggle file explorer", "nvim-tree.lua")
map.n("<Leader>li", ":Lazy install<CR>",      "Plugins Install")
map.n("<Leader>ll", ":Lazy<CR>",              "Plugins Home")
map.n("<Leader>ls", ":Lazy sync<CR>",         "Plugins Sync")
map.n("<Leader>lc", ":Lazy check<CR>",        "Plugins Check Updates")
map.n("<Leader>lU", ":Lazy update<CR>",       "Plugins Update")
map.n("<Leader>lm", ":Mason<CR>",             "Mason Installer",      "mason.nvim")
map.n("<Leader>lp", ":LspInfo<CR>",           "LSP Info",             "nvim-lspconfig")
map.n("<Leader>u",  vim.cmd.UndotreeToggle,   "Toggle undo tree",     "undotree")

-- Telescope
if is_available("telescope.nvim") then
  sections.f = { name = " 󰍉 Find" }
  local tsc = require("telescope.builtin")
  local function tsc_find_git_files()
    if not pcall(tsc.git_files) then
      tsc.find_files()
    end
  end
  local function tsc_find_all_files() tsc.find_files({ hidden = true, no_ignore = true }) end
  local function tsc_find_all_words() tsc.live_grep({
      additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
    }) end
  local function tsc_color_scheme() tsc.colorscheme({ enable_preview = true }) end
  map.n("<Leader>gb",    tsc.git_branches,    "Git branches", "telescope.nvim")
  map.n("<Leader>gc",    tsc.git_commits,     "Git commits", "telescope.nvim")
  map.n("<Leader>gt",    tsc.git_status,      "Git status", "telescope.nvim")
  map.n("<Leader>f<CR>", tsc.resume,          "Resume previous search", "telescope.nvim")
  map.n("<Leader>f'",    tsc.marks,           "Find marks", "telescope.nvim")
  map.n("<Leader>fb",    tsc.buffers,         "Find buffers", "telescope.nvim")
  map.n("<Leader>fc",    tsc.grep_string,     "Find word under cursor", "telescope.nvim")
  map.n("<Leader>fC",    tsc.commands,        "Find commands", "telescope.nvim")
  map.n("<Leader>ff",    tsc_find_git_files,  "Find git files", "telescope.nvim")
  map.n("<Leader>fF",    tsc_find_all_files,  "Find files", "telescope.nvim")
  map.n("<Leader>fh",    tsc.help_tags,       "Find help", "telescope.nvim")
  map.n("<Leader>fk",    tsc.keymaps,         "Find keymaps", "telescope.nvim")
  map.n("<Leader>fm",    tsc.man_pages,       "Find man(manual) pages", "telescope.nvim")
  map.n("<Leader>fo",    tsc.oldfiles,        "Find opened(recently opened) files", "telescope.nvim")
  map.n("<Leader>fr",    tsc.registers,       "Find registers", "telescope.nvim")
  map.n("<Leader>ft",    tsc_color_scheme,    "Find themes", "telescope.nvim")
  map.n("<Leader>fw",    tsc.live_grep,       "Find word", "telescope.nvim")
  map.n("<Leader>fW",    tsc_find_all_words,  "Find word in all files", "telescope.nvim")
end

-- Comment.nvim
if is_available("Comment.nvim") then
  map.n("<C-_>", "<Plug>(comment_toggle_linewise_current)",        "Toggle comment")
  map.x("<C-_>", "<Plug>(comment_toggle_linewise_visual)",         "Toggle comment")
  map.i("<C-_>", "<Esc><Plug>(comment_toggle_linewise_current)a",  "Toggle comment")
end

map.n("<Leader>R", utils.run_file, "Run file")



-- Clear highlights

map.n("<Esc>",        ":noh <CR>")

-- -- Save and run Python file for Python buffers only
-- vim.cmd([[
--   autocmd FileType python nnoremap <buffer> <Leader>r :lua RunPython()
--   ]])
if is_available("which-key.nvim") then
  local wk = require("which-key")
  vim.cmd([[nmap ; <C-w>]])
  wk.register(sections, { prefix = "<Leader>" })
end
