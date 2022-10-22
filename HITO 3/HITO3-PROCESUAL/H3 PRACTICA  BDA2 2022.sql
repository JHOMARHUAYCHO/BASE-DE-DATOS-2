USE prueba;

CREATE OR REPLACE FUNCTION CONCATENAR (A VARCHAR(20),B VARCHAR(20),C VARCHAR(20))
RETURNS VARCHAR(60)
BEGIN
  DECLARE CADENA VARCHAR(60) DEFAULT '';
  SET CADENA= CONCAT(A,' ',B,' ',C);
  RETURN CADENA;
END;

SELECT CONCATENAR('HOLA','COMO','ESTAS');

#EJERCICIO 6
CREATE OR REPLACE FUNCTION SUB_STRING (NOMBRE VARCHAR(50),POSICION INTEGER,LONGITUD INTEGER)
RETURNS VARCHAR(50)
BEGIN
  DECLARE CADENA VARCHAR(50) DEFAULT '';
  SET CADENA= SUBSTRING(NOMBRE,POSICION,LONGITUD);
  RETURN CADENA;
END;

SELECT SUB_STRING('XIMENA CONDORI MAR',1,6);

#EJERCICIO 7
CREATE OR REPLACE FUNCTION COMPARAR (A VARCHAR(20),B VARCHAR(20),C VARCHAR(20))
RETURNS VARCHAR(60)
BEGIN
  DECLARE RESPUESTA VARCHAR(60) DEFAULT '';

  IF STRCMP(A,B)=0 THEN SET RESPUESTA='DOS SON IGUALES ';

         ELSEIF STRCMP(A,C)=0 THEN SET RESPUESTA='DOS SON IGUALES' ;
        ELSEIF STRCMP(B,C)=0 THEN SET RESPUESTA='DOS SON IGUALES' ;
    ELSE
    SET RESPUESTA='NINGUNO SON IGUALES';
  END IF;
  RETURN RESPUESTA;
END;

SELECT COMPARAR('perro','gato','PESCADO');

 #EJERCICIO 8

CREATE OR REPLACE FUNCTION CONTAR_CADENA(A VARCHAR(20))
RETURNS INTEGER
BEGIN
    DECLARE RESPUESTA VARCHAR(20) DEFAULT '';
    SET RESPUESTA=CHAR_LENGTH(A);
   RETURN RESPUESTA;
END;
SELECT CONTAR_CADENA('LORENZO');

CREATE OR REPLACE FUNCTION BUSCAR_CADENA(SUBCADENA VARCHAR(20),CADENA VARCHAR(20))
RETURNS INTEGER
BEGIN
    DECLARE RESP INTEGER DEFAULT 0;
    SET RESP=LOCATE(SUBCADENA,CADENA);
   RETURN RESP;
END;
SELECT BUSCAR_CADENA('OSO','POSODEROSO_LEOPARDO');


#////////////////////////////////////////////////////////////////////////////////////////////
#/////////////////////////      PARTE PRACTICA      ///////////////////////////////
#/////////////////////////////////////////////////////////////////////////////////


#//////////////////////////////////////////////////////////////////////////////////////////////
#//////////////////////////         EJERCICIO 11       ///////////////////////////////
#//////////////////////////////////////////////////////////////////////////////////////
CREATE DATABASE H3_UNIVERSIDAD;
USE H3_UNIVERSIDAD;
CREATE TABLE estudiantes
(
 id_est INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
 nombres VARCHAR(50),
 apellidos VARCHAR(50),
 edad INTEGER,
 fono INTEGER,
 email VARCHAR(100),
 direccion VARCHAR(100),
 sexo VARCHAR(10)
);

CREATE TABLE materias
(
  id_mat INTEGER AUTO_INCREMENT PRIMARY KEY  NOT NULL,
  nombre_mat VARCHAR(100),
  cod_mat VARCHAR(100)
);

CREATE TABLE inscripcion
(
  id_ins INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
  semestre VARCHAR(20),
  gestion INTEGER,

  id_est INT NOT NULL,
  id_mat INT NOT NULL,
  FOREIGN KEY (id_est) REFERENCES estudiantes (id_est),
  FOREIGN KEY (id_mat) REFERENCES materias (id_mat)
);

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email,direccion, sexo)
VALUES  ('Miguel', 'Gonzales Veliz', 20, 2832115,'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino'),
        ('Sandra', 'Mavir Uria', 25, 2832116, 'sandra@gmail.com','Av. 6 de Agosto', 'femenino'),
        ('Joel', 'Adubiri Mondar', 30, 2832117, 'joel@gmail.com','Av. 6 de Agosto', 'masculino'),
        ('Andrea', 'Arias Ballesteros', 21, 2832118,'andrea@gmail.com', 'Av. 6 de Agosto', 'femenino'),
        ('Santos', 'Montes Valenzuela', 24, 2832119,'santos@gmail.com', 'Av. 6 de Agosto', 'masculino');


