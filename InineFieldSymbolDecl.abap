*&---------------------------------------------------------------------*
*& Report
*&---------------------------------------------------------------------*
REPORT ztest_abap751_inline_fs_decl.


" Extended Expressions : Inline Declarations – Field Symbols

" Variant 1 as a READ work area
DATA : lt_mara TYPE STANDARD TABLE OF mara.

SELECT matnr FROM mara INTO TABLE lt_mara.
IF sy-subrc IS INITIAL.
  READ TABLE lt_mara ASSIGNING FIELD-SYMBOL(<lfs_mara>) INDEX 1.
  IF sy-subrc IS INITIAL.
    WRITE : |Material = <lfs_mara>-matnr |.
  ENDIF.
ENDIF.

" Variant 2 as a LOOP work area
SELECT matnr FROM mara INTO TABLE lt_mara.
IF sy-subrc IS INITIAL.
  LOOP AT lt_mara ASSIGNING FIELD-SYMBOL(<lfs_mara_another>).
    WRITE : / |<lfs_mara_another>-matnr is material|.

    IF sy-tabix > 4.
      EXIT.
    ENDIF.
  ENDLOOP.
ENDIF.
