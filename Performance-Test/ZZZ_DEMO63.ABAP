*&---------------------------------------------------------------------*
*& Report  ZZZ_DEMO63
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zzz_demo63.


TYPES: BEGIN OF t_timer,
          mt1 TYPE sy-uzeit,
          mt2 TYPE sy-uzeit,
          mt3 TYPE sy-uzeit,
          mt4 TYPE sy-uzeit,
         END OF t_timer.


DATA timer TYPE t_timer.

CLEAR timer.

DATA: lt_mara   TYPE STANDARD TABLE OF mara,
      wa_mara   TYPE mara,
      lv_lines  TYPE i,
      lv_cnt    TYPE i,
      lv_diff   TYPE sy-uzeit.

SELECT * FROM mara INTO TABLE lt_mara.

CLEAR timer.
GET TIME.
MOVE sy-uzeit TO timer-mt1.

FIELD-SYMBOLS: <fs> TYPE mara.
ASSIGN wa_mara TO <fs>.
CHECK NOT sy-subrc <> 0.
LOOP AT lt_mara INTO <fs>.

  WRITE: / <fs>-matnr.

ENDLOOP.
GET TIME.
MOVE sy-uzeit TO timer-mt2.

GET TIME.
MOVE sy-uzeit TO timer-mt3.
DESCRIBE TABLE lt_mara LINES lv_lines.

WHILE NOT lv_lines = sy-index.
  CLEAR wa_mara.
  READ TABLE lt_mara INTO wa_mara INDEX sy-index.

  WRITE: / wa_mara-matnr.

ENDWHILE.
GET TIME.
MOVE sy-uzeit TO timer-mt4.


WRITE: / 'Messung 1', timer-mt1.
WRITE: / 'Messung 2', timer-mt2.
CLEAR lv_diff.
lv_diff = timer-mt2 - timer-mt1.
WRITE: / 'Differenz', lv_diff.
WRITE: / 'MEssung 3', timer-mt3.
WRITE: / 'Messung 4', timer-mt4.
CLEAR lv_diff.
lv_diff = timer-mt4 - timer-mt3.
WRITE: / 'Differenz', lv_diff.