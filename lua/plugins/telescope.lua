-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, --requires gcc or clang and make
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-tree/nvim-web-devicons",              enabled = vim.g.have_nerd_font },
  },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        prompt_prefix = "   ",
        initial_mode = "insert",
        -- path_display = { "truncate" },
        layout_strategy = "flex",
        layout_config = {
          horizontal = {
            -- prompt_position = "top",
            preview_cutoff = 80,
            preview_width = 0.55,
            width = 0.95,
            height = 0.80,
          },
          vertical = {
            width = 0.95,
            height = 0.95,
          },
        },
        mappings = {
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({
            -- even more opts
          }),
        },
      },
    })
    require("telescope").load_extension("ui-select")
    require("telescope").load_extension("fzf")

    -- See `:help telescope.builtin`

    local map = require("utils").map
    local tsc = require("telescope.builtin")

    local function tsc_find_git_files()
      if not pcall(tsc.git_files) then
        tsc.find_files()
      end
    end
    local function tsc_find_all_files()
      tsc.find_files({ hidden = true, no_ignore = true })
    end
    local function tsc_find_all_words()
      tsc.live_grep({
        additional_args = function(args)
          return vim.list_extend(args, { "--hidden", "--no-ignore" })
        end,
      })
    end
    local function tsc_color_scheme()
      tsc.colorscheme({ enable_preview = true })
    end
    local function tsc_current_buffer_fuzzy_find()
      tsc.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        previewer = false,
      }))
    end

    local function tsc_live_grep_open_files()
      tsc.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end
    local function tsc_find_neovim_files()
      tsc.find_files({ cwd = vim.fn.stdpath("config") })
    end

    map.n("<Leader>gb", tsc.git_branches, "Git branches")
    map.n("<Leader>gt", tsc.git_status, "Git status")
    map.n("<Leader>gc", tsc.git_commits, "Git commits")
    map.n("<Leader>s`", tsc.registers, "Search [`] registers")
    map.n("<Leader>s'", tsc.marks, "Search ['] marks")
    map.n("<Leader>s.", tsc.oldfiles, "Search [.] Recently opened Files")
    map.n("<Leader>s/", tsc_current_buffer_fuzzy_find, "[/] Fuzzily search in current buffer")
    map.n("<Leader>sb", tsc.buffers, "Search [b]uffers")
    map.n("<Leader>sc", tsc.grep_string, "Search word under [c]ursor")
    map.n("<Leader>sC", tsc.commands, "Search [C]ommands")
    map.n("<Leader>se", tsc.diagnostics, "Search [e]rrors")
    map.n("<Leader>sf", tsc_find_git_files, "Search [f]iles")
    map.n("<Leader>sF", tsc_find_all_files, "Search all [F]iles")
    map.n("<Leader>sh", tsc.help_tags, "Search [h]elp")
    map.n("<Leader>sk", tsc.keymaps, "Search [k]eymaps")
    map.n("<Leader>sn", tsc_find_neovim_files, "Search [n]eovim files")
    map.n("<Leader>so", tsc_live_grep_open_files, "Grep in [o]pen files")
    map.n("<Leader>sr", tsc.resume, "Search [r]esume")
    map.n("<Leader>ss", tsc.builtin, "Search [s]elect Telescope")
    map.n("<Leader>st", tsc_color_scheme, "Search [t]hemes")
    map.n("<Leader>sw", tsc.live_grep, "Search [w]ord")
    map.n("<Leader>sW", tsc_find_all_words, "Search [W]ord in all files")

    require("which-key").register({
      ["<Leader>s"] = { name = " 󰍉 [S]earch" },
    })
  end,
}
