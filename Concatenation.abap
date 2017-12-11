*&---------------------------------------------------------------------*
*& Report ztest_abap751
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_abap751.

" Extended Expressions : Concatenation

CONSTANTS : lc_abap TYPE string VALUE 'ABAP 751'.

WRITE : |Hello | & |{ lc_abap }|.
