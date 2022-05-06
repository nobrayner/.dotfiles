local M = {}

function M.load(module)
  package.loaded[module] = nil

  require(module)
end

return M
