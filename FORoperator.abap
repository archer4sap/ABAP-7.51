REPORT ztest_abap751_for.
*" Extended Expressions : FOR operator
TYPES : BEGIN OF lty_value,
          field1 TYPE i,
          field2 TYPE i,
        END OF lty_value,

        ltty_value  TYPE STANDARD TABLE OF lty_value WITH EMPTY KEY,
        ltty_field2 TYPE STANDARD TABLE OF i WITH EMPTY KEY.

DATA(lt_values) = VALUE ltty_value(
                            ( field1 = 1 field2 = 2 )
                            ( field1 = 3 field2 = 4 )
                            ( field1 = 5 field2 = 6 )
                            ( field1 = 5 field2 = 7 ) ).
WRITE : / 'Data : '.
LOOP AT lt_values ASSIGNING FIELD-SYMBOL(<lfs_value>).
  WRITE : / <lfs_value>-field1, space ,<lfs_value>-field2 .
ENDLOOP.
SKIP. SKIP.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Variant 1 : Extracting fields from internal table
WRITE : / 'Variant 1 : Extracting fields from internal table '.
DATA(lt_field2) = VALUE ltty_field2( FOR ls_value IN lt_values
                                            ( ls_value-field2 ) ).
LOOP AT lt_field2 ASSIGNING FIELD-SYMBOL(<lfs_field2>).
  WRITE : / <lfs_field2>.
ENDLOOP.
SKIP. SKIP.
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Variant 2 : Changing sequence of field an internal table
WRITE : / 'Variant 2 : Changing sequence of fields an internal table '.
TYPES : BEGIN OF lty_seq,
          seq1 TYPE i,
          seq2 TYPE i,
        END OF lty_seq,

        ltty_seq TYPE STANDARD TABLE OF lty_seq WITH EMPTY KEY.

DATA(lt_seq) = VALUE ltty_seq( FOR ls_seq_chg IN lt_values
                                            ( seq1 = ls_seq_chg-field2
                                              seq2 = ls_seq_chg-field1 ) ).
LOOP AT lt_seq ASSIGNING FIELD-SYMBOL(<lfs_seq>).
  WRITE : / <lfs_seq>-seq1, space,<lfs_seq>-seq2 .
ENDLOOP.
SKIP. SKIP.
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" Variant 3 : using WHERE condition with FOR
WRITE : / 'Variant 3 :  using WHERE condition with FOR'.
DATA(lt_value_where) = VALUE ltty_value( FOR ls_value IN lt_values
                                            WHERE ( field1 = 5 ) " Condition
                                            ( field1 = ls_value-field1
                                              field2 = ls_value-field2 ) ).
LOOP AT lt_value_where ASSIGNING FIELD-SYMBOL(<lfs_value_where>).
  WRITE : / <lfs_value_where>-field1, space, <lfs_value_where>-field2 .
ENDLOOP.
SKIP. SKIP.
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"First iteration starts with i = 0(Inline declaration & initialization) and
*"increments according to THEN statement where i + 1 means i = i + 1. SY-INDEX
*"or SY-TABIX doesn't store index of iteration. This is alternate to DO-WHILE.
*" Variant 4 : FOR - THEN - UNTIL statement, normal case
WRITE : / 'Variant 4 :  FOR - THEN - UNTIL, normal case'.
DATA(lt_value_then_until) = VALUE ltty_value( FOR i = 0 THEN i + 1 UNTIL i >= 4 " or i = 4
                                            ( field1 = i
                                              field2 = sy-index ) ).
LOOP AT lt_value_then_until ASSIGNING FIELD-SYMBOL(<lfs_value_then_until>).
  WRITE : / <lfs_value_then_until>-field1, space, <lfs_value_then_until>-field2 .
ENDLOOP.
SKIP. SKIP.
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"WHILE works just opposite to UNTIL. This is alternate to DO-WHILE. SY-INDEX
*"or SY-TABIX doesn't store index of iteration.
*" Variant 5 : FOR - THEN - WHILE statement
WRITE : / 'Variant 5 :  FOR - THEN - WHILE '.
DATA(lt_value_then_while) = VALUE ltty_value( FOR i = 0 THEN i + 1 WHILE i < 4 " or i = 4
                                            ( field1 = i
                                              field2 = sy-index ) ).
LOOP AT lt_value_then_while ASSIGNING FIELD-SYMBOL(<lfs_value_then_while>).
  WRITE : / <lfs_value_then_while>-field1, space, <lfs_value_then_while>-field2 .
ENDLOOP.
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" Variant 6 : NEW instead of VALUE operator
WRITE : / 'Variant 6 :  NEW instead of VALUE operator '.
DATA(lo_value_new) = NEW ltty_value( FOR i = 0 THEN i + 1 WHILE i < 4
                                            ( field1 = i
                                              field2 = i + 1 ) ) .
