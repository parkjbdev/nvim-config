-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")
local map = Util.safe_keymap_set

map('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
map('n' ,'<leader>fb', '<cmd>Telescope buffers<cr>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')

map("n", "<leader>vk", function()
  local handle = io.popen("${HOME}/vms/vox -k")
  handle:close()
end, { desc = "vox kill" })

map("n", "<leader>vs", function()
  local handle = io.popen("${HOME}/vms/vox -s 0")
  handle:close()
end, { desc = "vox signal" })
