SET SERVEROUTPUT ON;


CREATE OR REPLACE PACKAGE PKG_CUENTAS_CONSOLIDADAS AS
    PROCEDURE PS_NORMALIZA_FACTURAS(V_MES IN NUMBER, V_ANIO IN NUMBER);
    FUNCTION IVA_MES(V_MES IN NUMBER, V_ANIO IN NUMBER) RETURN IVA;
END PKG_CUENTAS_CONSOLIDADAS;
/


SELECT * FROM FACTURA;
SELECT * FROM DETALLE_FACTURA;

SELECT * FROM FACTURA 
JOIN DETALLE_FACTURA ON FACTURA.NUM_FACTURA = DETALLE_FACTURA.NUM_FACTURA
JOIN PRODUCTO ON DETALLE_FACTURA.CODIGO_PROD = PRODUCTO.CODIGO_PROD;

CREATE OR REPLACE PROCEDURE PS_NORMALIZA_FACTURAS(V_MES IN NUMBER, V_ANIO IN NUMBER) IS
    l_mensaje VARCHAR2(100) := '¡Hola Mundo! '||V_MES||' '||V_ANIO;
BEGIN
    DBMS_OUTPUT.put_line(l_mensaje);
    
    CALCULO_IVA, CALCULO_NETO y CALCULO_TOTAL.
END PS_NORMALIZA_FACTURAS;
/

SELECT * FROM FACTURA 
JOIN DETALLE_FACTURA ON FACTURA.NUM_FACTURA = DETALLE_FACTURA.NUM_FACTURA
JOIN PRODUCTO ON DETALLE_FACTURA.CODIGO_PROD = PRODUCTO.CODIGO_PROD
WHERE to_char(FECHA, 'MM') = 06
AND to_char(FECHA, 'YY') = 17;



DECLARE
    CURSOR C_FACTURAS IS SELECT * FROM FACTURA 
                        JOIN DETALLE_FACTURA ON FACTURA.NUM_FACTURA = DETALLE_FACTURA.NUM_FACTURA
                        JOIN PRODUCTO ON DETALLE_FACTURA.CODIGO_PROD = PRODUCTO.CODIGO_PROD
                        WHERE to_char(FECHA, 'MM') = V_MES
                        AND to_char(FECHA, 'YY') = V_ANIO;
BEGIN
    FOR F IN C_FACTURAS LOOP
         DBMS_OUTPUT.put_line('SUBTOTAL '||F.PRECIO*F.CANTIDAD);
         DBMS_OUTPUT.put_line('======================');
    END LOOP;
END;
/
/* 
b) Procedimiento CALCULO_COMISION, el cual ingrese en la tabla COMISION las
comisiones que han ganado los empleados, la comisión corresponde al 10% del total
neto de la venta, para estos cálculos se debe ingresar el año y el mes del cual se
deberá realizar los cálculos de las comisiones.
*/
SELECT * FROM COMISION;
SELECT * FROM FACTURA;
CREATE OR REPLACE PROCEDURE PS_CALCULO_COMISION(V_MES IS NUMBER, V_ANIO IS NUMBER) IS

BEGIN

END;
/
CREATE OR REPLACE FUNCTION 
    IVA_MES(V_MES IN NUMBER, V_ANIO IN NUMBER) RETURN VARCHAR2 IS
BEGIN
    RETURN 'Hola ' || V_MES|| V_ANIO;
END IVA_MES;
/


/* 3) El cuerpo (implementación) del package debe tener lo siguiente.
a) Procedimiento NORMALIZA_FACTURAS, el cual debe realizar la normalización
de los valores de la tabla FACTURA con los detalles la tabla
DETALLE_FACTURA, para estos cálculos se debe ingresar el año y el mes del
cual se deberá realizar, para ello debe utilizar las funciones privadas
CALCULO_IVA, CALCULO_NETO y CALCULO_TOTAL. */

DECLARE 

BEGIN
    PS_NORMALIZA_FACTURAS(5,10);
    DBMS_OUTPUT.PUT_LINE(IVA_MES(5,10));
END;
/

CREATE OR REPLACE PACKAGE BODY PKG_CUENTAS_CONSOLIDADAS IS
    V_PORC_IVA NUMBER 19;
BEGIN
    
    
END;
/

drop function CALCULO_NETO;

select * from factura;

-- D)
CREATE OR REPLACE FUNCTION 
    CALCULO_NETO(V_NUM_FACTURA IN NUMBER,V_MES IN NUMBER, V_ANIO IN NUMBER) RETURN NUMBER IS
    CURSOR C_FACTURAS IS SELECT * FROM FACTURA 
                        JOIN DETALLE_FACTURA ON FACTURA.NUM_FACTURA = DETALLE_FACTURA.NUM_FACTURA
                        JOIN PRODUCTO ON DETALLE_FACTURA.CODIGO_PROD = PRODUCTO.CODIGO_PROD
                        WHERE to_char(FECHA, 'MM') = V_MES
                        AND to_char(FECHA, 'YY') = V_ANIO
                        AND FACTURA.NUM_FACTURA = V_NUM_FACTURA;
   V_SUBTOTAL NUMBER := 0;    
   V_DESCUENTO NUMBER := 0;
BEGIN
    FOR F IN C_FACTURAS LOOP
         V_SUBTOTAL := V_SUBTOTAL + (F.PRECIO * F.CANTIDAD);  
         V_DESCUENTO := F.DESCUENTO;
    END LOOP; 
         V_SUBTOTAL := V_SUBTOTAL- (V_SUBTOTAL *(V_DESCUENTO/100)); 
     RETURN V_SUBTOTAL;
END CALCULO_NETO;
/


BEGIN
 DBMS_OUTPUT.PUT_LINE(CALCULO_NETO(4875,06,17));
END;
/





/*
Debe controlar cualquier tipo de error que se produzca en el trigger, por ello debe
ingresar de acuerdo al formato solicitado los errores producidos en la tabla
LOG_ERROR, para el cual debe ingresar ID_LOG utilizando la secuencia
SQ_ERROR_LOG.
*/

create table errores_tablas
 (
 id number  not null,
  fecha date not null,
  detalle_error varchar2(150) not null,
  usuario varchar2(30) not null
  );
  
create sequence sq_errores_tabla start with 1;
  

/*

2.2
*/
create or replace trigger trg_proteger_tablas
before drop on prueba3.schema
begin
  raise_application_error(-20001,'no se puede borrar una tabla');
  insert into errores_tablas values(sq_errores_tabla.nextval,sysdate,'no se puede borrar la tabla',user);
end trg_proteger_tablas;
/