INSERT INTO materias (nombre_mat, cod_mat)
VALUES  ('Introduccion a la Arquitectura', 'ARQ-101'),
        ('Urbanismo y Diseno', 'ARQ-102'),
        ('Dibujo y Pintura Arquitectonico', 'ARQ-103'),
        ('Matematica discreta', 'ARQ-104'),
        ('Fisica Basica', 'ARQ-105');

INSERT INTO inscripcion (id_est, id_mat, semestre, gestion)
VALUES  (1, 1, '1er Semestre', 2018),
        (1, 2, '2do Semestre', 2018),
        (2, 4, '1er Semestre', 2019),
        (2, 3, '2do Semestre', 2019),
        (3, 3, '2do Semestre', 2020),
        (3, 1, '3er Semestre', 2020),
        (4, 4, '4to Semestre', 2021),
        (5, 5, '5to Semestre', 2021);

#///////////////////////////////////////////////////////////////////
#///////////////////    EJERCICIO 12       ////////////////////////
#//////////////////////////////////////////////////////////////////


CREATE OR REPLACE FUNCTION FIBONANCI(NUMBER INTEGER)

RETURNS TEXT
BEGIN
    DECLARE A INTEGER DEFAULT 0;
    DECLARE B INTEGER DEFAULT 1;
    DECLARE AUX INTEGER DEFAULT 0;
    DECLARE CONTADOR INTEGER DEFAULT 0;
    DECLARE CADENA TEXT DEFAULT '';
    SET CADENA =CONCAT(A,',',B);

IF NUMBER=1 THEN SET CADENA='0';
ELSEIF NUMBER=2 THEN SET CADENA='0,1';
ELSEIF NUMBER<=0 THEN SET CADENA='DEBE SER MAYOR A CERO';
ELSE
    REPEAT

    SET AUX=A+B;
    SET CADENA = CONCAT(CADENA,',',AUX);
    SET A=B;
    SET B=AUX;
    SET CONTADOR=CONTADOR+1;
    UNTIL CONTADOR = NUMBER-2 END REPEAT;
END IF;
    RETURN CADENA;
END;

SELECT FIBONANCI(4);

#///////////////////////////////////////////////////////////////////////
#/////////////////////     EJERCICIO 13     ////////////////////////////
#/////////////////////////////////////////////////////////////////////


SET @LIMIT = 10;

CREATE OR REPLACE FUNCTION FIBONANCI_V2()

RETURNS TEXT
BEGIN
    DECLARE A INTEGER DEFAULT 0;
    DECLARE B INTEGER DEFAULT 1;
    DECLARE AUX INTEGER DEFAULT 0;
    DECLARE CONTADOR INTEGER DEFAULT 0;
    DECLARE CADENA TEXT DEFAULT '';
    SET CADENA =CONCAT(A,',',B);
IF @LIMIT=1 THEN SET CADENA='0';
ELSEIF @LIMIT=2 THEN SET CADENA='0,1';
ELSEIF @LIMIT<=0 THEN SET CADENA='DEBE SER MAYOR A CERO';
ELSE
    REPEAT

    SET AUX=A+B;
    SET CADENA = CONCAT(CADENA,',',AUX);
    SET A=B;
    SET B=AUX;
    SET CONTADOR=CONTADOR+1;
    UNTIL CONTADOR = @LIMIT-2 END REPEAT;
END IF;
    RETURN CADENA;
END;

SELECT FIBONANCI_V2();

#///////////////////////////////////////////////////////////////////////////
#//////////////////   EJERCICIO 14   ////////////////////////////////////
#//////////////////////////////////////////////////////////////////////////

CREATE OR REPLACE FUNCTION EDAD_MINIMA ()
RETURNS INTEGER
BEGIN
    DECLARE NUMERO INTEGER DEFAULT 0;
    SELECT MIN(estudiantes.edad) INTO NUMERO
     FROM estudiantes;
    RETURN NUMERO;
end;

SELECT EDAD_MINIMA();

