*&---------------------------------------------------------------------*
*& Report ZDEMO_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDEMO_02.

data l_subrc type sy-subrc.
data alv type ref to zdisplay_alv.

create object alv.

CALL METHOD alv->show_alv
  EXPORTING
    i_dbname = 'ZDEMO1'
    i_repid = sy-repid
  changing
    c_subrc = l_subrc
    .
