-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-file-browser.nvim",                 -- file browser extension for telescope
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, --requires gcc or clang and make
    { "nvim-tree/nvim-web-devicons",              enabled = vim.g.have_nerd_font },
  },
  config = function()
    local tsc = require("telescope")
    local actions = require("telescope.actions")
    local actions_layout = require("telescope.actions.layout")
    local themes = require("telescope.themes")
    local fb_actions = require("telescope._extensions.file_browser.actions")
    tsc.setup({
      defaults = {
        initial_mode = "insert",
        layout_strategy = "flex",
        layout_config = {
          width = 0.95,
          height = 0.95,
          horizontal = {
            -- prompt_position = "top",
            preview_cutoff = 80,
            preview_width = 0.55,
          },
          vertical = {
            preview_height = 0.45,
          },
        },
        mappings = {
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.close,
            ["<M-p>"] = actions_layout.toggle_preview,
            ["<M-s>"] = actions.file_split,
            ["<M-v>"] = actions.file_vsplit,
          },
          n = {
            ["q"] = actions.close,
            ["<C-q>"] = actions.close,
            ["<M-p>"] = actions_layout.toggle_preview,
            ["s"] = actions.file_split,
            ["v"] = actions.file_vsplit,
          },
        },
        prompt_prefix = "   ",
        -- path_display = { "truncate" },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim",        -- trim the indentation at the beginning of presented line
          "--path-separator=/", -- fixes issue with folders with () in their name
        },
      },
      extensions = {
        ["ui-select"] = { themes.get_dropdown() },
        file_browser = {
          initial_mode = "normal",
          sorting_strategy = "ascending",
          grouped = true,
          mappings = {
            i = {
              ["<A-n>"] = fb_actions.create,
            },
            n = {
              c = false,
              n = fb_actions.create,
            },
          },
        },
      },
      pickers = {
        find_files = {
          find_command = {
            "fd",
            "--type=f",
            "--path-separator=/",
            "--hidden",
            "--no-ignore",
            "--exclude",
            ".git",
            "--exclude",
            ".next",
            "--exclude",
            "node_modules",
          },
        },
        buffers = {
          initial_mode = "normal",
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer,
            },
            n = {
              ["d"] = actions.delete_buffer,
            },
          },
        },
        grep_string = {
          initial_mode = "normal",
        },
      },
    })

    tsc.load_extension("file_browser")
    tsc.load_extension("ui-select")
    tsc.load_extension("fzf")
  end,
  keys = function()
    local tsc = require("telescope")
    local builtin = require("telescope.builtin")
    -- stylua: ignore
    local custom = {
      color_scheme = function() builtin.colorscheme({ enable_preview = true }) end,
      find_git_files = function() if not pcall(builtin.git_files) then builtin.find_files() end end,
      find_all_files = function() builtin.find_files({ hidden = true, no_ignore = true }) end,
      file_browser = function() tsc.extensions.file_browser.file_browser() end,
      neovim_files = function() builtin.find_files({ cwd = vim.fn.stdpath("config") }) end,
      find_all_words = function()
        builtin.live_grep({
          additional_args = function(args)
            return vim.list_extend(args, { "--hidden", "--no-ignore" })
          end,
        })
      end,
      find_in_buffer = function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          previewer = false,
        }))
      end,
      grep_open_files = function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        })
      end,
      select_find_command = function() -- Sets the executable for find_files based on if FD is found.
        local rg_command = {
          "rg",
          "--files",
          "--color=never",
          "--no-heading",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob",
          "!{.git/*,.svelte-kit/*,target/*,node_modules/*}, lua/user/*",
          "--path-separator",
          "/",
        }

        local fd_command = {
          "fd",
          "--type=f",
          "--color=never",
          "--path-separator=/",
          "--hidden",
          "--no-ignore",
          "--exclude",
          ".git",
          "--exclude",
          ".svelte-kit",
          "--exclude",
          "target",
          "--exclude",
          "node_modules",
        }

        local has_fd = vim.fn.executable("fd") or vim.fn.executable("fdfind")

        if has_fd == 0 then
          return rg_command
        else
          return fd_command
        end
      end,
    }
    require("which-key").add({ "<leader>s", group = "  Search" })
    return {
      { "<leader>sc", builtin.grep_string,    desc = "[c]ursor word search" },
      { "<leader>sb", builtin.buffers,        desc = "[b]uffers" },
      { "<leader>sC", builtin.commands,       desc = "[C]ommands" },
      { "<leader>sd", builtin.diagnostics,    desc = "[d]iagnostics" },
      { "<leader>se", custom.file_browser,    desc = "[e]xplorer, file" },
      { "<leader>sf", builtin.find_files,     desc = "[f]iles" },
      { "<leader>sF", custom.find_all_files,  desc = "[F]iles, all" },
      { "<leader>sg", builtin.git_commits,    desc = "[g]it commits" },
      { "<leader>sh", builtin.help_tags,      desc = "[h]elp" },
      { "<leader>sk", builtin.keymaps,        desc = "[k]eymaps" },
      { "<leader>sn", custom.neovim_files,    desc = "[n]vim files" },
      { "<leader>so", custom.grep_open_files, desc = "[o]pen files, search in" },
      { "<leader>sp", builtin.resume,         desc = "[p]revious search" },
      { "<leader>ss", builtin.builtin,        desc = "[s]elect telescope builtis" },
      { "<leader>st", custom.color_scheme,    desc = "[t]hemes" },
      { "<leader>sw", builtin.live_grep,      desc = "[w]ord" },
      { "<leader>sW", custom.find_all_words,  desc = "[W]ord in all files" },
      { "<leader>s'", builtin.marks,          desc = "['] marks" },
      { "<leader>s.", builtin.oldfiles,       desc = "[.] Recently opened Files" },
      { "<leader>s/", custom.find_in_buffer,  desc = "[/] fzf in current buffer" },
      { "<leader>s`", builtin.registers,      desc = "[`] registers" },
    }
  end,
}
