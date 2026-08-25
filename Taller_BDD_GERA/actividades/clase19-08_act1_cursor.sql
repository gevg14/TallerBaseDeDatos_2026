--ACTIVIDAD 1 "USANDO CURSOR" // usuario : gera1 // fecha: 19-08-2026


--PROBLEMA 1: 



--PROBLEMA 2:




--PROBLEMA 3:
--El área de operaciones de la plataforma de venta de entradas requiere un reporte detallado de todas las 
--entradas emitidas en el sistema para realizar una auditoría de ventas.
--Se solicita desarrollar un bloque anónimo en PL/SQL que utilice un cursor explícito para recorrer y desplegar la información de cada entrada emitida (TICKET).
--Por cada ticket registrado, se deben obtener y mostrar por consola (DBMS_OUTPUT) los siguientes 5 datos esenciales:

--Código del Ticket (TICKET.codigo_ticket)
--Nombre del Evento (EVENTO.nombre)
--Fecha del Evento (EVENTO.fecha_evento)
--Nombre completo del Cliente (CLIENTE.nombre y CLIENTE.apellido)
--Nombre del Recinto (RECINTO.nombre)

--SOLUCION

SELECT * FROM EVENTO;
SELECT * FROM TICKET;
SELECT * FROM CLIENTE;
SELECT * FROM RECINTO;





SET SERVEROUTPUT ON;

DECLARE

    CURSOR c_ticket_emitido IS 
        SELECT
        t.CODIGO_TICKET,
        e.nombre as Nombre_Evento,
        e.fecha_evento,
        c.nombre ||' '|| c.apellido as Nombre_cliente,
        c.rut as Rut_cliente,
        r.recinto as Nombre_recinto
        FROM Ticket t
        JOIN RESERVA_TEMPORAL rt ON t.RESERVA_ID= rt.RESERVA_ID
        JOIN CLIENTE c ON rt.CLIENTE_ID = c.CLIENTE_ID
        JOIN LOCALIDAD_EVENTO le ON rt.LOCALIDAD_EVENTO_ID = le.LOCALIDAD_EVENTO_ID
        JOIN EVENTO e ON le.EVENTO_ID = e.EVENTO_ID
        JOIN RECINTO r ON e.RECINTO_ID = r.RECINTO_ID
        WHERE t.estado = 'EMITIDO'
        ORDER BY t.ticket_id;

        --La funcion del ROWTYPE sirve para atraer el select del cursor
        v_ticket c_tickets_emitido%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('================================================================================');
    DBMS_OUTPUT.PUT_LINE('================================================================================');
    DBMS_OUTPUT.PUT_LINE('                        REPORTE TICKET EMITIDOS                                 ');
    DBMS_OUTPUT.PUT_LINE('================================================================================');
    DBMS_OUTPUT.PUT_LINE('================================================================================');
    
    OPEN c_ticket_emitido;

    LOOP
        -- Extracción fila por fila
        FETCH c_tickets_emitidos INTO v_ticket;
        EXIT WHEN c_tickets_emitido%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Ticket ID     : ' || v_ticket.CODIGO_TICKET);
        DBMS_OUTPUT.PUT_LINE('Evento        : ' || v_ticket.Nombre_Evento);
        DBMS_OUTPUT.PUT_LINE('Fecha Evento  : ' || TO_CHAR(v_ticket.fecha_evento, 'DD/MM/YYYY HH24:MI'));
        DBMS_OUTPUT.PUT_LINE('Cliente       : ' || v_ticket.Nombre_cliente);
        DBMS_OUTPUT.PUT_LINE('Recinto       : ' || v_ticket.Nombre_recinto);
        DBMS_OUTPUT.PUT_LINE('================================================================================');
        DBMS_OUTPUT.PUT_LINE('================================================================================');
    END LOOP;
    
    
    NULL;
END;
/













SET SERVEROUTPUT ON;

