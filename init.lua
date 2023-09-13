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
    { "junegunn/fzf",                 dir = "/opt/homebrew/opt/fzf", build = "./install --all" },
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

    -- Formatting
    -- Plug 'junegunn/vim-easy-align'
    { "vim-autoformat/vim-autoformat" },

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
    -- { "prettier/vim-prettier" },
    { "leafOfTree/vim-matchtag" },
    -- { 'valloric/matchtagalways' },
    -- { "mattn/emmet-vim" },
    -- Plug 'peitalin/vim-jsx-typescript'
    -- Plug 'leafgarland/typescript-vim'

    -- C/C++
    { "sakhnik/nvim-gdb" },

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
    --
    -- Snippets
    -- Plug 'SirVer/ultisnips'
    -- Plug 'honza/vim-snippets'

    -- LSP
    -- Plug 'w0rp/ale'
    -- Plug 'prabirshrestha/async.vim'
    -- Plug 'prabirshrestha/vim-lsp'
    -- Plug 'mattn/vim-lsp-settings'
    -- Plug 'prabirshrestha/asyncomplete.vim'
    -- Plug 'prabirshrestha/asyncomplete-lsp.vim'
    -- Plug 'keremc/asyncomplete-clang.vim'
    -- Plug 'ray-x/lsp_signature.nvim'
    { "neovim/nvim-lspconfig" },
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
                    "tsserver", "emmet_ls",
                },
                automatic_installation = true,
                handlers = {
                    function(server)
                        local capabilities = require("cmp_nvim_lsp").default_capabilities()
                        require("lspconfig")[server].setup({
                            capabilities = capabilities,
                        })
                    end
                }
            })
        end
    },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "saadparwaiz1/cmp_luasnip" },
    { "L3MON4D3/LuaSnip" },
    { "folke/neodev.nvim",       opts = {} },
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


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

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

-- luasnip setup
local luasnip = require('luasnip')

local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
    local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
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
            if copilot.is_visible() and cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            elseif copilot.is_visible() then
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

-- Theme setup
vim.g.nightflyVirtualTextColor = true
vim.diagnostic.config({
    underline = true,
})
vim.cmd [[colorscheme nightfly]]
