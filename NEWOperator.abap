REPORT ztest_abap751_new.


" NEW Operator
DATA lo_ref TYPE REF TO cl_e2e_static_tbom_gap9.
lo_ref = NEW #( ).

DATA(lo_ref1) = NEW cl_e2e_static_tbom_gap9( ).
