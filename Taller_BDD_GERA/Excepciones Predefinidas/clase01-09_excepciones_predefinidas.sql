--NO_DATA_FOUND — Ejemplo con Punto Ticket

DECLARE
    v_nombre CLIENTE.nombre%TYPE;
BEGIN
    SELECT nombre INTO v_nombre
    FROM CLIENTE
    WHERE email = 'noexiste@gmail.com';

    DBMS_OUTPUT.PUT_LINE('Cliente: ' || v_nombre);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el cliente.');
END;
/

--TOO_MANY_ROWS — Ejemplo con Punto Ticket

DECLARE
    v_nombre CLIENTE.nombre%TYPE;
BEGIN
    -- Hay 5 clientes en la tabla, esto falla
    SELECT nombre INTO v_nombre
    FROM CLIENTE;

    DBMS_OUTPUT.PUT_LINE(v_nombre);
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('La consulta retornó más de un cliente.');
        DBMS_OUTPUT.PUT_LINE('Use un cursor para recorrer múltiples filas.');
END;

--ZERO_DIVIDE

DECLARE
    v_resultado NUMBER;
BEGIN
    v_resultado := 100 / 0;
    DBMS_OUTPUT.PUT_LINE(v_resultado);
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Error: no se puede dividir por cero.');
END;

--DUP_VAL_ON_INDEX — Ejemplo con Punto Ticket

BEGIN
    INSERT INTO CLIENTE (rut, nombre, apellido, email)
    VALUES ('19.456.789-1', 'Otro', 'Nombre', 'otro@gmail.com');
    -- El RUT '19.456.789-1' ya existe (Valentina Soto)
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: el RUT ya está registrado.');
END;

--VALUE_ERROR e INVALID_NUMBER

DECLARE
    v_texto VARCHAR2(5);
BEGIN
    v_texto := 'Este texto es demasiado largo';
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Error: el valor excede el tamaño de la variable.');
END;

--Capturar múltiples excepciones

DECLARE
    v_nombre CLIENTE.nombre%TYPE;
    v_precio LOCALIDAD_EVENTO.precio%TYPE;
BEGIN
    SELECT nombre INTO v_nombre
    FROM CLIENTE
    WHERE email = 'valentina.soto@gmail.com';

    v_precio := v_nombre / 0; -- Esto provocará ZERO_DIVIDE
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Cliente no encontrado.');
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('División por cero.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
END;

--WHEN OTHERS — El comodín

DECLARE
    v_nombre_cliente CLIENTE.nombre%TYPE;
BEGIN
    -- Intentamos buscar un cliente usando un email que no existe
    SELECT nombre 
    INTO v_nombre_cliente 
    FROM CLIENTE 
    WHERE email = 'usuario_inexistente@email.com';

    DBMS_OUTPUT.PUT_LINE('Nombre del cliente: ' || v_nombre_cliente);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Código: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Mensaje: ' || SQLERRM);
END;
/