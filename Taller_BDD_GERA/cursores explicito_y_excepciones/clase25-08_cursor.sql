--Usando cursores

--Entender cual es la data que queremos consultar

SELECT * FROM cliente;

DECLARE 
    CURSOR c_clientes IS 
        SELECT * FROM cliente;
    
    v_contador NUMBER := 1;
BEGIN
    FOR por_cada_cliente IN c_clientes LOOP
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || por_cada_cliente.Nombre);
        DBMS_OUTPUT.PUT_LINE('numero_vueltas: ' || v_contador);
        v_contador := v_contador + 1;
    END LOOP;
END;
/


-- Ejercicio ejemplo 1


DECLARE 
    CURSOR c_evento IS 
        SELECT * FROM EVENTO;
    
    v_contador NUMBER := 1;
BEGIN
    FOR por_cada_evento IN c_evento LOOP
        DBMS_OUTPUT.PUT_LINE('Nombre evento: ' || por_cada_evento.Nombre);
        DBMS_OUTPUT.PUT_LINE('Descripcion: ' ||por_cada_evento.Descripcion);
        DBMS_OUTPUT.PUT_LINE('Fecha_evento: ' || por_cada_evento.fecha_evento);

        DBMS_OUTPUT.PUT_LINE('numero_vueltas_consultas: ' || v_contador);
        v_contador := v_contador + 1;
    END LOOP;
END;
/



-- Ejercicio ejemplo 2

SELECT * FROM RESERVA_TEMPORAL;

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
WHERE tp.estado = 'APROBADO';

--Usuarios aprobados
DECLARE
    CURSOR c_tp_aprobadas IS
        SELECT c.nombre AS Nombre_Del_Cliente,
               rt.ESTADO AS Estado_De_La_Reserva,
               tp.estado AS Estado_Pago,
               tp.monto_bruto AS Monto_Bruto,
               tp.descuento AS Descuento,
               tp.monto_final AS Monto_Final
        FROM CLIENTE c
        INNER JOIN RESERVA_TEMPORAL rt ON rt.CLIENTE_ID = c.CLIENTE_ID
        INNER JOIN TRANSACCION_PAGO tp ON tp.RESERVA_ID = rt.RESERVA_ID
        WHERE tp.estado = 'APROBADO';

BEGIN 
    -- Print the header once before the loop starts
    DBMS_OUTPUT.PUT_LINE('=============================');
    DBMS_OUTPUT.PUT_LINE('    INFORME TRANSACCIONES    ');
    DBMS_OUTPUT.PUT_LINE('=============================');

    FOR v_fila IN c_tp_aprobadas LOOP
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_fila.Nombre_Del_Cliente);
        DBMS_OUTPUT.PUT_LINE('Monto Bruto: ' || v_fila.Monto_Bruto);
        DBMS_OUTPUT.PUT_LINE('Descuento: ' || v_fila.Descuento);
        DBMS_OUTPUT.PUT_LINE('Monto Final: ' || v_fila.Monto_Final);
        DBMS_OUTPUT.PUT_LINE('-----------------------------');
    END LOOP;

END;
/
--Usuarios Rechazados
DECLARE
    CURSOR c_tp_aprobadas IS
        SELECT c.nombre AS Nombre_Del_Cliente,
               rt.ESTADO AS Estado_De_La_Reserva,
               tp.estado AS Estado_Pago,
               tp.monto_bruto AS Monto_Bruto,
               tp.descuento AS Descuento,
               tp.monto_final AS Monto_Final
        FROM CLIENTE c
        INNER JOIN RESERVA_TEMPORAL rt ON rt.CLIENTE_ID = c.CLIENTE_ID
        INNER JOIN TRANSACCION_PAGO tp ON tp.RESERVA_ID = rt.RESERVA_ID
        WHERE tp.estado = 'Rechazado';

BEGIN 
    -- Print the header once before the loop starts
    DBMS_OUTPUT.PUT_LINE('=============================');
    DBMS_OUTPUT.PUT_LINE('    INFORME TRANSACCIONES    ');
    DBMS_OUTPUT.PUT_LINE('=============================');

    FOR v_fila IN c_tp_aprobadas LOOP
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_fila.Nombre_Del_Cliente);
        DBMS_OUTPUT.PUT_LINE('Monto Bruto: ' || v_fila.Monto_Bruto);
        DBMS_OUTPUT.PUT_LINE('Descuento: ' || v_fila.Descuento);
        DBMS_OUTPUT.PUT_LINE('Monto Final: ' || v_fila.Monto_Final);
        DBMS_OUTPUT.PUT_LINE('-----------------------------');
    END LOOP;

END;
/




-- Cursor con parametros

DECLARE
    CURSOR c_clientes_por_apellido(P_apellido VARCHAR2) IS
        SELECT
            CLIENTE_ID, nombre,apellido,email
        FROM CLIENTE
        where apellido = P_apellido;
BEGIN
    --"1 usuario Vargas / 3 usuarios vargas"
    FOR un_cliente in c_clientes_por_apellido('vargas') LOOP
        DBMS_OUTPUT.PUT_LINE(un_cliente.nombre);
        DBMS_OUTPUT.PUT_LINE(un_cliente.apellido);
    END LOOP;

END;
/


--insertamos mas apellidos "vargas"

insert into cliente(RUT, nombre, apellido, email, telefono, fecha_registro) VALUES ('11.111.111-1','Matias','vargas','matiasvargas@gmail.com', '+56955556666', systimestamp );
insert into cliente(RUT, nombre, apellido, email, telefono, fecha_registro) VALUES ('12.122.122-2','Maria','vargas','mariavargas@gmail.com', '+56955557777', systimestamp);
insert into cliente(RUT, nombre, apellido, email, telefono, fecha_registro) VALUES ('13.133.133-3','Marta','vargas','martavargas@gmail.com', '+56955558888', systimestamp);
commit;