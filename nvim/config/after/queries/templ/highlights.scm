; extends

; templ paints two things blue that the theme reserves for *declarations*:
;   1. component renders  -> `component_import` reuses @function (same as a
;      `templ X` declaration), but a render is a call, so recapture as a call.
;   2. embedded `{ go }`  -> the whole `expression` node is @function.method.
;      Neutralize the wrapper; the inner Go nodes keep their own captures
;      (calls -> @function.method.call, strings -> @string, etc).
(component_import
  name: (component_identifier) @function.call)

[
  (expression)
  (dynamic_class_attribute_value)
] @none
