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

      local function keymap(key, action, desc)
        local opts = {
          desc = "nvim-tree: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true
        }
        vim.keymap.set("n", key, action, opts)
      end

      -- default mappings --
      -- api.config.mappings.default_on_attach(bufnr)

      keymap('<C-]>',   api.tree.change_root_to_node,        'CD')
      keymap('<C-[>',   api.tree.change_root_to_parent,      'CD ..')
      keymap('q',       api.tree.close,                      'Close')
      keymap('<Esc>',   api.tree.close,                      'Close')
      keymap('za',      api.tree.collapse_all,               'Collapse')
      keymap('c',       api.fs.copy.node,                    'Copy')
      keymap('yp',      api.fs.copy.absolute_path,           'Copy Absolute Path')
      keymap('yn',      api.fs.copy.filename,                'Copy Name')
      keymap('yr',      api.fs.copy.relative_path,           'Copy Relative Path')
      keymap('a',       api.fs.create,                       'Create File Or Directory')
      keymap('x',       api.fs.cut,                          'Cut')
      keymap('d',       api.fs.remove,                       'Delete')
      keymap('bd',      api.marks.bulk.delete,               'Delete Bookmarked')
      keymap('v',       api.node.open.vertical,              'Open: Vertical Split')
      keymap('s',       api.node.open.horizontal,            'Open: Horizontal Split')
      keymap('?',       api.tree.toggle_help,                'Help')
      keymap('gh',      api.node.show_info_popup,            'Info')
      keymap('J',       api.node.navigate.sibling.last,      'Goto Last Sibling')
      keymap('K',       api.node.navigate.sibling.first,     'Goto First Sibling')
      keymap('tF',      api.live_filter.clear,               'Live Filter: Clear')
      keymap('tf',      api.live_filter.start,               'Live Filter: Start')
      keymap('bm',      api.marks.bulk.move,                 'Move Bookmarked')
      keymap('<CR>',    api.node.open.edit,                  'Open')
      keymap('p',       api.fs.paste,                        'Paste')
      keymap('R',       api.tree.reload,                     'Refresh')
      keymap('r',       api.fs.rename_full,                  'Rename: Full Path')
      keymap('f',       api.tree.search_node,                'Search')
      keymap('bm',      api.marks.toggle,                    'Toggle Bookmark')
      keymap('td',      api.tree.toggle_hidden_filter,       'Toggle Filter: Dotfiles')
      keymap('tc',      api.tree.toggle_git_clean_filter,    'Toggle Filter: Git Clean')
      keymap('ti',      api.tree.toggle_gitignore_filter,    'Toggle Filter: Git Ignore')
      keymap('th',      api.tree.toggle_custom_filter,       'Toggle Filter: Hidden')
      keymap('tM',      api.tree.toggle_no_bookmark_filter,  'Toggle Filter: No Bookmark')
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

    local map = require("utils").map
    map.n("<Leader>e", vim.cmd.NvimTreeToggle, "Toggle file explorer")

  end,
}
