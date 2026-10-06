--EJERCICIO EJEMPLO 1 // usuario : gera1 // fecha: 29-09-2026

CREATE OR REPLACE TRIGGER trg_validar_stock_reserva
BEFORE INSERT ON RESERVA_TEMPORAL
FOR EACH ROW
DECLARE
    v_stock NUMBER;
BEGIN
    -- Consultar stock de la localidad (otra tabla → sin mutating)
    SELECT stock_disponible INTO v_stock
    FROM LOCALIDAD_EVENTO
    WHERE localidad_evento_id = :NEW.localidad_evento_id;

    -- Si no hay stock, impedir el INSERT
    IF v_stock <= 0 THEN
        RAISE_APPLICATION_ERROR(-20050,
            'Sin stock disponible para la localidad ' ||
            :NEW.localidad_evento_id);
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20051,
            'Localidad no encontrada: ' ||
            :NEW.localidad_evento_id);
END trg_validar_stock_reserva;

--EJEMPLO 2

-- Primero, crear la tabla de log
CREATE TABLE LOG_ESTADO_RESERVA (
    log_estado_id    NUMBER GENERATED ALWAYS AS IDENTITY,
    reserva_id       NUMBER NOT NULL,
    estado_anterior  VARCHAR2(20),
    estado_nuevo     VARCHAR2(20) NOT NULL,
    fecha_cambio     TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,

    CONSTRAINT pk_log_estado_reserva
        PRIMARY KEY (log_estado_id),
    CONSTRAINT fk_log_estado_reserva
        FOREIGN KEY (reserva_id)
        REFERENCES RESERVA_TEMPORAL (reserva_id)
);

-- Luego, el trigger
CREATE OR REPLACE TRIGGER trg_historial_estado_reserva
AFTER UPDATE OF estado ON RESERVA_TEMPORAL
FOR EACH ROW
WHEN (OLD.estado != NEW.estado)
BEGIN
    INSERT INTO LOG_ESTADO_RESERVA (
        reserva_id, estado_anterior, estado_nuevo
    ) VALUES (
        :OLD.reserva_id,
        :OLD.estado,
        :NEW.estado
    );
END trg_historial_estado_reserva;