--EJERCICIO EJEMPLO 1 "parametros de entrada" // usuario : gera1 // fecha: 22-09-2026

CREATE OR REPLACE PROCEDURE registrar_clientes(
    p_rut IN VARCHAR2,
    p_nombre IN VARCHAR2,
    p_apellido IN VARCHAR2,
    p_email IN VARCHAR2,
    p_telefono IN VARCHAR2
)
AS 

BEGIN
    INSERT INTO CLIENTE(RUT, NOMBRE, APELLIDO, EMAIL, TELEFONO) 
    VALUES(p_rut, p_nombre, p_apellido, p_email, p_telefono);

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Cliente ' || p_nombre || ' registrado');
END registrar_clientes;
/

--Ejemplo 2: Insertando cliendo

--Bloque anonimo

DECLARE

BEGIN
    REGISTRAR_CLIENTES('11.111.222-1', 'prueba1', 'prueba', 'pr1@gmail.com', NULL);
END;
/



DROP PROCEDURE REGISTRAR_CLIENTES;


--Ejercicio ejemplo 2 "parametros de salida" 
--crear un procedimiento almacenado que devuelva los datos de un cliente segun su id

CREATE OR REPLACE PROCEDURE datos_cliente(
    p_cliente_id IN NUMBER,
    p_nombre OUT VARCHAR2,
    p_apellido OUT VARCHAR2,
    p_email OUT VARCHAR2,
    p_telefono OUT VARCHAR2
) 
IS

BEGIN 
    SELECT nombre, apellido, email, telefono INTO p_nombre, p_apellido, p_email, p_telefono FROM CLIENTE WHERE CLIENTE_ID = p_cliente_id;
END datos_cliente;
/

DROP PROCEDURE DATOS_CLIENTE;


DECLARE
    v_nombre CLIENTE.NOMBRE%TYPE;
    v_apellido CLIENTE.APELLIDO%TYPE;
    v_email CLIENTE.EMAIL%TYPE;
    v_telefono CLIENTE.TELEFONO%TYPE;

BEGIN

    DATOS_CLIENTE(6, v_nombre, v_apellido, v_email, v_telefono);

    DBMS_OUTPUT.PUT_LINE('Los datos del cliente son: ' || v_nombre || ' ' || v_apellido || ' ' || v_email || ' ' || v_telefono);

END;
/

