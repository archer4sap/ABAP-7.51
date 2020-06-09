REPORT ztest_751_base.

"BASE , corresponding and move-corresponding

"Variant 1 : BASE before an Internal table can be used for insert
TYPES ltty_days TYPE TABLE OF string WITH EMPTY KEY.
WRITE : / |Variant 1 : BASE before an Internal table used for insert|.
DATA(lt_days) =
  VALUE ltty_days(
    ( `Mon` ) ( `Tue` ) ( `Wed` ) ).

// This is a new test
lt_days =
  VALUE #(
    BASE lt_days
    ( `Thu` ) ( `Fri` ) ( `Sat` ) ( `Sun` ) ).

    loop at lt_days ASSIGNING FIELD-SYMBOL(<lfs_days>).
        WRITE : / |{ <lfs_days> }|.
    ENDLOOP.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Variant 2 : usage with CORRESPONDING operator on Work area
WRITE : / |Variant 2 : usage with CORRESPONDING operator on Work area|.
TYPES: BEGIN OF lty_type1,
         field1 TYPE i,
       END OF lty_type1,

       ltty_type1 TYPE TABLE OF lty_type1 WITH EMPTY KEY,

       BEGIN OF lty_type2,
         field1 TYPE i,
         field2 TYPE i,
       END OF lty_type2,

       ltty_type2 TYPE TABLE OF lty_type2 WITH EMPTY KEY.

DATA(lwa_type1) = VALUE lty_type1( field1 = 1 ).
DATA(lwa_type2) = VALUE lty_type2( field1 = 2 field2 = 3 ).

MOVE-CORRESPONDING lwa_type1 TO lwa_type2.
WRITE : / lwa_type2-field1, space, lwa_type2-field2.

" Reverting back to original
lwa_type2 = VALUE lty_type2( field1 = 2 field2 = 3 ).
lwa_type2 = CORRESPONDING #( lwa_type1 ).
WRITE : / lwa_type2-field1, space, lwa_type2-field2.

" Reverting back to original
lwa_type2 = VALUE lty_type2( field1 = 2 field2 = 3 ).
lwa_type2 = CORRESPONDING #( BASE ( lwa_type2 ) lwa_type1 ).
WRITE : / lwa_type2-field1, space, lwa_type2-field2.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Variant 3 : usage with CORRESPONDING operator on Internal table
WRITE : / |Variant 3 : usage with CORRESPONDING operator on Internal table|.


DATA(lt_type1) = VALUE ltty_type1( ( field1 = 1 )
                                   ( field1 = 2 ) ).

DATA(lt_type2) = VALUE ltty_type2( ( field1 = 3 field2 = 4 )
                                   ( field1 = 5 field2 = 6 )
                                   ( field1 = 7 field2 = 8 ) ).

MOVE-CORRESPONDING lt_type1 TO lt_type2.
WRITE : / |MOVE-CORRESPONDING lt_type1 TO lt_type2.|.
LOOP AT lt_type2 ASSIGNING FIELD-SYMBOL(<lfs_type2>).
  WRITE : / <lfs_type2>-field1, space, <lfs_type2>-field2.
ENDLOOP.

" Reverting back
lt_type2 = VALUE ltty_type2( ( field1 = 3 field2 = 4 )
                             ( field1 = 5 field2 = 6 )
                             ( field1 = 7 field2 = 8 ) ).
MOVE-CORRESPONDING lt_type1 TO lt_type2 KEEPING TARGET LINES.
WRITE : / |MOVE-CORRESPONDING lt_type1 TO lt_type2 KEEPING TARGET LINES.|.
LOOP AT lt_type2 ASSIGNING <lfs_type2>.
  WRITE : / <lfs_type2>-field1, space, <lfs_type2>-field2.
ENDLOOP.

" Reverting back
lt_type2 = VALUE ltty_type2( ( field1 = 3 field2 = 4 )
                             ( field1 = 5 field2 = 6 )
                             ( field1 = 7 field2 = 8 ) ).
lt_type2 = CORRESPONDING #( BASE ( lt_type2 ) lt_type1 ).
WRITE : / |lt_type2 = CORRESPONDING #( BASE ( lt_type2 ) lt_type1 ).|.
LOOP AT lt_type2 ASSIGNING <lfs_type2>.
  WRITE : / <lfs_type2>-field1, space, <lfs_type2>-field2.
