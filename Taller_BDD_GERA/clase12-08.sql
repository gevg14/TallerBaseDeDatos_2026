--Ejercicio 1 // usuario : gera1 // fecha: 12-08-2026

SELECT * FROM CLIENTE;
SELECT * FROM TRANSACCION_PAGO;
SELECT * FROM RESERVA_TEMPORAL;

--NOMBRE
SELECT NOMBRE FROM CLIENTE;
--Monto(bruto)
SELECT monto_bruto FROM TRANSACCION_PAGO;
--Descuento aplicado
SELECT DESCUENTO FROM TRANSACCION_PAGO;
--Monto final pagado
SELECT monto_final FROM TRANSACCION_PAGO;
--Estado del pago
SELECT ESTADO FROM TRANSACCION_PAGO;


SELECT 
    c.nombre as Nombre_Del_Cliente,
    rt.ESTADO as Estado_De_Le_Reserva,
    tp.estado AS Estado_Pago,
    tp.monto_bruto AS Monto_Bruto,
    tp.descuento as Descuento,
    tp.monto_final as Monto_Final
    

FROM CLIENTE c
INNER JOIN RESERVA_TEMPORAL rt on rt.CLIENTE_ID = c.CLIENTE_ID
Inner Join TRANSACCION_PAGO tp on tp.RESERVA_ID = rt.RESERVA_ID
WHERE c.CLIENTE_ID = 1;


DECLARE
    TYPE boleta_Cliente IS RECORD(
        NOMBRE_CLIENTE CLIENTE.NOMBRE%TYPE,
        estado_reserva RESERVA_TEMPORAL.estado%TYPE,
        estado_pago TRANSACCION_PAGO.ESTADO%TYPE,
        monto_bruto TRANSACCION_PAGO.MONTO_BRUTO%TYPE,
        descuento_monto TRANSACCION_PAGO.DESCUENTO%TYPE,
        monto_final TRANSACCION_PAGO.MONTO_FINAL%TYPE
    );

    v_boleta boleta_Cliente;
BEGIN
    SELECT 
    c.nombre as Nombre_Del_Cliente,
    rt.ESTADO as Estado_De_Le_Reserva,
    tp.estado AS Estado_Pago,
    tp.monto_bruto AS Monto_Bruto,
    tp.descuento as Descuento,
    tp.monto_final as Monto_Final
    INTO v_boleta.nombre, v_boleta.estado_reserva,v_boleta.estado_pago,v_boleta.monto_bruto,v_boleta.descuento_monto,v_boleta.monto_final
    FROM CLIENTE c
    INNER JOIN RESERVA_TEMPORAL rt on rt.CLIENTE_ID = c.CLIENTE_ID
    Inner Join TRANSACCION_PAGO tp on tp.RESERVA_ID = rt.RESERVA_ID
    WHERE c.CLIENTE_ID = 1;


    DBMS_OUTPUT.PUT_LINE('******** PUNTO TICKET DUOC ********');
    DBMS_OUTPUT.PUT_LINE('***********************************');
    DBMS_OUTPUT.PUT_LINE('|| Nombre Del cliente: ' || v_boleta.NOMBRE_CLIENTE ||'||');
    DBMS_OUTPUT.PUT_LINE('|| ESTADO RESERVA: ' || v_boleta.estado_reserva ||'||');
    DBMS_OUTPUT.PUT_LINE('|| ESTADO DE PAGO: ' || v_boleta.Estado_Pago ||'||');
    DBMS_OUTPUT.PUT_LINE('|| Monto Bruto: ' || v_boleta.monto_bruto ||'||');
    DBMS_OUTPUT.PUT_LINE('|| Descuento: ' || v_boleta.descuento ||'||');
    DBMS_OUTPUT.PUT_LINE('|| Monto final: ' || v_boleta.monto_final ||'||');
    NULL;

END;