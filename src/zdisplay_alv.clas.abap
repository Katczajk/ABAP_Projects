class ZDISPLAY_ALV definition
  public
  final
  create public .

public section.

  methods CONSTRUCTOR .
  methods SHOW_ALV
    importing
      value(I_DBNAME) type DD02L-TABNAME optional
      value(I_REPID) type SY-REPID
    changing
      value(C_SUBRC) type SY-SUBRC .
protected section.
private section.

  data L_FIELDCAT type SLIS_T_FIELDCAT_ALV .

  methods CREATE_FIELDCAT
    importing
      value(L_REPID) type SY-REPID
      value(L_DBNAME) type DD02L-TABNAME optional .
  methods CREATE_AVL
    importing
      value(L_DBNAME) type DD02L-TABNAME
    changing
      value(L_REPID) type SY-REPID .
ENDCLASS.



CLASS ZDISPLAY_ALV IMPLEMENTATION.


  method CONSTRUCTOR.


  endmethod.


  method CREATE_AVL.

    data lt_zdemo1 TYPE table of zdemo1.

    select * from (l_dbname) into table lt_zdemo1.




    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
*       I_INTERFACE_CHECK                 = ' '
*       I_BYPASSING_BUFFER                = ' '
*       I_BUFFER_ACTIVE                   = ' '
        I_CALLBACK_PROGRAM                = l_repid
*       I_CALLBACK_PF_STATUS_SET          = ' '
*       I_CALLBACK_USER_COMMAND           = ' '
*       I_CALLBACK_TOP_OF_PAGE            = ' '
*       I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*       I_CALLBACK_HTML_END_OF_LIST       = ' '
*       I_STRUCTURE_NAME                  =
*       I_BACKGROUND_ID                   = ' '
*       I_GRID_TITLE                      =
*       I_GRID_SETTINGS                   =
*       IS_LAYOUT                         =
        IT_FIELDCAT                       = l_fieldcat
*       IT_EXCLUDING                      =
*       IT_SPECIAL_GROUPS                 =
*       IT_SORT                           =
*       IT_FILTER                         =
*       IS_SEL_HIDE                       =
*       I_DEFAULT                         = 'X'
        I_SAVE                            = 'A'
*       IS_VARIANT                        =
*       IT_EVENTS                         =
*       IT_EVENT_EXIT                     =
*       IS_PRINT                          =
*       IS_REPREP_ID                      =
*       I_SCREEN_START_COLUMN             = 0
*       I_SCREEN_START_LINE               = 0
*       I_SCREEN_END_COLUMN               = 0
*       I_SCREEN_END_LINE                 = 0
*       I_HTML_HEIGHT_TOP                 = 0
*       I_HTML_HEIGHT_END                 = 0
*       IT_ALV_GRAPHICS                   =
*       IT_HYPERLINK                      =
*       IT_ADD_FIELDCAT                   =
*       IT_EXCEPT_QINFO                   =
*       IR_SALV_FULLSCREEN_ADAPTER        =
*       O_PREVIOUS_SRAL_HANDLER           =
*     IMPORTING
*       E_EXIT_CAUSED_BY_CALLER           =
*       ES_EXIT_CAUSED_BY_USER            =
      TABLES
        t_outtab                          = lt_zdemo1
      EXCEPTIONS
        PROGRAM_ERROR                     = 1
        OTHERS                            = 2
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.


  endmethod.


  method CREATE_FIELDCAT.

        try.

    CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
      EXPORTING
        I_PROGRAM_NAME               = l_REPID
*       I_INTERNAL_TABNAME           =
        I_STRUCTURE_NAME             = l_dbname
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_INCLNAME                   =
*       I_BYPASSING_BUFFER           =
*       I_BUFFER_ACTIVE              =
      CHANGING
        ct_fieldcat                  = l_fieldcat
      EXCEPTIONS
        INCONSISTENT_INTERFACE       = 1
        PROGRAM_ERROR                = 2
        OTHERS                       = 3
              .
    IF sy-subrc <> 0.

    ENDIF.

     catch cx_root.
    endtry.

  endmethod.


  method SHOW_ALV.


CALL METHOD me->CREATE_FIELDCAT
  EXPORTING
    l_repid  = i_repid
    l_dbname = i_dbname
    .

CALL METHOD me->create_avl
  EXPORTING
    l_dbname = i_dbname
  changing
    l_repid  = i_repid
    .


  endmethod.
ENDCLASS.
