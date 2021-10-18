*&---------------------------------------------------------------------*
*& Report ZDEMO01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDEMO01.

" old before 7.40
data number1 type i VALUE 5.
" new after 7.40
data(number2) = 5.


" old before 7.40
data: g_ztext1 like zdemo1-ztext.
select single ztext from zdemo1 into g_ztext1.

" new after 7.40
select single ztext from zdemo1 into @data(g_ztext).


" old before 7.40
data it_zdemo011 type standard table of zdemo1.
data wa_zdemo011 TYPE zdemo1.

loop at it_zdemo011 into wa_zdemo011.

ENDLOOP.

" new after 7.40
data it_zdemo01 type standard table of zdemo1.
loop at it_zdemo01 into data(wa_zdemo01).

ENDLOOP.

" inline declaration
data(g_subrc) = sy-subrc.
perform some_form CHANGING g_subrc.

" old form of declaration
data la_zdemo11 type ref to zdemo1.
FIELD-SYMBOLS <fs1> type zdemo1.
CREATE DATA la_zdemo11.
ASSIGN la_zdemo11->* to <fs1>.

"new form of declaration
data la_zdemo1 type ref to zdemo1.
CREATE DATA la_zdemo1.
ASSIGN la_zdemo1->* to FIELD-SYMBOL(<fs>).

write: / number1, number2.

zmessage=>altert_db_not_found( dbname = 'ZDEMO1' ).







*&---------------------------------------------------------------------*
*& Form some_form
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- l_subrc
*&---------------------------------------------------------------------*
FORM some_form  CHANGING l_subrc TYPE sy-subrc.

  " also a inline declaration
  data(p_subrc) = sy-subrc.
  l_subrc = p_subrc.

ENDFORM.
