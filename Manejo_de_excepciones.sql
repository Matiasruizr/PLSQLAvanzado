SELECT COUNT(TNAME) FROM TAB WHERE TNAME = 'ERROR';

SELECT * FROM TAB;

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE SP_ERROR(V_ID IN NUMBER, V_USUARIO IN VARCHAR2, V_SQLERM IN VARCHAR) IS
    V_ERROR NUMBER;  
    V_INSERCION VARCHAR2(200);
BEGIN
    V_INSERCION := 'insert into error values('||V_ID||','||sysdate||','||V_USUARIO||','||V_SQLERM||')';
    -- Comprueba si existe la tabla error.
    SELECT COUNT(TNAME) 
    INTO V_ERROR
    FROM TAB WHERE TNAME = 'ERROR';
    DBMS_OUTPUT.PUT_LINE(V_INSERCION);
    
    IF V_ERROR = 0 THEN
        -- Crea la tabla error
        EXECUTE IMMEDIATE 'create table error(id number, fecha date, usuario varchar2(39), error varchar2(250) )';
     END IF;
        --Inseta los datos pasados por parametro en la tabla error
       EXECUTE IMMEDIATE V_INSERCION;
   
END SP_ERROR;
/
insert into error values(1,sysdate,'USER','ERROR');
DECLARE 
BEGIN
    SP_ERROR(2,'USUARIO','ERROR');
END;
/

DROP TABLE ERROR;


SELECT * FROM ERROR;
