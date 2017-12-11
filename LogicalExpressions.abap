*&---------------------------------------------------------------------*
*& Report
*&---------------------------------------------------------------------*
REPORT ztest_abap751_logical_exp.

*" Extended Expressions : Computation in logical Expressions
DATA : lv_num1 TYPE i VALUE 2,
       lv_num2 TYPE i VALUE 5.

*" Simple Expression
IF lv_num1 * lv_num2 EQ 10.
  WRITE : / |Now inline expressions are possible.| &
          | It reduces LINES OF CODE!|.
ENDIF.


*" Brackets can be used to combine expressions
IF ( lv_num1 * lv_num2 ) + 2 EQ 12.
  WRITE : / |Complex expressions are also possible!|.
ENDIF.
