require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "asm_lsp",
        "clangd",
        "rust_analyzer",
        -- python
        "pyright",
        -- web
        "emmet_language_server",
    },
    automatic_installation = true,
    handlers = {
        function(server)
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            lspconfig[server].setup({ capabilities = capabilities })
        end,
    },
})

require("mason-nvim-dap").setup({
    automatic_installation = true,
    ensure_installed = {
        "cpptools",
    },
    handlers = {
        function(config)
            require("mason-nvim-dap").default_setup(config)
        end,
    },
})
