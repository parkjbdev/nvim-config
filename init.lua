local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

-- Setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Vim Settings
    { "vim-airline/vim-airline" },
    { "vim-airline/vim-airline-themes" },
    { "907th/vim-auto-save" },
    { "terryma/vim-smooth-scroll" },

    -- Exploring Files
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                actions = {
                    open_file = {
                        quit_on_open = true,
                    },
                },
            })
        end,
    },
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        lazy = false,
        keys = {
            -- Move to previous/next
            { '<A-,>',     '<Cmd>BufferPrevious<CR>' },
            { '<A-.>',     '<Cmd>BufferNext<CR>' },
            { '[b',        '<Cmd>BufferPrevious<CR>' },
            { ']b',        '<Cmd>BufferNext<CR>' },
            { '<A-Tab>',   '<Cmd>BufferNext<CR>' },
            -- Re-order to previous/next
            { '<A-<>',     '<Cmd>BufferMovePrevious<CR>' },
            { '<A->>',     '<Cmd>BufferMoveNext<CR>' },
            -- Goto buffer in position...
            { '<A-1>',     '<Cmd>BufferGoto 1<CR>' },
            { '<A-2>',     '<Cmd>BufferGoto 2<CR>' },
            { '<A-3>',     '<Cmd>BufferGoto 3<CR>' },
            { '<A-4>',     '<Cmd>BufferGoto 4<CR>' },
            { '<A-5>',     '<Cmd>BufferGoto 5<CR>' },
            { '<A-6>',     '<Cmd>BufferGoto 6<CR>' },
            { '<A-7>',     '<Cmd>BufferGoto 7<CR>' },
            { '<A-8>',     '<Cmd>BufferGoto 8<CR>' },
            { '<A-9>',     '<Cmd>BufferGoto 9<CR>' },
            { '<A-0>',     '<Cmd>BufferLast<CR>' },
            -- Pin/unpin buffer
            { '<A-p>',     '<Cmd>BufferPin<CR>' },
            -- Close buffer
            { '<A-w>',     '<Cmd>BufferClose<CR>' },
            -- Wipeout buffer
            --                 :BufferWipeout
            -- Close commands
            --                 :BufferCloseAllButCurrent
            --                 :BufferCloseAllButPinned
            --                 :BufferCloseAllButCurrentOrPinned
            --                 :BufferCloseBuffersLeft
            --                 :BufferCloseBuffersRight
            -- Magic buffer-picking mode
            { '<C-p>',     '<Cmd>BufferPick<CR>' },
            -- Sort automatically by...
            { '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>' },
            { '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>' },
            { '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>' },
            { '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>' },
        }
    },
    { "junegunn/fzf",          dir = "/opt/homebrew/opt/fzf", build = "./install --all" },
    {
        "junegunn/fzf.vim",
        keys = {
            { "<Leader>ff", ":Files<CR>" },
            { "<Leader>fr", ":Rg<CR>" },
            { "<Leader>ft", ":Tags<CR>" },
        },
    },

    -- Editing
    { "mg979/vim-visual-multi" },
    { "jiangmiao/auto-pairs" },
    { "tpope/vim-surround" },
    { "tpope/vim-commentary" },

    -- Git
    { "airblade/vim-gitgutter" },
    { "tpope/vim-fugitive" },

    -- THEMES
    {
        "bluz71/vim-nightfly-colors",
        name = "nightfly",
        lazy = false,
        priority = 1000
    },
    -- Plug 'sonph/onehalf', { 'rtp': 'vim/' }
    -- Plug 'bluz71/vim-moonfly-colors', {'as': 'moonfly'}
    -- Plug 'pacokwon/onedarkhc.vim'

    -- WEB
    { "leafOfTree/vim-matchtag" },

    -- C/C++
    {
        "mfussenegger/nvim-dap",
        keys = {
            { '<F5>',       function() require('dap').continue() end },
            { '<F10>',      function() require('dap').step_over() end },
            { '<F11>',      function() require('dap').step_into() end },
            { '<F12>',      function() require('dap').step_out() end },
            { '<Leader>b',  function() require('dap').toggle_breakpoint() end },
            { '<F8>',       function() require('dap').toggle_breakpoint() end },
            { '<Leader>B',  function() require('dap').set_breakpoint() end },
            { '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end },
            { '<Leader>dr', function() require('dap').repl.open() end },
            { '<Leader>dl', function() require('dap').run_last() end },
            { '<Leader>dh', function() require('dap.ui.widgets').hover() end, { 'n',
                'v' } },
            { '<Leader>dp', function() require('dap.ui.widgets').preview() end, { 'n',
                'v' } },
            { '<Leader>df', function() require('dap.ui.widgets').centered_float(widgets.frames) end },
            { '<Leader>ds', function() require('dap.ui.widgets').centered_float(widgets.scopes) end },
        },
        dependencies = {
            { "nvim-treesitter/nvim-treesitter", cmd = "TSUpdate" },
            { "theHamsta/nvim-dap-virtual-text", config = function() require("nvim-dap-virtual-text").setup() end },
            {
                "rcarriga/nvim-dap-ui",
                config = function() require("dapui").setup() end,
                dependencies = { { "ChristianChiarulli/neovim-codicons" } }
            },
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
            dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
            dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
            dap.adapters.cppdbg = {
                id = 'cppdbg',
                type = 'executable',
                command = '/home/parkjb/.cpptools/extension/debugAdapters/bin/OpenDebugAD7',
            }

            dap.configurations.cpp = {
                {
                    name = "Launch file",
                    type = "cppdbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopAtEntry = true,
                },
                {
                    name = 'Attach to gdbserver :1234',
                    type = 'cppdbg',
                    request = 'launch',
                    MIMode = 'gdb',
                    miDebuggerServerAddress = 'localhost:1234',
                    miDebuggerPath = '/usr/bin/gdb',
                    cwd = '${workspaceFolder}',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                },
            }
            dap.configurations.c = {
                {
                    name = "Launch file",
                    type = "cppdbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopAtEntry = true,
                },
                {
                    name = 'Attach to gdbserver :1234',
                    type = 'cppdbg',
                    request = 'launch',
                    MIMode = 'gdb',
                    miDebuggerServerAddress = 'localhost:1234',
                    miDebuggerPath = '/usr/bin/gdb',
                    cwd = '${workspaceFolder}',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                },
            }
        end
    },

    -- Flutter
    {
        'akinsho/flutter-tools.nvim',
        lazy = false,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
        config = true,
    },

    -- LSP
    { "neovim/nvim-lspconfig" },
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function() require("null-ls").setup() end
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls", "asm_lsp", "clangd", "rust_analyzer",
                    -- python
                    "pyright",
                    -- web
                    "emmet_language_server"
                },
                automatic_installation = true,
                handlers = {
                    function(server)
                        local capabilities = require("cmp_nvim_lsp").default_capabilities()
                        local lspconfig = require("lspconfig")
                        lspconfig[server].setup({ capabilities = capabilities })
                    end
                }
            })
        end
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "jose-elias-alvarez/null-ls.nvim"
        },
        config = function()
            local mason_null_ls = require("mason-null-ls")
            local null_ls = require("null-ls")
            local prettierd = {
                sources = {
                    null_ls.builtins.formatting.prettier.with({
                        filetypes = {
                            "javascript", "javascriptreact", "typescript", "typescriptreact",
                            "json", "yaml", "html", "css", "scss", "markdown", "vue"
                        }
                    }),
                },
                handler = function(source_name, methods)
                    mason_null_ls.default_setup(source_name, methods) -- to maintain default behavior
                end,
            }

            mason_null_ls.setup({
                automatic_installation = true,
                ensure_installed = {
                    "prettierd"
                },
                sources = {
                    prettierd.sources
                },
                handlers = {
                    prettierd = prettierd.handler
                },
            })
        end,
    },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "saadparwaiz1/cmp_luasnip" },
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },
    { "folke/neodev.nvim",    opts = {} },
    { "folke/lsp-colors.nvim" },
    {
        "folke/trouble.nvim",
        config = function() require("trouble").setup() end
    },

    -- Autocomplete
    {
        "zbirenbaum/copilot.lua",
        config = function()
            require("copilot").setup({
                suggestion = {
                    auto_trigger = true,
                },
            })
        end
    },

    -- Misc
    { "wakatime/vim-wakatime" },
})

