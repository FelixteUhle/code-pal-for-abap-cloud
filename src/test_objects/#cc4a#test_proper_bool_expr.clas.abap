CLASS /cc4a/test_proper_bool_expr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CONSTANTS: bool TYPE abap_bool VALUE 'X'.
    DATA a TYPE abap_bool.

    TYPES: BEGIN OF number_and_bool,
             number  TYPE i,
             boolean TYPE abap_bool,
           END OF number_and_bool.

    TYPES: BEGIN OF struc_of_nab,
             nab TYPE number_and_bool,
           END OF struc_of_nab.

    TYPES tabletype TYPE TABLE OF number_and_bool WITH EMPTY KEY.

    TYPES: BEGIN OF struc_of_table,
             table TYPE tabletype,
           END OF struc_of_table.

    DATA table2 TYPE TABLE OF struc_of_table.
    TYPES j TYPE TABLE OF struc_of_nab.

    DATA table TYPE tabletype.
    DATA structure_of_table TYPE struc_of_table.
    DATA abapboolean TYPE abap_boolean.

    DATA number_bool_table TYPE TABLE OF number_and_bool.
    DATA number_bool_structure TYPE number_and_bool.
    DATA strc_nab_table TYPE TABLE OF struc_of_nab.
    DATA test_struc_nab TYPE struc_of_nab.
    METHODS test_method
      IMPORTING iparameter        TYPE i OPTIONAL
      RETURNING VALUE(rparameter) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS test_if_then_else.
    METHODS test_correct_bool_usage.
    METHODS test_bool_initial.
    DATA int_tab TYPE RANGE OF i.
    DATA x TYPE i.
ENDCLASS.



CLASS /cc4a/test_proper_bool_expr IMPLEMENTATION.

  METHOD test_if_then_else.
    DATA(test) = 'test'.
    DATA(test_number) = 5.
    DATA(b) = abap_true.
    IF test IS INITIAL. "finding1 erwartet
      b = abap_true.
    ELSE.
      b = ABAP_false.
    ENDIF.

    IF test IS INITIAL. "finding erwartet
      b = abap_false.
    ELSE.
      b = abap_true.
    ENDIF.

    IF test IS NOT INITIAL. "finding erwartet
      b = abap_false.
    ELSE.
      b = abap_true.
    ENDIF.

    IF x IN int_tab. "finding erwartet
      b = abap_false.
    ELSE.
      b = abap_true.
    ENDIF.

    IF x NOT IN int_tab. "finding erwartet
      b = abap_false.
    ELSE.
      b = abap_true.
    ENDIF.

    IF test_number LT 38. "finding erwartet
      b = abap_false.
    ELSE.
      b = abap_true.
    ENDIF.

    IF test_number <> 4 OR test IS NOT INITIAL. "finding erwartet
      b = abap_false.
    ELSE.
      b = abap_true.
    ENDIF.

    DATA(string) = 'teststring'.
    IF 1 = 2 AND 'test' NE substring( len = test_method( iparameter = 3 ) val = string ) AND 5 GT 2. "finding erwartet
      b = ' '. "kein finding erwartet, da es ein XSDBOOL werden soll
    ELSE.
      b = 'X'. "kein finding erwartet, da es ein XSDBOOL werden soll
    ENDIF.

    IF a IS NOT INITIAL. "finding erwartet
      number_bool_structure-boolean = abap_false.
    ELSE.
      number_bool_structure-boolean = abap_true.
    ENDIF.

    IF a IS INITIAL. "finding1 erwartet
      b = abap_true.
    ELSE.
      b = ABAP_false.
    ENDIF.

    IF table2[ 4 ]-table[ 1 ]-boolean IS INITIAL. "finding1 erwartet
      b = ABAP_false.
    ELSE.
      b = ABAP_true.
    ENDIF.

    IF table2[ 4 ]-table[ 1 ]-boolean IS INITIAL. "finding1 erwartet
      data(c) = abap_true.
    ELSE.
      c = ABAP_false.
    ENDIF.



  ENDMETHOD.


  METHOD test_correct_bool_usage.
    DATA t TYPE abap_bool.
    t = 'X'.  "finding erwartet
    number_bool_structure-boolean = ' '. "finding erwartet
    a = space.  "finding erwartet
    test_struc_nab-nab-boolean = 'X'.


  ENDMETHOD.

  METHOD test_bool_initial.
    IF a IS  INITIAL. "finding erwartet
    ENDIF.
    IF table2[ 4 ]-table[ 1 ]-boolean IS INITIAL.  "finding erwartet
    ENDIF.
    IF test_struc_nab-nab-boolean IS INITIAL.
    ENDIF.
  ENDMETHOD.


  METHOD test_method.

  ENDMETHOD.

ENDCLASS.

