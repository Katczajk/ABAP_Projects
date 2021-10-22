*&---------------------------------------------------------------------*
*& Report ZDEMO1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDEMO_01.

data: lt_zdemo1 type TABLE OF zdemo1,
      wa_zdemo1 type zdemo1,

      l_subrc type sy-subrc.

CONSTANTS gc_mandt type sy-mandt VALUE '001'.

PARAMETERS: l_znum type zdemo1-znummer,
            l_ztext type zdemo1-ztext LOWER CASE.

" break pilz.

check l_znum is not INITIAL or l_ztext is not INITIAL.


perform set_wa_data USING l_znum l_ztext CHANGING wa_zdemo1.

check wa_zdemo1 is not INITIAL.
append wa_zdemo1 to lt_zdemo1.

loop at lt_zdemo1 into wa_zdemo1.
  perform db_update using wa_zdemo1 CHANGING l_subrc.
endloop.




*&---------------------------------------------------------------------*
*& Form set_wa_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> L_ZNUM
*&      --> L_ZTEXT
*&      <-- WA_ZDEMO1
*&---------------------------------------------------------------------*
FORM set_wa_data  USING    p_znum type zdemo1-znummer
                           p_ztext type zdemo1-ztext
                  CHANGING pa_zdemo1 type zdemo1.

pa_zdemo1-mandt = gc_mandt.
pa_zdemo1-znummer = p_znum.
pa_zdemo1-ztext = p_ztext.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form db_update
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LT_ZDEMO1
*&---------------------------------------------------------------------*
FORM db_update  using pa_zdemo1 type zdemo1
                CHANGING p_subrc type sy-subrc.

update zdemo1 from pa_zdemo1.
data(p_msg) = 'aktualisiert.'.

if sy-subrc = 4.
  insert zdemo1 from pa_zdemo1.
  p_msg = 'eingetragen'.
endif.

write: / p_msg.
p_subrc = sy-subrc.

ENDFORM.
