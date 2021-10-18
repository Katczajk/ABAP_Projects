class ZMESSAGE definition
  public
  final
  create public .

public section.

  class-methods ALTERT_DB_NOT_FOUND
    importing
      value(DBNAME) type TABNAME optional .
protected section.
private section.
ENDCLASS.



CLASS ZMESSAGE IMPLEMENTATION.


  method ALTERT_DB_NOT_FOUND.

data l_errormsg type string.

if dbname is INITIAL.
  l_errormsg = 'Database not found.' .
  message l_errormsg type 'E'.
else.
  CONCATENATE dbname ' not found.' into l_errormsg.
  message l_errormsg type 'E'.
endif.

  endmethod.
ENDCLASS.
