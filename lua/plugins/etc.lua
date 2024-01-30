return {
  {
    "okuuva/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        execution_message = {
          enabled = false,
        },
      })
    end,
  },
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
}
