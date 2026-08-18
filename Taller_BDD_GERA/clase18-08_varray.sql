--EJERCICIO EJEMPLO 1 // usuario : gera1 // fecha: 18-08-2026
DECLARE

    TYPE ASIENTOS_CINE IS VARRAY(10) OF VARCHAR2(3);
    v_asientos ASIENTOS_CINE := ASIENTOS_CINE('A1','A2','A3','A4','A5','A6','A7','A8','A9','A10');

BEGIN
    DBMS_OUTPUT.PUT_LINE('Se le asigno el asiento N° ' || v_asientos(3));
    NULL;
END;
/


-- EJERCICIO EJEMPLO 2

DECLARE

    TYPE RUT_CLIENTE IS VARRAY(3) OF VARCHAR2(12);
    v_rut_cliente RUT_CLIENTE := RUT_CLIENTE('13.456.789-0','18.765.432-1','14.443.467-K');  

BEGIN

    DBMS_OUTPUT.PUT_LINE('Rut:' || v_rut_cliente(3));
    NULL;
END;
/

--Como se hace de manera procedural

DECLARE

    TYPE RUT_CLIENTE IS VARRAY(3) OF VARCHAR2(12);
    v_rut_cliente RUT_CLIENTE := RUT_CLIENTE();  

BEGIN
    --rut 1
    v_rut_cliente.EXTEND;
    v_rut_cliente(1) := '15.256.567-8'; 
    --rut 2
    v_rut_cliente.EXTEND;
    v_rut_cliente(2) := '17.890.455-6'; 
    --rut 3
    v_rut_cliente.EXTEND;
    v_rut_cliente(3) := '10.123.908-K'; 

    DBMS_OUTPUT.PUT_LINE('Rut:' || v_rut_cliente(1));
    DBMS_OUTPUT.PUT_LINE('Rut:' || v_rut_cliente(2));
    DBMS_OUTPUT.PUT_LINE('Rut:' || v_rut_cliente(3));
    NULL;
END;
/
