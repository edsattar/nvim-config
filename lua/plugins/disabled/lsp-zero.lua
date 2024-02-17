return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local lsp = require("lsp-zero").preset({})
        local lspconfig = require("lspconfig")

        lsp.set_server_config({
            -- single_file_support = false,
            capabilities = {
                textDocument = {
                    foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true
                    }
                }
            }
        })

        lsp.ensure_installed({
            "clangd",
            "lua_ls",
            "eslint",
            "tsserver",
            "jedi_language_server",
        })

        lspconfig.lua_ls.setup(lsp.nvim_lua_ls())


        lspconfig.tsserver.setup({
          on_attach = function(client, bufnr)
            client.resolved_capabilities.document_formatting = false
            lsp.default_keymaps({ buffer = bufnr })
          end
        })

        -- lspconfig.pylsp.setup({
        --   -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
        --   -- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
        --   settings = {
        --     pylsp = {
        --       plugins = {
        --         -- jedi = { environment = "./.venv/bin/python"},
        --         yapf = { enabled = false },     -- use ruff black
        --         autopep8 = { enabled = false }, -- use ruff black
        --         pyflakes = { enabled = false }, -- use ruff pyflakes
        --         -- E501 line too long
        --         pycodestyle = { ignore = { "E501", "E241", "W503" } },
        --       }
        --     }
        --   }
        -- })

        lsp.setup()
    end,
}
