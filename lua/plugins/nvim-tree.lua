-- A File Explorer For Neovim Written In Lua
-- https://github.com/nvim-tree/nvim-tree.lua
return {
  "nvim-tree/nvim-tree.lua",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
  config = function()
    local nvimtree = require("nvim-tree")
    local function my_on_attach(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return {
          desc = "nvim-tree: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true
        }
      end

      -- default mappings --
      -- api.config.mappings.default_on_attach(bufnr)

      vim.keymap.set('n', '<C-]>',   api.tree.change_root_to_node,        opts('CD'))
      vim.keymap.set('n', '<C-[',    api.tree.change_root_to_parent,      opts('CD ..'))
      vim.keymap.set('n', 'q',       api.tree.close,                      opts('Close'))
      vim.keymap.set('n', '<Esc>',   api.tree.close,                      opts('Close'))
      vim.keymap.set('n', 'za',      api.tree.collapse_all,               opts('Collapse'))
      vim.keymap.set('n', 'c',       api.fs.copy.node,                    opts('Copy'))
      vim.keymap.set('n', 'yp',      api.fs.copy.absolute_path,           opts('Copy Absolute Path'))
      vim.keymap.set('n', 'yn',      api.fs.copy.filename,                opts('Copy Name'))
      vim.keymap.set('n', 'yr',      api.fs.copy.relative_path,           opts('Copy Relative Path'))
      vim.keymap.set('n', 'a',       api.fs.create,                       opts('Create File Or Directory'))
      vim.keymap.set('n', 'x',       api.fs.cut,                          opts('Cut'))
      vim.keymap.set('n', 'd',       api.fs.remove,                       opts('Delete'))
      vim.keymap.set('n', 'bd',      api.marks.bulk.delete,               opts('Delete Bookmarked'))
      vim.keymap.set('n', 'v',       api.node.open.vertical,              opts('Open: Vertical Split'))
      vim.keymap.set('n', 's',       api.node.open.horizontal,            opts('Open: Horizontal Split'))
      vim.keymap.set('n', '?',       api.tree.toggle_help,                opts('Help'))
      vim.keymap.set('n', 'gh',      api.node.show_info_popup,            opts('Info'))
      vim.keymap.set('n', 'J',       api.node.navigate.sibling.last,      opts('Goto Last Sibling'))
      vim.keymap.set('n', 'K',       api.node.navigate.sibling.first,     opts('Goto First Sibling'))
      vim.keymap.set('n', 'tF',      api.live_filter.clear,               opts('Live Filter: Clear'))
      vim.keymap.set('n', 'tf',      api.live_filter.start,               opts('Live Filter: Start'))
      vim.keymap.set('n', 'bm',      api.marks.bulk.move,                 opts('Move Bookmarked'))
      vim.keymap.set('n', '<CR>',    api.node.open.edit,                  opts('Open'))
      vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,           opts('Open'))
      vim.keymap.set('n', 'p',       api.fs.paste,                        opts('Paste'))
      vim.keymap.set('n', 'R',       api.tree.reload,                     opts('Refresh'))
      vim.keymap.set('n', 'r',       api.fs.rename_full,                  opts('Rename: Full Path'))
      vim.keymap.set('n', 'f',       api.tree.search_node,                opts('Search'))
      vim.keymap.set('n', 'bm',      api.marks.toggle,                    opts('Toggle Bookmark'))
      vim.keymap.set('n', 'td',      api.tree.toggle_hidden_filter,       opts('Toggle Filter: Dotfiles'))
      vim.keymap.set('n', 'tc',      api.tree.toggle_git_clean_filter,    opts('Toggle Filter: Git Clean'))
      vim.keymap.set('n', 'ti',      api.tree.toggle_gitignore_filter,    opts('Toggle Filter: Git Ignore'))
      vim.keymap.set('n', 'th',      api.tree.toggle_custom_filter,       opts('Toggle Filter: Hidden'))
      vim.keymap.set('n', 'tM',      api.tree.toggle_no_bookmark_filter,  opts('Toggle Filter: No Bookmark'))
    end

    nvimtree.setup({
      on_attach = my_on_attach,
      sort_by = "case_sensitive",
      view = { width = 25, },
      renderer = {
        group_empty = true,
        indent_markers = { enable = true, inline_arrows = false, },
      },
      git = { ignore = false },
      diagnostics = { enable = true },
    })
  end,
}
