*&---------------------------------------------------------------------*
*& Report
*&---------------------------------------------------------------------*
REPORT ztest_abap751_switch_cond.
" Extended Expressions : SWITCH expression variation

" Extended Expressions : Inline Declarations - SQL
*DATA : lt_mara TYPE STANDARD TABLE OF mara.

" Creating an Internal table inline
SELECT matnr, ersda
    FROM mara
    INTO TABLE @DATA(lt_mara). " Escaping host variable with @
IF sy-subrc IS INITIAL.
  READ TABLE lt_mara INTO DATA(lwa_mara) INDEX 1.
  IF sy-subrc IS INITIAL.
    WRITE : |Material successfully READ! | &
            |Inline declaration works!|.
  ENDIF.
ENDIF.


" Creating a Variable inline
SELECT SINGLE matnr FROM mara INTO @DATA(lv_matnr).

" Creating a work area inline
SELECT SINGLE matnr, ersda FROM mara INTO @DATA(lwa_work_area).
