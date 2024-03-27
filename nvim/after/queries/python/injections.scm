;extends

; # %% [markdown] 
; """
; Highlighting this region for this kind of cell
; """
(module
  (expression_statement
    (string
      (string_start) @_comment_mark
      (string_content) @injection.content)
    )
  (#eq? @_comment_mark "\"\"\"")
  (#set! injection.language "markdown")
  )

; proper capture but not supported offset yet
; ((comment) @_cell_marker
;   . (comment)+ @injection.content
;   . (comment) @_cell_end
;   (#lua-match? @_cell_end "^# *%%%%")
;   (#lua-match? @_cell_marker "^# *%%%% *%[markdown%]")
;   (#not-lua-match? @injection.content "^# *%%%%")
;   (#set! injection.language "markdown")
;   ; (#offset! @injection.content 0 1 0 0)
;   )
