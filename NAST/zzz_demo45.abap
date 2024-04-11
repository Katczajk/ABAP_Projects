*&---------------------------------------------------------------------*
*& Report  ZZZ_DEMO45
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZZZ_DEMO45.

tables: nast.

types: begin of t_msg,
            MSG_ARBGB like sy-msgid,
            MSG_NR like sy-msgno,
            MSG_TY like sy-msgty,
            MSG_V1 like sy-msgv1,
            MSG_V2 like sy-msgv2,
            MSG_V3 like sy-msgv3,
            MSG_V4 like sy-msgv4,
        end of t_msg,

        t_nast type nast,
        t_nast_t type STANDARD TABLE OF nast.


data: it_nast type t_nast_t,
      wa_nast type t_nast,
      i_nast type nast,
      e_nast type nast,
      i_rcode type sy-subrc,
      i_msg type t_msg,
      lv_kappl type nast-kappl,
      lv_objky type nast-objky,
      lv_kschl type nast-kschl,
      lv_erdat type nast-erdat.



SELECTION-SCREEN BEGIN OF BLOCK a01.

  select-OPTIONS: s_kappl for lv_kappl,
                  s_objky for lv_objky,
                  s_kschl for lv_kschl,
                  s_erdat for lv_erdat.


SELECTION-SCREEN END OF BLOCK a01.


break pilz.

perform get_nast_entries CHANGING it_nast.

perform remove_duplicate_entries CHANGING it_nast.

perform prepare_nast_entries CHANGING it_nast.

perform update_nast_table CHANGING it_nast.

perform print_nast_entries CHANGING it_nast.

break pilz.






FORM COPY_NAST_MSG  USING    i_nast type nast
                    CHANGING e_nast type nast.


  if not i_nast is initial.

    move i_nast to e_nast.
    e_nast-erdat = sy-datum.
    e_nast-eruhr = sy-uzeit.
    " Bist du verarbeitet -> 0 (nein)
    e_nast-vstat = '0'.
    "Versandzeitpunkt - 1 durch App
    e_nast-vsztp = '1'.
    e_nast-ldest = 'LP02'.
    e_nast-dimme = zcl_const=>gc_x.
    "TDARMOD - 1 Drucken / 2 Ablegen / 3 Drucken & Ablegen
    e_nast-tdarmod = '3'.
    clear: e_nast-datvr, e_nast-uhrvr.

  endif.

ENDFORM.                    " COPY_NAST_MSG

FORM REMOVE_DUPLICATE_ENTRIES  CHANGING et_nast type t_nast_t.

sort et_nast DESCENDING by objky erdat eruhr.
delete adjacent duplicates from et_nast comparing objky.

ENDFORM.                    " REMOVE_DUPLICATE_ENTRIES

FORM prepare_NAST_ENTRIES  CHANGING et_nast type t_nast_t.

data: e_nast type t_nast.

loop at et_nast into e_nast.

  move e_nast to i_nast.

  perform copy_nast_msg using i_nast CHANGING e_nast.

  modify et_nast from e_nast.

endloop.

ENDFORM.                    " PRINT_NAST_ENTRIES

FORM PRINT_NAST_ENTRIES  CHANGING et_nast type t_nast_t.

data: e_nast type t_nast.

loop at et_nast into e_nast.

  clear: nast.
  move e_nast to nast.
  perform einzelnachricht(rsnast00) using i_rcode.

endloop.

ENDFORM.                    " PRINT_NAST_ENTRIES
*&---------------------------------------------------------------------*
*&      Form  UPDATE_NAST_TABLE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_IT_NAST  text
*----------------------------------------------------------------------*
FORM UPDATE_NAST_TABLE  CHANGING et_nast type t_nast_t.


insert nast from table et_nast.


if sy-subrc <> 0.
    ROLLBACK work.
  else.
    commit work.
endif.

ENDFORM.                    " UPDATE_NAST_TABLE

FORM GET_NAST_ENTRIES  CHANGING et_nast type t_nast_t.

data: e_nast type t_nast.

select * from nast into e_nast
                   where kappl in s_kappl
                   and objky in s_objky
                   and kschl in s_kschl
                   and erdat in s_erdat
                   ORDER BY erdat DESCENDING .


   append e_nast to et_nast.

endselect.

ENDFORM.                    " GET_NAST_ENTRIES