ENDLOOP.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Variant 4 : CORRESPONDING - BASE - MAPPING
WRITE : / |Variant 4 : CORRESPONDING - BASE - MAPPING|.
lt_type2 = VALUE ltty_type2( ( field1 = 23 field2 = 24 )
                             ( field1 = 25 field2 = 26 )
                             ( field1 = 27 field2 = 28 ) ).


TYPES : BEGIN OF lty_type3,
          field1 TYPE i,
          field3 TYPE i,
        END OF lty_type3,

        ltty_type3 TYPE TABLE OF lty_type3 WITH EMPTY KEY.

DATA(lt_type3) = VALUE ltty_type3( ( field1 = 33 field3 = 30 )
                                   ( field1 = 35 field3 = 30 )
                                   ( field1 = 37 field3 = 30 ) ).

lt_type3 = CORRESPONDING #( BASE ( lt_type3 ) lt_type2 ).
WRITE : / |lt_type3 = CORRESPONDING #( BASE ( lt_type3 ) lt_type2 ).|.
LOOP AT lt_type3 ASSIGNING FIELD-SYMBOL(<lfs_type3>).
  WRITE : / <lfs_type3>-field1, space, <lfs_type3>-field3.
ENDLOOP.
" Reverting back values
lt_type3 = VALUE ltty_type3( ( field1 = 33 field3 = 30 )
                                   ( field1 = 35 field3 = 30 )
                                   ( field1 = 37 field3 = 30 ) ).

lt_type3 = CORRESPONDING #( BASE ( lt_type3 ) lt_type2 MAPPING field3 = field2 ). " DISCARDING DUPLICATES
WRITE : / |lt_type3 = CORRESPONDING #( BASE ( lt_type3 ) lt_type2 MAPPING field3 = field2 ).|.
LOOP AT lt_type3 ASSIGNING <lfs_type3>.
  WRITE : / <lfs_type3>-field1, space, <lfs_type3>-field3.
ENDLOOP.

*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPPING & EXCEPT can come separately or together
"if both come together, EXCEPT come after MAPPING
*"Variant 5 : CORRESPONDING - BASE - EXCEPT
WRITE : / |Variant 5 : CORRESPONDING - BASE - EXCEPT|.
TYPES : BEGIN OF lty_type4,
          field1 TYPE i,
          field2 TYPE i,
          field3 TYPE i,
        END OF lty_type4,

        ltty_type4 TYPE TABLE OF lty_type4 WITH EMPTY KEY.

" Reverting back values
lt_type2 = VALUE ltty_type2( ( field1 = 23 field2 = 24 )
                             ( field1 = 25 field2 = 26 ) ).

DATA(lt_type4) = VALUE ltty_type4( ( field1 = 43 field2 = 41 field3 = 40 )
                                   "( field1 = 44 field2 = 46 field3 = 47 )
                                   ( field1 = 45 field2 = 42 field3 = 40 ) ).

*lt_type4 = CORRESPONDING #( BASE ( lt_type4 ) lt_type2 ).
lt_type4 = CORRESPONDING #( lt_type2 ).
WRITE : / |lt_type4 = CORRESPONDING #( lt_type2 ).|.
LOOP AT lt_type4 ASSIGNING FIELD-SYMBOL(<lfs_type4>).
  WRITE : / <lfs_type4>-field1, space, <lfs_type4>-field2, space, <lfs_type4>-field3.
ENDLOOP.

*lt_type4 = CORRESPONDING #( BASE ( lt_type4 ) lt_type2 EXCEPT field2 ).
lt_type4 = CORRESPONDING #( lt_type2 EXCEPT field2 ).
WRITE : / |lt_type4 = CORRESPONDING #( lt_type2 EXCEPT field2 ).|.
LOOP AT lt_type4 ASSIGNING <lfs_type4>.
  WRITE : / <lfs_type4>-field1, space, <lfs_type4>-field2, space, <lfs_type4>-field3.
ENDLOOP.

*lt_type4 = CORRESPONDING #( BASE ( lt_type4 ) lt_type2 EXCEPT * ).
lt_type4 = CORRESPONDING #( lt_type2 MAPPING field2 = field2 EXCEPT * ).
WRITE : / |lt_type4 = CORRESPONDING #( lt_type2 MAPPING field2 = field2 EXCEPT * ).|.
LOOP AT lt_type4 ASSIGNING <lfs_type4>.
  WRITE : / <lfs_type4>-field1, space, <lfs_type4>-field2, space, <lfs_type4>-field3.
ENDLOOP.
