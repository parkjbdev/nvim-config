return {
  { "Pocco81/auto-save.nvim", config = true },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     autoformat = false,
  --   },
  -- },
  -- { "karb94/neoscroll.nvim", config = true },
  {
    "rcarriga/nvim-notify",
    opts = {
      max_width = function()
        return math.floor(vim.o.columns * 0.4)
      end,
    },
  },
  { "mg979/vim-visual-multi" },
  { "wakatime/vim-wakatime" },
  { "rcarriga/nvim-notify" },
}
