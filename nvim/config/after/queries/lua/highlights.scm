; extends

; local x = ...  /  local x, y = ...  /  local x
(variable_declaration
  (assignment_statement
    (variable_list
      (identifier) @variable.declaration)))

; global assignments:  x = 1   /   x, y = 1, 2
(assignment_statement
  (variable_list
    (identifier) @variable.declaration))

; numeric for:  for i = 1, 10 do
(for_statement
  (for_numeric_clause
    name: (identifier) @variable.declaration))

; generic for:  for k, v in pairs(t) do
(for_statement
  (for_generic_clause
    (variable_list
      (identifier) @variable.declaration)))

; function parameters
(parameters
  (identifier) @variable.declaration)

; function f() end  /  local function f() end
(function_declaration
  name: (identifier) @variable.declaration)
