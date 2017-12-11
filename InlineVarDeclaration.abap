*&---------------------------------------------------------------------*
*& Report
*&---------------------------------------------------------------------*
REPORT ztest_abap751_inline_var_decl.

" Extended Expressions : Inline Declarations - Variables

DATA : lt_mara TYPE STANDARD TABLE OF mara.

SELECT matnr FROM mara INTO TABLE lt_mara.
IF sy-subrc IS INITIAL.
  READ TABLE lt_mara INTO DATA(lwa_mara) INDEX 1.
  IF sy-subrc IS INITIAL.
    WRITE : |Material successfully read! | &
            |Inline declaration works!|.
  ENDIF.

  SKIP.

  LOOP AT lt_mara INTO DATA(lwa_mara_another).
    WRITE : / |{ sy-tabix }| & |This works!|.

    IF sy-tabix > 4.
      EXIT.
    ENDIF.

  ENDLOOP.

ENDIF.
