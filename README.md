# PLSQLAvanzado



## Procedimiento almacenado

la Sintax para crear un procedimiento almacenado es 
```
  CREATE OR REPLACE PROCEDURE hola_mundo IS
    l_mensaje VARCHAR2(100) := '¡Hola Mundo!';
  BEGIN
    DBMS_OUTPUT.put_line(l_mensaje);
  END hola_mundo;
```

## Procedimiento almacenado con parametro 
la Sintax para crear un procedimiento almacenado con parametro es 
``` 
  CREATE OR REPLACE PROCEDURE SALUDAR (NOMBRE IN VARCHAR2) IS
    MENSAJE VARCHAR2(50);
  BEGIN
    MENSAJE := 'Hola!, '||NOMBRE||', ¿Como estás?.'; 
    DBMS_OUTPUT.PUT_LINE(MENSAJE);
  END SALUDAR;
```

## Funciones

* El cuerpo o la implementación del subprograma contiene ahora una cláusula RETURN que construye el mensaje y lo devuelve al bloque llamador.
* La cláusula RETURN después de la lista de parámetros establece el tipo de datos devuelto por la función.

la Sintax para crear una funcion con parametro, y para invocar esta es.
```
  CREATE OR REPLACE FUNCTION 
    SALUDO(NOMBRE IN VARCHAR2) RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Hola ' || NOMBRE;
  END SALUDO;
  /

  DECLARE
    MENSAJE VARCHAR2(50) := SALUDO('MATIAS');
  BEGIN 
    DBMS_OUTPUT.PUT_LINE(MENSAJE);
  END;
```

## Triggers

