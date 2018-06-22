SET SERVEROUTPUT ON;


/* Creando procedimiento almacenado basico */

CREATE OR REPLACE PROCEDURE sp_hola_mundo IS
      MENSAJE VARCHAR2(50) := '¡Hola Mundo!';
BEGIN
  DBMS_OUTPUT.put_line(MENSAJE);
END sp_hola_mundo;
/

-- Existen 3 formas de ejecutarlo 

-- 1)
BEGIN
    sp_hola_mundo;
END;
/

-- 2)
EXEC sp_hola_mundo;

-- 3)
EXECUTE sp_hola_mundo;

