local ls = require 'luasnip'
-- local snippet = ls.snippet
-- local sn = ls.snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local fmt = require'luasnip.extras.fmt'.fmt
-- local rep = require'luasnip.extras'.rep

-- Clears existing snippets when re-sourced
ls.cleanup()

ls.config.set_config {
  history = true,
  update_events = 'TextChanged,TextChangedI',
}

ls.add_snippets(nil, {
  all = {
    -- snippet('for', fmt([[
    --   for (let {} = 0; {} < {}; ++{}) {{
    --     {}
    --   }}
    -- ]], {
    --   i(1, 'i'),
    --   rep(1),
    --   i(2, '10'),
    --   rep(1),
    --   i(0),
    -- })),
  },
})

-- Jump forward key
vim.keymap.set({'i', 's'}, '<c-k>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- Jump back key
vim.keymap.set({'i', 's'}, '<c-j>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- Select between a list of choices for the current node
vim.keymap.set({'i', 's'}, '<c-l>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

vim.keymap.set('n', '<leader><leader><cr>', '<cmd>source ~/.config/nvim/lua/config/luasnip.lua<cr>')
