" Extended Expressions : LET expression

TYPES:
  BEGIN OF ty_data,
    field1 TYPE i,
    field2 TYPE i,
  END OF ty_data.

DATA : lt_data TYPE TABLE OF ty_data.

DO 3 TIMES.
  DATA(lwa_data) = VALUE ty_data(
                                LET x = sy-index
                                    y = sy-index + 1
                                IN field1 = x
                                   field2 = y ).

  APPEND lwa_data TO lt_data.
ENDDO.

cl_demo_output=>display( lt_data ).
