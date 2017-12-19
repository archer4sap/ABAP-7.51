REPORT ztest_abap751_read_table_alt.

" Extended Expressions : Alternative to READ TABLE expressions


DATA : lt_mara TYPE STANDARD TABLE OF mara.

" Variant 1
SELECT matnr FROM mara INTO TABLE lt_mara.
IF sy-subrc IS INITIAL.
  ASSIGN lt_mara[ 1 ] TO FIELD-SYMBOL(<lfs_mara>).
  IF sy-subrc IS INITIAL.
    WRITE : / |Material = <lfs_mara>-matnr |  .
  ENDIF.
ENDIF.


" Variant 2
ASSIGN lt_mara[ matnr = 'HP_001' ]
              TO FIELD-SYMBOL(<lfs_mara1>).

" Variant 3
TRY .
    WRITE : lt_mara[ 100000 ]-matnr.
  CATCH cx_sy_itab_line_not_found .
    WRITE : / |Error in index read!|.
ENDTRY.
