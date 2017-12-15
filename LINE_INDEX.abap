REPORT ztest_abap751_line_exists.

" Extended Expressions : LINE_INDEX
TYPES : BEGIN OF lty_value,
          field1 TYPE i,
          field2 TYPE i,
        END OF lty_value,

        ltty_value TYPE STANDARD TABLE OF lty_value
                   WITH EMPTY KEY.

DATA(lt_values) = VALUE ltty_value(
                            ( field1 = 1 field2 = 2 )
                            ( field1 = 3 field2 = 4 ) ).
WRITE : |Data : |.
LOOP AT lt_values ASSIGNING FIELD-SYMBOL(<lfs_value>).
  WRITE : / <lfs_value>-field1, space ,
            <lfs_value>-field2.
ENDLOOP.

" Variant 1 - Searching field1
DATA(lv_line) = line_index( lt_values[ field1 = 3 ] ).
IF lv_line IS NOT INITIAL.
  WRITE : / |Index for field1 = 3 is : | & | { lv_line }|.
ENDIF.

" Variant 1 - If index not found, it returns 0
CLEAR lv_line.
lv_line = line_index( lt_values[ field1 = 100 ] ).
IF lv_line IS NOT INITIAL.
  WRITE : / |Index for field1 = 100 is : | & | { lv_line }|.
ELSE.
  WRITE: / |Index for field1 = 100 not found! lv_line = |
         & | { lv_line }|.
ENDIF.
