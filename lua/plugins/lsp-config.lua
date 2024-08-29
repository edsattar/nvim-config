-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/jay-babu/mason-null-ls.nvim#setup
return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "hrsh7th/cmp-nvim-lsp",           -- https://github.com/hrsh7th/cmp-nvim-lsp
    { "j-hui/fidget.nvim",            opts = {} }, -- Useful status updates for LSP.
    { "folke/neodev.nvim",            opts = {} }, -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
    { "pmizio/typescript-tools.nvim", dependencies = { "nvim-lua/plenary.nvim" } }, -- replacement for tsserver(slow)
  },
  config = function()
    vim.api.nvim_create_autocmd({ "LspAttach" }, {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local tsc = require("telescope.builtin")
        local n = require("utils").map.n
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd", tsc.lsp_definitions, "[d]efinition")
        map("gD", vim.lsp.buf.declaration, "[D]eclaration")
        map("ge", vim.diagnostic.open_float, "[e]rrors under cursor")
        map("gf", vim.lsp.buf.format, "[f]ormat")
        map("gi", tsc.lsp_implementations, "[I]mplementations")
        map("gm", tsc.lsp_references, "[M]entions")
        map("gr", vim.lsp.buf.rename, "[R]ename")
        map("gt", tsc.lsp_type_definitions, "[t]ype definition")
        map("gh", vim.lsp.buf.hover, "[H]over")
        map("ga", vim.lsp.buf.code_action, "[A]ction")
        n("]e", vim.diagnostic.goto_next, "Next diagnostic")
        n("[e", vim.diagnostic.goto_prev, "Previous diagnostic")

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
            end,
          })
        end

        -- The following autocommand is used to enable inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, "[T]oggle Inlay [H]ints")
        end
      end,
    })

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
            diagnostics = {
              disable = { "unused-local" },
              globals = { "vim" },
            },
          },
        },
      },
      -- tsserver = {
      --   capabilities = capabilities,
      --   on_attach = function(client, _)
      --     -- Disable tsserver formatting if you plan to use eslint_d
      --     client.resolved_capabilities.document_formatting = false
      --     client.resolved_capabilities.document_range_formatting = false
      --   end,
      -- },
      tailwindcss = {},
      emmet_language_server = {
        filetypes = { "html", "javascriptreact", "typescriptreact" },
      },
      -- ruff_lsp = {
      -- 	capabilities = capabilities,
      -- 	init_options = {
      -- 		settings = {
      -- 			-- Any extra CLI arguments for `ruff` go here.
      -- 			args = {},
      -- 		},
      -- 	},
      -- },
    }

    require("typescript-tools").setup({})


    require("mason").setup({
      ui = {
        icons = {
          package_installed = "󰄳",
          package_pending = "󰍶",
          package_uninstalled = "󰅙",
        },
      },
    })

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "stylua", -- Used to format Lua code
    })
    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })
  end,
}
