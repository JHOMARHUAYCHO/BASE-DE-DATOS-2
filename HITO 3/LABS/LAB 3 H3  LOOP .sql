USE hito3_lenguaje_procedural;

REPEAT
    SET STR=CONCAT(STR,X,',');
    SET X=X-1;
UNTIL X<=0 END REPEAT;

#EJERCICIO DE REPASO REPEAT
# CUANDO LA CONDICION ES FALSE EL BUCLE CONTINUA, SI ES TRUE EL BUCLE TERMINA

#EL REPEAT SE EJECUTA AL MENOS UNA VEZ

CREATE OR REPLACE FUNCTION NUMEROS_NATURALES( X INTEGER)
    RETURNS TEXT
    BEGIN
        DECLARE SERIE TEXT DEFAULT '';
        REPEAT
            SET SERIE= CONCAT(SERIE,X,', ');
            SET X=X-1;
        until  X<=0 end repeat;

        RETURN SERIE;
end;

SELECT NUMEROS_NATURALES(0);

#///////////////////////////////////////////////////////////////////////////////////////////////////////

#EJERCICIO 2 REPASO REAPEAT
CREATE OR REPLACE FUNCTION SERIE_NUMEROS_NATURALES( X INTEGER)
    RETURNS TEXT
    BEGIN
        DECLARE SERIE TEXT DEFAULT '';
        REPEAT
            IF X%2=0
            THEN
                SET SERIE= CONCAT(SERIE,X,'-AA- ');
            ELSE
                SET SERIE= CONCAT(SERIE,X,'-BB-');
            end if;
                SET X=X-1;

        until  X<=0 end repeat;
        RETURN SERIE;
end;

SELECT SERIE_NUMEROS_NATURALES(5);

#/////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR REPLACE FUNCTION SERIE_NUMEROS_NATURALES_V2( X INTEGER)
    RETURNS TEXT
    BEGIN
        DECLARE SERIE TEXT DEFAULT '';
        DECLARE NUMERO INTEGER DEFAULT X;

        REPEAT

            IF X%2=0
            THEN
               SET SERIE= CONCAT(SERIE,'-BB-');
            ELSE

                SET SERIE= CONCAT(SERIE,NUMERO);
                SET NUMERO=NUMERO-1;
            end if;
                SET X=X-1;

        until  X<=0 end repeat;
        RETURN SERIE;
end;

SELECT SERIE_NUMEROS_NATURALES_V2(5);

#SENTECIA LOOP
#EJERCICIO 1
CREATE OR REPLACE FUNCTION MANEJO_LOOP(X INTEGER)
RETURNS TEXT
BEGIN
    DECLARE SERIE TEXT DEFAULT '';

    LOOP_LABEL:LOOP
        IF X<=0
            THEN
            LEAVE LOOP_LABEL;
        END IF;

        SET SERIE = CONCAT(SERIE,X,',');
        SET X=X-1;
        ITERATE LOOP_LABEL;
    END LOOP;
    RETURN SERIE;
END;
SELECT MANEJO_LOOP(4);

#/////////////////////////////////////////////////////////////////////////////////////////
#EJERCICIO 2

CREATE OR REPLACE FUNCTION MANEJO_LOOP_V2(X INTEGER)
RETURNS TEXT
BEGIN

    DECLARE SERIE TEXT DEFAULT '';
    DECLARE NUMERO INTEGER;
    SET NUMERO=0;

    LOOP_LABEL:LOOP
        IF NUMERO>=X
            THEN
            LEAVE LOOP_LABEL;
        END IF;

        SET NUMERO=NUMERO+1;
        SET SERIE = CONCAT(SERIE,NUMERO,',');
        ITERATE LOOP_LABEL;
    END LOOP;
    RETURN SERIE;
END;

SELECT MANEJO_LOOP_V2(10);

#////////////////////////////////////////////////////////////////////////////////////////////////////////////
#EJERCICIO 3
#DETERMINAR LOS APELLIDOS DE UNA PERSONA
#RETORNAR UNA FUNCIONA QUE RETORNE UN TEXT
#LA NFUNCION RECIBE EL NOMBRE COMPLETO DE UNA PERSONA
#LA FUNCION SOLO DEBE RETTORNAR APELLIDOS
