REPORT ztest_abap751_reduce.
*" REDUCE operator iterates and produces result of specified data type
TYPES : BEGIN OF lty_value,
          field1 TYPE i,
          field2 TYPE i,
        END OF lty_value,

        ltty_value  TYPE STANDARD TABLE OF lty_value WITH EMPTY KEY,
        ltty_field2 TYPE STANDARD TABLE OF i WITH EMPTY KEY.

DATA(lt_values) = VALUE ltty_value(
                            ( field1 = 1 field2 = 2 )
                            ( field1 = 3 field2 = 4 )
                            ( field1 = 5 field2 = 6 )
                            ( field1 = 5 field2 = 7 ) ).
WRITE : / 'Data : '.
LOOP AT lt_values ASSIGNING FIELD-SYMBOL(<lfs_value>).
  WRITE : / <lfs_value>-field1, space ,<lfs_value>-field2 .
ENDLOOP.
SKIP. SKIP.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Variant 1 : REDUCE - FOR - WHERE - used here for counting
WRITE : / 'Count where field1 is 5'.
DATA(lv_count) = REDUCE i( INIT lv_x = 0 FOR wa_value IN lt_values
                    WHERE ( field1 = 5 ) NEXT lv_x = lv_x + 1 ).

WRITE : / |Count : | & |{ lv_count }| .
SKIP.SKIP.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Variant 2 : Concatenating row values
WRITE : / 'Variant 2 : Concatenating row values'.
TYPES : BEGIN OF lty_alphabet,
          letter TYPE c,
        END OF lty_alphabet,

        ltty_alphabet TYPE STANDARD TABLE OF lty_alphabet WITH EMPTY KEY.

DATA(lt_alpha) = VALUE ltty_alphabet(
                            ( letter = 'A'  )
                            ( letter = 'B'  )
                            ( letter = 'C'  )
                            ( letter = 'D'  ) ).

DATA(lv_letters) = REDUCE string( INIT lv_y = '         '
                            FOR wa_alpha
                            IN lt_alpha
                            NEXT lv_y = |{ lv_y }| & |{ wa_alpha-letter }| ).
WRITE : / lv_letters.
SKIP.SKIP.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Variant 3 : Adding row values
WRITE : / 'Variant 3 : Adding row values'.
DATA(lv_sum) = REDUCE i( INIT lv_z = 0
                         FOR lwa_value1
                         IN lt_values
                         NEXT lv_z = lv_z + lwa_value1-field2 ).
WRITE : |Sum of field2 is : | & |{ lv_sum }|.
SKIP.SKIP.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Variant 4 : Adding row values with condition
WRITE : / 'Variant 4 : Adding row values with condition'.
DATA(lv_sum_where) = REDUCE i( INIT lv_z = 0
                         FOR lwa_value1
                         IN lt_values
                         WHERE ( field1 = 5 )
                         NEXT lv_z = lv_z + lwa_value1-field2 ).
WRITE : |Sum of field2 is : | & |{ lv_sum_where }|.
