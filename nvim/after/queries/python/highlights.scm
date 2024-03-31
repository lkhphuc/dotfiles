;; extends

; Set highlight to @text otherwise will be highlighted as @string
; # %% [markdown] cell
((
  (comment) @_mdcomment
  . (expression_statement
      (string (string_content) @variable)))
  (#lua-match? @_mdcomment "^# %%%% %[markdown%]"))

