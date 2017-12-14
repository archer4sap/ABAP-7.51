*&---------------------------------------------------------------------*
*& Report
*&---------------------------------------------------------------------*
REPORT ztest_abap751_value.

" Extended Expressions : COND expression
DO 4 TIMES.
  DATA(value_cond) =
        COND string(
        WHEN sy-index = 1 THEN |One|
        WHEN sy-index = 2 THEN |Two|
        ELSE |GREATER than 2!| ).

  WRITE : / value_cond.
ENDDO.


" Extended Expressions : SWITCH expression variation
DO 4 TIMES.
  DATA(value_switch) =
        SWITCH string( sy-index
        WHEN  1 THEN |One|
        WHEN  2 THEN |Two|
        ELSE |GREATER than 2!| ).

  WRITE : / value_switch.
ENDDO.
