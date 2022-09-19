*&---------------------------------------------------------------------*
*&      Form  SPLIT_STRING
*&---------------------------------------------------------------------*
*       Split string
*----------------------------------------------------------------------*
FORM SPLIT_STRING  USING    pa_zpara-value type zparamallg-value.

types: begin of t_struct,
            matnr type c LENGTH 1,
         end of t_struct,

         t_struct_t type table of t_struct.

data: it_struct type t_struct_t,
      wa_struct like line of it_struct,

      is_empty type c LENGTH 1,
      is_count type i VALUE 0.

while not is_empty = zcl_const=>gc_x.

case pa_zpara-value+is_count(1).
  when ' '.
    is_empty = zcl_const=>gc_x.
  when ';'.
    is_count = is_count + 1.
  when others.
    wa_struct-matnr = pa_zpara-value+is_count(1).
    append wa_struct to it_struct.
    is_count = is_count + 1.
endcase.

endwhile.

ENDFORM.                    " SPLIT_STRING
