; extends

; let / const / var declarations
(variable_declarator
  name: (identifier) @variable.declaration)

; destructuring: const { a, b } = ...
(object_pattern
  (shorthand_property_identifier_pattern) @variable.declaration)
(object_pattern
  (pair_pattern
    value: (identifier) @variable.declaration))

; destructuring: const [a, b] = ...
(array_pattern
  (identifier) @variable.declaration)

; function parameters
(formal_parameters
  (identifier) @variable.declaration)
(required_parameter
  (identifier) @variable.declaration)