--------------------------------------------------------------------------------------------------------------
-- LSP setup
--
local lspconfig = require('lspconfig')
lspconfig["tsserver"].setup({
    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end
})
--------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------
-- KEYMAPS
--
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Lsp mappings
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<space>k', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
        vim.keymap.set('n', '<space>qf', function()
            vim.lsp.buf.code_action({
                filter = function(a) return a.isPreferred end,
                apply = true
            })
        end, opts)
    end,
})
--------------------------------------------------------------------------------------------------------------

-- luasnip setup
local luasnip = require('luasnip')

local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

-- nvim-completion setup
local cmp = require('cmp')
local copilot = require('copilot.suggestion')
cmp.setup {
    snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
        ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
        -- C-b (back) C-f (forward) for snippet placeholder navigation.
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if copilot.is_visible() then
                require("copilot.suggestion").accept()
            elseif cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}

--------------------------------------------------------------------------------------------------------------
-- UI setup

-- DAP UI setup
vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#FF0000', bg = '#001C6D' })
vim.api.nvim_set_hl(0, 'DapBreakpointLine', { ctermbg = 0, bg = '#001C6D' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#001C6D' })
vim.api.nvim_set_hl(0, 'DapLogPointLine', { ctermbg = 0, bg = '#001C6D' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapStoppedLine', { ctermbg = 0, bg = '#31353f' })

vim.fn.sign_define('DapBreakpoint',
    { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpointLine', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition',
    { text = 'ﳁ', texthl = 'DapBreakpoint', linehl = 'DapBreakpointLine', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected',
    { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpointLine', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint',
    { text = '', texthl = 'DapLogPoint', linehl = 'DapLogPointLine', numhl = 'DapLogPoint' })
vim.fn.sign_define('DapStopped',
    { text = '', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = 'DapStopped' })

-- Theme
vim.g.nightflyVirtualTextColor = true
vim.diagnostic.config({
    underline = true,
})
vim.cmd [[colorscheme nightfly]]
--------------------------------------------------------------------------------------------------------------
