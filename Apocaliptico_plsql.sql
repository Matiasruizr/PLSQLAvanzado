set serveroutput on;
/* 1. Se requiere realizar la disminución automática de las existencias de productos,
realice un trigger que normalice la cantidad de productos de acuerdo a los detalles 
de factura ingresados realizados con las existencias en productos. */

select * from producto;

DECLARE 
    CURSOR C_PRODUCTOS IS SELECT * FROM PRODUCTO;
    CURSOR C_DETALLE_FACTURA IS SELECT CODIGO_PROD, SUM(CANTIDAD) AS CANTIDAD 
                                FROM DETALLE_FACTURA
                                GROUP BY CODIGO_PROD;
BEGIN
    FOR P IN C_PRODUCTOS LOOP
        DBMS_OUTPUT.PUT_LINE(P.CODIGO_PROD);        
        FOR DF IN C_DETALLE_FACTURA LOOP
            IF P.CODIGO_PROD = DF.CODIGO_PROD THEN
            DBMS_OUTPUT.PUT_LINE(DF.CODIGO_PROD|| ' ES IGUAL A '||P.CODIGO_PROD||' Y SE HAN VENDIDO '||DF.CANTIDAD||' DE UN TOTAL DE  '||P.EXISTENCIAS);
            END IF;
        END LOOP;
    END LOOP;
END;
/

/* 4. Cree un procedimiento almacenado que normalice el valor de subtotal
de los detalles de las facturas, para confirmar lo
realizado debe crear un bloque anónimo que compruebe los datos ingresados 
(debe mostrar por pantalla los datos de detalle factura).  */
CREATE OR REPLACE PROCEDURE NORMALIZAR_SUBTOTAL IS
    CURSOR C_D_FACTURAS IS SELECT * FROM DETALLE_FACTURA;
    PRECIO_PRODUCTO PRODUCTO.PRECIO%TYPE;
    N_SUBTOTAL DETALLE_FACTURA.SUBTOTAL%TYPE;
BEGIN
    FOR DF IN C_D_FACTURAS LOOP
        SELECT PRODUCTO.PRECIO 
        INTO PRECIO_PRODUCTO
        FROM PRODUCTO 
        WHERE PRODUCTO.CODIGO_PROD = DF.CODIGO_PROD;
        
        N_SUBTOTAL := PRECIO_PRODUCTO * DF.CANTIDAD;
        
        UPDATE DETALLE_FACTURA 
        SET DETALLE_FACTURA.SUBTOTAL = N_SUBTOTAL
        WHERE DETALLE_FACTURA.NUM_FACTURA = DF.NUM_FACTURA;
    END LOOP; 
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    PRECIO_PRODUCTO := NULL;     
END NORMALIZAR_SUBTOTAL;
/

  
DECLARE
    CURSOR C_D_FACTURAS IS SELECT * FROM DETALLE_FACTURA;
    PRECIO_PRODUCTO PRODUCTO.PRECIO%TYPE;
    N_SUBTOTAL DETALLE_FACTURA.SUBTOTAL%TYPE;
BEGIN
    FOR DF IN C_D_FACTURAS LOOP
        SELECT PRODUCTO.PRECIO 
        INTO PRECIO_PRODUCTO
        FROM PRODUCTO 
        WHERE PRODUCTO.CODIGO_PROD = DF.CODIGO_PROD;
        
        -- Impresion de datos por pantalla
        DBMS_OUTPUT.PUT_LINE('Precio del producto: '||PRECIO_PRODUCTO);
        DBMS_OUTPUT.PUT_LINE('Cantidad comprada: '||DF.CANTIDAD);
        N_SUBTOTAL := PRECIO_PRODUCTO * DF.CANTIDAD;
        DBMS_OUTPUT.PUT_LINE('Subtotal: '||N_SUBTOTAL);
        DBMS_OUTPUT.PUT_LINE('==============================');     
        
        UPDATE DETALLE_FACTURA 
        SET DETALLE_FACTURA.SUBTOTAL = 0
        WHERE DETALLE_FACTURA.NUM_FACTURA = DF.NUM_FACTURA;
    END LOOP;   
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    PRECIO_PRODUCTO := NULL;    
END;
/  

SELECT * FROM DETALLE_FACTURA;

EXEC NORMALIZAR_SUBTOTAL;

