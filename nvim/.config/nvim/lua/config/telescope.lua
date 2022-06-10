require("telescope").setup({
  pickers = {
    buffers = {
      ignore_current_buffer = true,
      show_all_buffers = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",
        }
      }
    },
    find_files = {
      file_ignore_patterns = { 'node_modules/.*', '.git/.*' },
      hidden = true,
    },
  }
})

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>gc', '<cmd>Telescope git_commits<cr>')
