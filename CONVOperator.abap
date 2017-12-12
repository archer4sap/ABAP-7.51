*&---------------------------------------------------------------------*
*& Report
*&---------------------------------------------------------------------*
REPORT ztest_abap751_conv.


" Extended Expressions : Conversion Operator

DATA : lv_integer TYPE I.

lv_integer = SQRT( 5 ) + SQRT( 6 ).
WRITE : / lv_integer. " 5

lv_integer = CONV I( SQRT( 5 ) ) + CONV I( SQRT( 6 ) ).
WRITE : / lv_integer. " 4

" TIP : Read online documentation for CONV. It has much more to offer!
