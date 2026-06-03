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

; imported names -> treated like declarations (blue)
(import_clause
  (identifier) @module.declaration) ; import X from "..."
(namespace_import
  (identifier) @module.declaration) ; import * as X
(import_specifier
  name: (identifier) @module.declaration) ; import { X }  (+ original of `X as Y`)
(import_specifier
  alias: (identifier) @module.declaration) ; import { X as Y }
