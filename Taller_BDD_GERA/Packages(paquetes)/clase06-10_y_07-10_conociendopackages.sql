--EJEMPLO 1 "Conociendo PACKAGES" // usuario : gera1 // fecha: 06-10-2026

--Necesita la SPEC del package

CREATE OR REPLACE PACKAGE pkg_boleteria

AS
  g_cantidad_entradas_vendidas NUMBER;
  FUNCTION fn_verificar_stock(p_localidad_evento_id IN NUMBER)
  RETURN NUMBER;
  PROCEDURE sp_venta_entrada(p_localidad_evento_id IN NUMBER, p_cantidad_entradas_a_comprar IN NUMBER);
end pkg_boleteria;
/



--Body del package

CREATE OR REPLACE PACKAGE BODY pkg_boleteria

AS
  FUNCTION fn_verificar_stock(p_localidad_evento_id IN NUMBER)
    RETURN NUMBER
    AS
      v_stock_disponible NUMBER;
    BEGIN
      SELECT STOCK_DISPONIBLE INTO v_stock_disponible FROM LOCALIDAD_EVENTO WHERE LOCALIDAD_EVENTO_ID = p_localidad_evento_id;
      RETURN v_stock_disponible;
    END fn_verificar_stock;
    PROCEDURE sp_venta_entrada(p_localidad_evento_id IN NUMBER, p_cantidad_entradas_a_comprar IN NUMBER)
    AS
      v_stock_disponible NUMBER;
    BEGIN
        v_stock_disponible := fn_verificar_stock(p_localidad_evento_id);
        IF v_stock_disponible <= 0 THEN

          RAISE_APPLICATION_ERROR(-20001 , 'No queda stock para ese evento en concreto');

        END IF;

        UPDATE LOCALIDAD_EVENTO SET STOCK_DISPONIBLE = STOCK_DISPONIBLE - p_cantidad_entradas_a_comprar WHERE LOCALIDAD_EVENTO_ID = p_localidad_evento_id;

        g_cantidad_entradas_vendidas := g_cantidad_entradas_vendidas + p_cantidad_entradas_a_comprar;

    END sp_venta_entrada;

END pkg_boleteria;
/


SELECT STOCK_DISPONIBLE FROM LOCALIDAD_EVENTO WHERE LOCALIDAD_EVENTO_ID = 1;


--SEGUNDA PARTE 07/10/2026

DECLARE

    v_stock NUMBER;

begin

    v_stock := PKG_BOLETERIA.FN_VERIFICAR_STOCK(1);

    dbms_output.put_line(PKG_BOLETERIA.FN_VERIFICAR_STOCK(1));

    v_stock := PKG_BOLETERIA.FN_VERIFICAR_STOCK(1);

    dbms_output.put_line(PKG_BOLETERIA.FN_VERIFICAR_STOCK(1));

    PKG_BOLETERIA.SP_VENTA_ENTRADA(1,3);

    DBMS_OUTPUT.PUT_LINE('El total de entradas vendidas es: '||PKG_BOLETERIA.g_cantidad_entradas_vendidas);

END;

/