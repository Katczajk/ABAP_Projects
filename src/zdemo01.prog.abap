*&---------------------------------------------------------------------*
*& Report ZDEMO01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDEMO01.

" here you see first abap 7.10 declaration
data number1 type i VALUE 5.
" changes with abap 7.40 the new declaration
data(number2) = 5.

" here we see some declaration inline at select statement
select single ztext from zdemo1 into @data(g_ztext).



" next is declaration for a table, thats normal
data it_zdemo01 type standard table of zdemo1.
" new is here to get a workarea from it_zdemo01 as inline declaration
loop at it_zdemo01 into data(wa_zdemo01).

ENDLOOP.


write: / number1, number2.
