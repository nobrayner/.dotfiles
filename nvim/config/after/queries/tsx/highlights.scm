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

; imported names -> treated like declarations (blue); also covers `import type {}`
(import_clause
  (identifier) @module.declaration) ; import X from "..."
(namespace_import
  (identifier) @module.declaration) ; import * as X
(import_specifier
  name: (identifier) @module.declaration) ; import { X }  (+ original of `X as Y`)
(import_specifier
  alias: (identifier) @module.declaration) ; import { X as Y }

; type declarations -> pink
(type_alias_declaration
  name: (type_identifier) @type.definition) ; type Foo = ...
(interface_declaration
  name: (type_identifier) @type.definition) ; interface Foo {}
(class_declaration
  name: (type_identifier) @type.definition) ; class Foo {}
(abstract_class_declaration
  name: (type_identifier) @type.definition) ; abstract class Foo {}
(enum_declaration
  name: (identifier) @type.definition) ; enum Foo {}
