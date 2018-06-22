SET SERVEROUTPUT ON;


/* Creando procedimiento almacenado con parametro */

CREATE OR REPLACE PROCEDURE SP_SALUDAR (NOMBRE IN VARCHAR2) IS
    MENSAJE VARCHAR2(50);
BEGIN
    MENSAJE := 'Hola!, '||NOMBRE||', ¿Como estás?.'; 
    DBMS_OUTPUT.PUT_LINE(MENSAJE);
END SP_SALUDAR;
/

-- 

BEGIN
    SP_SALUDAR('Matias');
END;
