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