CREATE OR REPLACE FUNCTION PAR_IMPAR()
RETURNS TEXT
BEGIN
    DECLARE CADENA TEXT DEFAULT '';
    DECLARE AUX INTEGER DEFAULT 0;

    IF EDAD_MINIMA()%2=0 THEN
        WHILE AUX<=EDAD_MINIMA() DO
            SET CADENA=CONCAT(CADENA,AUX,',');
            SET AUX=AUX+2;
        end while;
    ELSE
        SET AUX=EDAD_MINIMA();
        WHILE AUX>=0 DO
            SET CADENA=CONCAT(CADENA,AUX,',');
            SET AUX=AUX-2;
        end while;

    end if;
    RETURN CADENA;
END;

SELECT PAR_IMPAR();

INSERT INTO estudiantes( NOMBRES, APELLIDOS, EDAD, FONO, EMAIL, DIRECCION, SEXO)
VALUES ('ALFREDO','LOZA',19,5345345,'SDFSDFSDFSD','FSDFSDFS','MASCULINO');

#//////////////////////////////////////////////////////////////////////////////////
#/////////////////    EJERCICIO 15   ////////////////////////////////////////////
#/////////////////////////////////////////////////////////////////////////////////////

CREATE OR REPLACE  FUNCTION  CONTAR_VOCALES (PALABRA TEXT)
RETURNS TEXT
BEGIN
    DECLARE RESPUESTA TEXT DEFAULT '';
    DECLARE CONTADOR INTEGER DEFAULT CHAR_LENGTH(PALABRA);
    DECLARE AUX INTEGER DEFAULT 1;
    DECLARE CA INTEGER DEFAULT 0;
    DECLARE CE INTEGER DEFAULT 0;
    DECLARE CI INTEGER DEFAULT 0;
    DECLARE CO INTEGER DEFAULT 0;
    DECLARE CU INTEGER DEFAULT 0;
    DECLARE LETRA TEXT DEFAULT '';

    REPEAT
    SET LETRA=SUBSTRING(PALABRA,AUX,1);
    IF
            STRCMP('A',LETRA)=0 THEN
                SET CA=CA+1;
            ELSEIF STRCMP('E',LETRA)=0 THEN
                SET  CE=CE+1;
            ELSEIF STRCMP('I',LETRA)=0 THEN
                SET  CI=CI+1;
            ELSEIF STRCMP('O',LETRA)=0 THEN
                SET  CO=CO+1;
            ELSEIF STRCMP('U',LETRA)=0 THEN
                SET  CU=CU+1;
    end if;

    SET AUX=AUX+1;
    SET CONTADOR=CONTADOR-1;

    until CONTADOR <=0 end repeat;

    SET RESPUESTA=CONCAT('A=',CA,' E=',CE,' I=',CI,' O=',CO,' U=',CU);
    RETURN RESPUESTA;
end;

SELECT CONTAR_VOCALES('EUCALIPTO');

#//////////////////////////////////////////////////////////////////////////
#///////////////////// EJERICICIO 16    ///////////////////////////////////////
#/////////////////////////////////////////////////////////////////////////////

CREATE OR REPLACE FUNCTION CLASE_CLIENTE( CREDIT_NUMBER INTEGER)

RETURNS TEXT
BEGIN
        DECLARE RESPUESTA TEXT DEFAULT '';

    CASE
        WHEN CREDIT_NUMBER>=50000 THEN SET RESPUESTA='PLATINUM';
        WHEN CREDIT_NUMBER>=10000 AND CREDIT_NUMBER<50000 THEN SET RESPUESTA='GOLD';
        WHEN CREDIT_NUMBER<10000  THEN SET RESPUESTA ='SILVER';
        ELSE SET RESPUESTA='NO PERTENCE A NINGUNA CLASE';
    END CASE ;

    RETURN RESPUESTA;

END;

SELECT CLASE_CLIENTE(76000);

#//////////////////////////////////////////////////////////////////////////////////
#/////////////////    EJERCICIO 17    ////////////////////////////////////////////
#////////////////////////////////////////////////////////////////////////////////////

CREATE OR REPLACE  FUNCTION  REDUCIR_CADENA (PALABRA TEXT)
RETURNS TEXT
BEGIN
    DECLARE RESPUESTA TEXT DEFAULT '';
    DECLARE CONTADOR INTEGER DEFAULT CHAR_LENGTH(PALABRA);
    DECLARE AUX INTEGER DEFAULT 1;
    DECLARE AUX2 INTEGER DEFAULT CHAR_LENGTH(PALABRA);

    REPEAT
        SET RESPUESTA= CONCAT(RESPUESTA,',',SUBSTRING(PALABRA,AUX,AUX2));
        SET CONTADOR=CONTADOR-1;
        SET AUX=AUX+1;

    until CONTADOR <=0 end repeat;
    RETURN RESPUESTA;
end;

SELECT REDUCIR_CADENA('PEDRO');



