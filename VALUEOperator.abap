*&---------------------------------------------------------------------*
*& Report
*&---------------------------------------------------------------------*
REPORT ztest_abap751_value.

" Page 9
" Extended Expressions : Value Expression

WRITE : / | Variant 1|.
TYPES : BEGIN OF lty_value,
          field1 TYPE i,
          field2 TYPE i,
        END OF lty_value,

        ltty_value TYPE STANDARD TABLE OF lty_value WITH EMPTY KEY.

DATA(lt_values) = VALUE ltty_value(
                            ( field1 = 1 field2 = 2 )
                            ( field1 = 4 field2 = 3 ) ).

LOOP AT lt_values ASSIGNING FIELD-SYMBOL(<lfs_value>).
  WRITE : / <lfs_value>-field1, space , <lfs_value>-field2.
ENDLOOP.

WRITE : / | Variant 2|.
*TYPES : BEGIN OF lty_value,
*  field1 TYPE I,
*  field2 TYPE I,
*END OF lty_value,

*ltty_value TYPE STANDARD TABLE OF lty_value WITH EMPTY KEY.

lt_values = VALUE ltty_value(
      ( field1 = 1 ) ( field2 = 2 )
      ( field1 = 4 ) ( field2 = 3 ) ). " Notice additional brackets

LOOP AT lt_values ASSIGNING <lfs_value>.
  WRITE : / <lfs_value>-field1, space , <lfs_value>-field2.
ENDLOOP.

*&---------------------------------------------------------------------*

" Extended Expressions : Value chaining
WRITE : / | Variant 3|.

DATA : lt_range TYPE RANGE OF i.

lt_range = VALUE #(
                  sign = 'I'
                  option = 'EQ'
                  ( low = 1 )
                  ( low = 2 ) ).

WRITE : |Sign | & |Option   | &  |Low      | & |   High|.
WRITE : / |----------------------------------|.

LOOP AT lt_range ASSIGNING FIELD-SYMBOL(<lfs_range>).
  WRITE : / <lfs_range>-sign, <lfs_range>-option, <lfs_range>-low, <lfs_range>-high.
ENDLOOP.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
WRITE : / | Variant 4|.
*DATA : lt_range TYPE RANGE OF I.

lt_range = VALUE #(
              sign = 'I'
              option = 'EQ'
                     ( low = 1 )
                     ( low = 2 )
             sign = 'I'
             option = 'BT'
                    ( low = 5
                      high = 10 )  ).

WRITE : |SIGN | & |Option   | &  |Low      | & |   High|.
WRITE : / |----------------------------------|.

LOOP AT lt_range ASSIGNING <lfs_range>.
  WRITE : / <lfs_range>-sign, <lfs_range>-option, <lfs_range>-low, <lfs_range>-high.
ENDLOOP.

*&---------------------------------------------------------------------*
WRITE : / | Variant 5|.
" Extended Expressions : VALUE-DEFAULT pair
*TYPES : BEGIN OF lty_value,
*          field1 TYPE i,
*          field2 TYPE i,
*        END OF lty_value,
*
*        ltty_value TYPE STANDARD TABLE OF lty_value WITH EMPTY KEY.

DATA : lv_value TYPE i.

lt_values = VALUE ltty_value(
                            ( field1 = 1 field2 = 5 )
                            ( field1 = 1 )
                            ( field1 = 2 field2 = 7 ) ).

DO 5 TIMES.
  lv_value = VALUE #( lt_values[ sy-index ]-field2
                                        DEFAULT -1 ).

  WRITE : / lv_value.
ENDDO.
