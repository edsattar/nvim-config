return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = function()
      return {
        show_folds = false, -- Shows folds for sections in chat
        show_help = false, -- Shows help message as virtual lines when waiting for user input
        question_header = "  User ",
        answer_header = "  Copilot ",
        window = {
          width = 0.3,
        },
        selection = function(source)
          local select = require("CopilotChat.select")
          return select.visual(source) or select.line(source)
        end,
      }
    end,
    keys = {
      {
        "<leader>c",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle Copilot Chat",
        mode = { "n", "v" },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      require("CopilotChat.integrations.cmp").setup()

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      chat.setup(opts)
    end,
  },
}
