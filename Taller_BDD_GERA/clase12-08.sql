--Ejercicio 1 // usuario : gera1 // fecha: 12-08-2026

SELECT * FROM CLIENTE;
SELECT * FROM TRANSACCION_PAGO;

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
    tp.monto_bruto,
    tp.descuento,
    tp.monto_final,
    tp.estado AS estado_pago

FROM CLIENTE c
Inner Join TRANSACCION_PAGO tp on tp.TRANSACCION_ID = c.CLIENTE_ID;