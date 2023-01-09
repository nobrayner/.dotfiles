require 'todo-comments'.setup {
  signs = false,
  keywords = {
    FIXME = {
      icon = ' ',
      color = 'error',
      alt = { 'BUG' },
    },
    TODO = {
      icon = ' ',
      color = 'info',
    },
    PICKUP = {
      icon = '喇',
      color = 'warning',
    },
  },
  highlight = {
    multiline = false,
    before = 'fg',
    keyword = 'wide_bg',
    after = 'fg',
    pattern = [[\s(KEYWORDS)\s*:]],
    comments_only = true,
    exclude = {},
  },
  colors = {
    error = { 'DiagnosticError', 'ErrorMsg' },
    warning = { 'DiagnosticWarning', 'WarningMsg' },
    info = { 'Comment' },
  },
  search = {
    command = 'rg',
    args = {
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
    },
    pattern = [[\b(KEYWORDS):]],
  },
}

vim.keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>')
