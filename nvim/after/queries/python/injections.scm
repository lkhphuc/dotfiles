;extends

(module
  (expression_statement
    (string
      (string_start) @_comment_mark
      (string_content) @injection.content)
    )
  (#eq? @_comment_mark "\"\"\"")
  (#set! injection.language "markdown")
  )
