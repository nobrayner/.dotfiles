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

; function parameters (TS uses required_parameter / optional_parameter wrapping)
(required_parameter
  pattern: (identifier) @variable.declaration)
(optional_parameter
  pattern: (identifier) @variable.declaration)
