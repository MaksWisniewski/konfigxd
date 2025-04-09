return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        { "j-hui/fidget.nvim", config = true },
        { "folke/neodev.nvim", config = true }, -- Lua LSP for Neovim config
    },
    config = function()
        require("mason").setup()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend(
            "force",
            capabilities,
            require("cmp_nvim_lsp").default_capabilities()
        )

        require("mason-lspconfig").setup({
            automatic_installation = true,
            ensure_installed = {
                "lua_ls",
                "jedi_language_server",
                "basedpyright",
                "ruff",
                "clangd",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
                ["lua_ls"] = function()
                    require("lspconfig")["lua_ls"].setup({
                        settings = {
                            Lua = {
                                format = {
                                    enable = false,
                                },
                            },
                        },
                    })
                end,

                basedpyright = function()
                    require("lspconfig").basedpyright.setup({
                        settings = {
                            basedpyright = {
                                analysis = {
                                    diagnosticMode = "openFilesOnly",
                                    typeCheckingMode = "standard",
                                    stubPath = vim.fn.expand(
                                        "$HOME/.local/share/stubs"
                                    ),
                                    inlayHints = {
                                        callArgumentNames = true,
                                    },
                                },
                            },
                        },
                        on_attach = function(client, _)
                            client.server_capabilities.hoverProvider = false
                        end,
                    })
                end,

                ruff = function()
                    require("lspconfig")["ruff"].setup({
                        on_attach = function(client, _)
                            client.server_capabilities.renameProvider = false
                        end,
                    })
                end,

                ["jedi_language_server"] = function()
                    require("lspconfig").jedi_language_server.setup({
                        init_options = {
                            codeAction = {
                                nameExtractVariable = "Extract variable",
                                nameExtractFunction = "Extract function",
                            },
                            markupKindPreferred = "markdown",
                        },
                        on_attach = function(client, _)
                            client.server_capabilities.renameProvider = false
                        end,
                    })
                end,

                texlab = function()
                    require("lspconfig")["texlab"].setup({
                        settings = {
                            texlab = {
                                build = {
                                    executable = "latexrun",
                                },
                            },
                        },
                    })
                end,
            },
        })
    end,

    init = function()
        vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup(
                "kickstart-lsp-detach",
                { clear = true }
            ),
            callback = function(event2)
                vim.lsp.buf.clear_references()
            end,
        })
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup(
                "kickstart-lsp-attach",
                { clear = true }
            ),
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set(
                        "n",
                        keys,
                        func,
                        { buffer = event.buf, desc = "LSP: " .. desc }
                    )
                end

                map(
                    "gd",
                    require("telescope.builtin").lsp_definitions,
                    "Goto Definition"
                )
                map("gD", vim.lsp.buf.declaration, "Goto Declaration")
            end,
        })
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function() -- organise imports in go
                local params = vim.lsp.util.make_range_params()
                params.context = { only = { "source.organizeImports" } }
                local result = vim.lsp.buf_request_sync(
                    0,
                    "textDocument/codeAction",
                    params
                )
                for cid, res in pairs(result or {}) do
                    for _, r in pairs(res.result or {}) do
                        if r.edit then
                            local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding
                                or "utf-16"
                            vim.lsp.util.apply_workspace_edit(r.edit, enc)
                        end
                    end
                end
                vim.lsp.buf.format({ async = false })
            end,
        })
    end,
}
