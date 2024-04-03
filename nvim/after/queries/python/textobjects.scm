; extends

; Code cells in percent format # %%
((comment) @cell_marker
  (#lua-match? @cell_marker "^# *%%%%"))


; ; doesn't work robustly for a cell with one node yet
; ; also for implicit beginning and and cells
((comment) @_marker
  . (_) @_start
  (_)*
  (_) @_end .
  (comment) @_marker
  (#lua-match? @_marker "^# *%%%%")
  (#make-range! "cell.inner" @_start @_end)
  )
; ((comment) @_marker1
;   . _? @_start
;   _*
;   _ @_end .
;   (comment) @_marker2
;   (#lua-match? @_marker1 "^# %%%%.*")
;   (#lua-match? @_marker2 "^# %%%%.*")
;   (#make-range! "cell.outer" @_marker1 @_end)
;   )
