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




write: / number1, number2.