DECLARE
    -- Definición del cursor explícito con los JOINs requeridos
    CURSOR c_tickets_emitidos IS
        SELECT 
            t.codigo_ticket,
            e.nombre          AS evento_nombre,
            e.fecha_evento,
            c.nombre || ' ' || c.apellido AS cliente_nombre,
            r.nombre          AS recinto_nombre
        FROM TICKET t
        JOIN RESERVA_TEMPORAL rt ON t.reserva_id = rt.reserva_id
        JOIN CLIENTE c          ON rt.cliente_id = c.cliente_id
        JOIN LOCALIDAD_EVENTO le ON rt.localidad_evento_id = le.localidad_evento_id
        JOIN EVENTO e           ON le.evento_id = e.evento_id
        JOIN RECINTO r          ON e.recinto_id = r.recinto_id
        WHERE t.estado = 'EMITIDO'
        ORDER BY t.ticket_id;

    -- Variable de registro basada en la estructura del cursor
    v_ticket c_tickets_emitidos%ROWTYPE;

BEGIN
    DBMS_OUTPUT.PUT_LINE('======================================================================');
    DBMS_OUTPUT.PUT_LINE('                   REPORTE DE TICKETS EMITIDOS                        ');
    DBMS_OUTPUT.PUT_LINE('======================================================================');

    -- Apertura explícita del cursor
    OPEN c_tickets_emitidos;
    
    LOOP
        -- Extracción fila por fila
        FETCH c_tickets_emitidos INTO v_ticket;
        EXIT WHEN c_tickets_emitidos%NOTFOUND;

        -- Impresión de los 5 datos requeridos
        DBMS_OUTPUT.PUT_LINE('Ticket ID     : ' || v_ticket.codigo_ticket);
        DBMS_OUTPUT.PUT_LINE('Evento        : ' || v_ticket.evento_nombre);
        DBMS_OUTPUT.PUT_LINE('Fecha Evento  : ' || TO_CHAR(v_ticket.fecha_evento, 'DD/MM/YYYY HH24:MI'));
        DBMS_OUTPUT.PUT_LINE('Cliente       : ' || v_ticket.cliente_nombre);
        DBMS_OUTPUT.PUT_LINE('Recinto       : ' || v_ticket.recinto_nombre);
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------');
    END LOOP;

    -- Cierre del cursor
    CLOSE c_tickets_emitidos;

EXCEPTION
    WHEN OTHERS THEN
        IF c_tickets_emitidos%ISOPEN THEN
            CLOSE c_tickets_emitidos;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Error al generar el reporte: ' || SQLERRM);
END;
/




DECLARE
    CURSOR c_tickets_emitidos IS
        SELECT 
            t.codigo_ticket,
            e.nombre          AS evento_nombre,
            e.fecha_evento,
            c.nombre || ' ' || c.apellido AS cliente_nombre,
            r.nombre          AS recinto_nombre
        FROM TICKET t
        JOIN RESERVA_TEMPORAL rt ON t.reserva_id = rt.reserva_id
        JOIN CLIENTE c          ON rt.cliente_id = c.cliente_id
        JOIN LOCALIDAD_EVENTO le ON rt.localidad_evento_id = le.localidad_evento_id
        JOIN EVENTO e           ON le.evento_id = e.evento_id
        JOIN RECINTO r          ON e.recinto_id = r.recinto_id
        WHERE t.estado = 'EMITIDO'
        ORDER BY t.ticket_id;
BEGIN
    -- El ciclo administra la apertura, fetch y cierre de forma automática
    FOR rec IN c_tickets_emitidos LOOP
        DBMS_OUTPUT.PUT_LINE('Ticket ID     : ' || rec.codigo_ticket);
        DBMS_OUTPUT.PUT_LINE('Evento        : ' || rec.evento_nombre);
        DBMS_OUTPUT.PUT_LINE('Fecha Evento  : ' || TO_CHAR(rec.fecha_evento, 'DD/MM/YYYY HH24:MI'));
        DBMS_OUTPUT.PUT_LINE('Cliente       : ' || rec.cliente_nombre);
        DBMS_OUTPUT.PUT_LINE('Recinto       : ' || rec.recinto_nombre);
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------');
    END LOOP;
END;
/