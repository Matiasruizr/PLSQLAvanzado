SELECT COUNT(TNAME) FROM TAB WHERE TNAME = 'ERROR';

SELECT * FROM TAB;

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE SP_ERROR(V_ID IN NUMBER, V_USER IN VARCHAR2, V_SQLERM IN VARCHAR) IS
    V_ERROR NUMBER;                          
BEGIN
    -- Comprueba si existe la tabla error.
    SELECT COUNT(TNAME) 
    INTO V_ERROR
    FROM TAB WHERE TNAME = 'ERROR';
    
    DBMS_OUTPUT.PUT_LINE(V_ERROR);
    
    
    IF V_ERROR = 0 THEN
        -- Crea la tabla error
        EXECUTE IMMEDIATE 'create table error(id number, fecha date, usuario varchar2(39), error varchar2(250) )';
        
        --Inseta los datos pasados por parametro en la tabla error
        EXECUTE IMMEDIATE 'insert into error values('||V_ID||','||sysdate||','||V_USER||','||V_SQLERM||')';
    END IF;
END SP_ERROR;
/

DECLARE 
BEGIN
    SP_ERROR(1,'USUARIO','ERROR');
END;
/

DROP TABLE ERROR;


SELECT * FROM ERROR;
