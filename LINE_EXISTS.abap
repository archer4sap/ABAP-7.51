REPORT ztest_abap751_line_exists.

" Extended Expressions : LINE_EXISTS
TYPES : BEGIN OF lty_value,
          field1 TYPE i,
          field2 TYPE i,
        END OF lty_value,

        ltty_value TYPE STANDARD TABLE OF lty_value WITH EMPTY KEY.

DATA(lt_values) = VALUE ltty_value(
                            ( field1 = 1 field2 = 2 )
                            ( field1 = 3 field2 = 4 ) ).
WRITE : |Data : |.
LOOP AT lt_values ASSIGNING FIELD-SYMBOL(<lfs_value>).
  WRITE : / <lfs_value>-field1, space , <lfs_value>-field2.
ENDLOOP.

" Variant 1 - Search by Index
IF line_exists( lt_values[ 10 ] ).
  WRITE : / |Line # 10 exists|.
ELSE.
  WRITE : / |Line # 10 doesn't exist|.
ENDIF.

" Variant 2 - Search by field-value pair
IF line_exists( lt_values[ field2 = 4 ] ).
  WRITE : / |Line for field2 = 4 exists|.
ELSE.
  WRITE : / |Line for field2 = 4 doesn't  exist|.
ENDIF.
