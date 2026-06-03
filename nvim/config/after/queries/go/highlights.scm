; extends

; Short variable declarations:  x := ...
(short_var_declaration
  left: (expression_list
    (identifier) @variable.declaration))

; var declarations:  var x = ...  /  var x T
(var_spec
  name: (identifier) @variable.declaration)

; const declarations
(const_spec
  name: (identifier) @variable.declaration)

; function parameters (declarations of a sort — optional, see note)
(parameter_declaration
  name: (identifier) @variable.declaration)

; package *name* (not the `package` keyword) -> blue, like a declaration.
; Scoped to package_clause so import aliases stay neutral.
(package_clause
  (package_identifier) @module.declaration)

; make `defer` glaringly obvious -> rendered in the comment style (shaded box)
(defer_statement
  "defer" @keyword.defer)
