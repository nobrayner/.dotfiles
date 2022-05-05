local api = vim.api
local ol = vim.opt_local
local bo = vim.bo

local TabSize = api.nvim_create_augroup('TabSize', { clear = true })
api.nvim_create_autocmd('FileType', {
  pattern = 'rust',
  group = TabSize,
  callback = function ()
    ol.expandtab = true
    bo.tabstop = 4
    bo.shiftwidth = 4
    bo.softtabstop = 4
  end,
})
