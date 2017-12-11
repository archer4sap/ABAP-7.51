*&---------------------------------------------------------------------*
*& Report
*&---------------------------------------------------------------------*
REPORT ztest_abap751_repeat.


" Extended Expressions : Repeating Values - Variant 1
WRITE : /  |{ repeat( val = 'A' occ = 5 ) }|.


" Extended Expressions : Repeating Values - Variant 2
WRITE : / |1| &
        |{ repeat( val = '_' occ = 8 ) }| &
        |10|.


" Extended Expressions : Repeating Values - Error Handling
TRY .
    WRITE : / |{ repeat( val = 'A' occ = -1 ) }|.
  CATCH cx_sy_strg_par_val.
    WRITE : / 'Error!'.
ENDTRY.
