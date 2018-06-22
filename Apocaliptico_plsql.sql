SET SERVEROUTPUT ON;


/* 4. Cree un procedimiento almacenado que normalice el valor de subtotal
de los detalles de las facturas, para confirmar lo
realizado debe crear un bloque anónimo que compruebe los datos ingresados 
(debe mostrar por pantalla los datos de detalle factura).  */
CREATE OR REPLACE PROCEDURE normalizar_subtotal IS
    l_mensaje VARCHAR2(100) := '¡Hola Mundo!';
  BEGIN
    DBMS_OUTPUT.put_line(l_mensaje);
  END hola_mundo;
  /
  
  select * from DETALLE_FACTURA;
  
  SELECT * FROM DETALLE_FACTURA DF JOIN PRODUCTO P ON DF.CODIGO_PROD = P.CODIGO_PROD;
  
  
DECLARE
    CURSOR C_D_FACTURAS IS SELECT * FROM DETALLE_FACTURA;
    PRECIO_PRODUCTO PRODUCTO.PRECIO%TYPE;
    SUBTOTAL DETALLE_FACTURA.SUBTOTAL%TYPE;
BEGIN
    FOR DETALLE_FACTURA IN C_D_FACTURAS LOOP
    
      --  DBMS_OUTPUT.PUT_LINE(DETALLE_FACTURA.NUM_FACTURA);
      --  DBMS_OUTPUT.PUT_LINE(DETALLE_FACTURA.CODIGO_PROD);
        SELECT PRODUCTO.PRECIO 
        INTO PRECIO_PRODUCTO
        FROM PRODUCTO 
        WHERE PRODUCTO.CODIGO_PROD = DETALLE_FACTURA.CODIGO_PROD;
        
        -- Impresion de datos por pantalla
        DBMS_OUTPUT.PUT_LINE('Precio del producto: '||PRECIO_PRODUCTO);
        DBMS_OUTPUT.PUT_LINE('Cantidad comprada: '||DETALLE_FACTURA.CANTIDAD);
        SUBTOTAL := PRECIO_PRODUCTO * DETALLE_FACTURA.CANTIDAD;
        DBMS_OUTPUT.PUT_LINE('Subtotal: '||SUBTOTAL);
        DBMS_OUTPUT.PUT_LINE('==============================');
        
        
        
    END LOOP;   
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    PRECIO_PRODUCTO := NULL;    
END;
/  


   
