; extends

; The upstream ecma query tags every SCREAMING_CASE identifier as @constant,
; so usages of all-caps consts get colored. Recapture them as plain @variable
; (neutral). Placed before the declaration rules below so declaration/param
; sites still win and keep their color.
((identifier) @variable
  (#lua-match? @variable "^_*[A-Z][A-Z%d_]*$"))
((shorthand_property_identifier) @variable
  (#lua-match? @variable "^_*[A-Z][A-Z%d_]*$"))

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

; imported names -> treated like declarations (blue)
(import_clause
  (identifier) @module.declaration) ; import X from "..."
(namespace_import
  (identifier) @module.declaration) ; import * as X
(import_specifier
  name: (identifier) @module.declaration) ; import { X }  (+ original of `X as Y`)
(import_specifier
  alias: (identifier) @module.declaration) ; import { X as Y }

; type declarations -> pink
(class_declaration
  name: (identifier) @type.definition) ; class Foo {}
