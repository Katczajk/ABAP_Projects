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

write: / number1, number2.
