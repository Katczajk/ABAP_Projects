*&---------------------------------------------------------------------*
*& Report  ZZZ_DEMO45
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZZZ_DEMO45.

tables: nast.

types:  t_nast type nast,
        t_nast_t type STANDARD TABLE OF nast.


data: it_nast type t_nast_t,
      wa_nast type t_nast,
      i_nast type nast,
      e_nast type nast,
      gv_kappl type nast-kappl,
      gv_objky type nast-objky,
      gv_kschl type nast-kschl,
      gv_erdat type nast-erdat.

CONSTANTS:
            LP01            like nast-ldest value 'LP01',
            LP02            like nast-ldest value 'LP02',
            drucken         like nast-tdarmod value '1',
            ablegen         like nast-tdarmod value '2',
            drucken_ablegen like nast-tdarmod value '3'.


SELECTION-SCREEN BEGIN OF BLOCK a01 with frame title text-001.

  select-OPTIONS: s_kappl for gv_kappl,
                  s_objky for gv_objky,
                  s_kschl for gv_kschl,
                  s_erdat for gv_erdat.


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
    e_nast-ldest = LP02.
    e_nast-dimme = zcl_const=>gc_x.
    e_nast-tdarmod = ablegen.
    e_nast-usnam = sy-uname.
    e_nast-tdreceiver = sy-uname.
    e_nast-MANUE = zcl_const=>gc_x.
    clear: e_nast-datvr, e_nast-uhrvr, e_nast-delet, e_nast-aende.

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

data: e_nast type t_nast,
      i_rcode type sy-subrc.

loop at et_nast into e_nast.

  clear: nast.
  move e_nast to nast.
  check sy-sysid <> 'E01'.
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

check sy-sysid <> 'E01'.

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
