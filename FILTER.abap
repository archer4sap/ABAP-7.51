REPORT ztest_abap751_filter.
" Extended Expressions : FILTER, works as a SELECT on Internal Table
TYPES : BEGIN OF lty_value,
          field1 TYPE i,
          field2 TYPE i,
        END OF lty_value,

        " Table type should be sorted or hashed
        ltty_value TYPE SORTED TABLE OF lty_value
        WITH UNIQUE KEY field1 field2.

DATA(lt_values) = VALUE ltty_value(
    ( field1 = 1 field2 = 2 )
    ( field1 = 3 field2 = 4 )
    ( field1 = 3 field2 = 5 ) ).

DATA : lt_values_filter   TYPE ltty_value,
       lt_values_filtered TYPE ltty_value..

WRITE : / |Data : |    .
LOOP AT lt_values ASSIGNING FIELD-SYMBOL(<lfs_value>).
  WRITE : / <lfs_value>-field1, space , <lfs_value>-field2.
ENDLOOP.
SKIP.SKIP.

lt_values_filter = VALUE ltty_value(
    ( field1 = 3 field2 = 5 ) ). " Create Filter on Primary Key

*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
WRITE : / |Variant 1 : Filter Table, # as operand| .
lt_values_filtered = FILTER #( lt_values IN lt_values_filter
                     WHERE field1 = field1 " Primary Key comparison here
                     AND field2 = field2
                     ).

LOOP AT lt_values_filtered ASSIGNING <lfs_value>.
  WRITE : / <lfs_value>-field1, space , <lfs_value>-field2.
ENDLOOP.
SKIP.SKIP.
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"TYPE can be explicitly mentioned with FILTER Statement
WRITE : / |Variant 2 : Filter Table, Table Type ltty_value as Operand | .
REFRESH lt_values_filtered[].
lt_values_filtered = FILTER ltty_value( lt_values IN lt_values_filter
    WHERE field1 = field1 " Primary Key comparison here
    AND field2 = field2
    ).

LOOP AT lt_values_filtered ASSIGNING <lfs_value>.
  WRITE : / <lfs_value>-field1, space , <lfs_value>-field2.
ENDLOOP.
*SKIP.SKIP.
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"Except keyword can be used to invert the selection with FILTER
WRITE : / |Variant 3 : Filter Table, Using 'EXCEPT' Keyword| .
REFRESH lt_values_filtered[].
lt_values_filtered = FILTER #( lt_values EXCEPT IN lt_values_filter
    WHERE field1 = field1 " Primary Key comparison here
    AND field2 = field2
    ).

LOOP AT lt_values_filtered ASSIGNING <lfs_value>.
  WRITE : / <lfs_value>-field1, space , <lfs_value>-field2.
ENDLOOP.
SKIP.SKIP.
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"FILTER operator's Basic form can be used without using IN operator.
*"In all forms of FILTER operator, only AND operator is allowed(no OR).
*"Syntax in this case is similar to FILTERed form
WRITE : / |Variant 4 : Without Filter Table, without IN operator | .
REFRESH lt_values_filtered[].
lt_values_filtered = FILTER #( lt_values " no use of 'IN'
                    WHERE field1 = 3
                    AND field2 = 5
                    ).

LOOP AT lt_values_filtered ASSIGNING <lfs_value>.
  WRITE : / <lfs_value>-field1, space , <lfs_value>-field2.
ENDLOOP.
