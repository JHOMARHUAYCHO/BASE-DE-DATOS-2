CREATE DATABASE UNIVERSIDAD;

USE UNIVERSIDAD

CREATE TABLE estudiantes
(
 id_est INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
 nombres VARCHAR(50),
 apellidos VARCHAR(50),
 edad INTEGER,
 gestion INTEGER,
 fono INTEGER,
 email VARCHAR(100),
 direccion VARCHAR(100),
 sexo VARCHAR(10)
);

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
  VALUES ('Miguel' ,'Gonzales Veliz', 20, 2832115, 'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino'),
         ('Sandra' ,'Mavir Uria', 25, 2832116, 'sandra@gmail.com', 'Av. 6 de Agosto', 'femenino'),
         ('Joel' ,'Adubiri Mondar', 30, 2832117, 'joel@gmail.com', 'Av. 6 de Agosto', 'masculino'),
         ('Andrea' ,'Arias Ballesteros', 21, 2832118, 'andrea@gmail.com', 'Av. 6 de Agosto', 'femenino'),
         ('Santos' ,'Montes Valenzuela', 24, 2832119, 'santos@gmail.com', 'Av. 6 de Agosto', 'masculino');

CREATE TABLE materias
(
  id_mat INTEGER AUTO_INCREMENT PRIMARY KEY  NOT NULL,
  nombre_mat VARCHAR(100),
  cod_mat VARCHAR(100)
);
CREATE TABLE inscripcion
(
  id_ins INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
  id_est INT NOT NULL,

  id_mat INT NOT NULL,
  semestre VARCHAR(20),
  gestion INTEGER,
  FOREIGN KEY (id_est) REFERENCES estudiantes (id_est),
  FOREIGN KEY (id_mat) REFERENCES materias (id_mat)
);

INSERT INTO materias (nombre_mat, cod_mat)
VALUES ('Introduccion a la Arquitectura','ARQ-101'),
     ('Urbanismo y Diseno','ARQ-102'),
     ('Dibujo y Pintura Arquitectonico','ARQ-103'),
     ('Matematica discreta','ARQ-104'),
     ('Fisica Basica','ARQ-105');

INSERT INTO inscripcion (id_est, id_mat, semestre, gestion)
                VALUES  (1, 1, '1er Semestre', 2015),
                        (1, 2, '2do Semestre', 2015),
                        (2, 4, '1er Semestre', 2016),
                        (2, 3, '2do Semestre', 2016),
                        (3, 3, '2do Semestre', 2017),
                        (3, 1, '3er Semestre', 2017),
                        (4, 4, '4to Semestre', 2017),
                        (5, 5, '5to Semestre', 2017);

SELECT* FROM estudiantes;

CREATE  OR REPLACE FUNCTION ID_MAX()  RETURNS INTEGER

BEGIN

    RETURN(
        SELECT MAX(estudiantes.id_est)
        FROM estudiantes
        );
    END;

SELECT ID_MAX();

SELECT ESTUDIANTES.nombres, estudiantes.apellidos, estudiantes.id_est
FROM estudiantes
WHERE id_est=ID_MAX();

# EJERCICIO 5
# Mostrar todos los registros de la tabla estudiantes (nombres y apellidos) si la suma de las
# edades de los estudiantes masculino/femenino sea par. A.	Crear una función que obtenga la suma de
# las edades de las estudiantes masculino/femenino.

CREATE OR REPLACE FUNCTION SUMA_EDADES()
RETURNS INTEGER
BEGIN
    RETURN(
        SELECT SUM(ESTUDIANTES.EDAD)
        FROM estudiantes
        WHERE SEXO='MASCULINO'
        );
    END;

SELECT SUMA_EDADES();

SELECT ESTUDIANTES.NOMBRES, ESTUDIANTES.APELLIDOS
FROM estudiantes
WHERE SUMA_EDADES() %2=0;

#EJERCICIO 6

CREATE OR REPLACE FUNCTION SUMA_EDADES()
RETURNS INTEGER
BEGIN
    RETURN(
        SELECT SUM(ESTUDIANTES.EDAD)
        FROM estudiantes
        WHERE SEXO='FEMENINO'
        );
    END;

SELECT SUMA_EDADES();

SELECT ESTUDIANTES.NOMBRES, ESTUDIANTES.APELLIDOS
FROM estudiantes
WHERE SUMA_EDADES() %2=0;

# EJERCICIO 6
#Volver parametrizable la anterior función.

CREATE OR REPLACE FUNCTION SUMA_EDADES_V1(GENERO_VALOR VARCHAR(50))
RETURNS INTEGER
BEGIN
    RETURN(
        SELECT SUM(ESTUDIANTES.EDAD)
        FROM estudiantes
        WHERE SEXO=GENERO_VALOR
        );
    END;

SELECT SUMA_EDADES_V1('MASCULINO');

SELECT ESTUDIANTES.NOMBRES, ESTUDIANTES.APELLIDOS
FROM estudiantes
WHERE SUMA_EDADES_V1('MASCULINO') %2=0;

#Volver parametrizable la anterior función VERSION 2.


CREATE OR REPLACE FUNCTION SUMA_EDADES_V2(GENERO_VALOR VARCHAR(50))
RETURNS INTEGER

    BEGIN
    #PARA CREAR UNA VARIABLE EN UNA FUNCION
    DECLARE SUMAEDAD INTEGER DEFAULT 0;
    #INTO: ASIGNAR EL RESULTADO DE LA FUNCION DE ABAJO  A LA VARIBLE CREADA

        SELECT SUM(EST.EDAD) INTO SUMAEDAD
        FROM estudiantes AS EST
        WHERE EST.SEXO=GENERO_VALOR;
    RETURN SUMAEDAD;
    END;

SELECT SUMA_EDADES_V2('MASCULINO');

#LLEVANDO EL EJERCICIO  DE SACAR EL PROMEDIO DE LAS EDADES QUE ACEPTE EL PARANMETRO EDAD
# A OTRA FORMA


CREATE OR REPLACE FUNCTION GENERO_PROMEDIO(GENERO_VALOR VARCHAR(10))
RETURNS INTEGER

 BEGIN
 DECLARE RESULTADO INTEGER DEFAULT 0;
        SELECT AVG(ESTUDIANTES.EDAD) INTO RESULTADO
        FROM ESTUDIANTES
        WHERE ESTUDIANTES.SEXO=GENERO_VALOR;
        RETURN RESULTADO;
    END;

SELECT GENERO_PROMEDIO('MASCULINO');

SELECT CONCAT_WS('*',NOMBRES,APELLIDOS) AS NOBRE_COMPLETO FROM estudiantes;


#3.	Crear una función que permita concatenar dos columnas.
#a.	Concatena el nombre y apellidos de la tabla estudiante.
#b.	El nombre de la función deberá ser getNombreCompleto
#c.	La función deberá recibir 2 parámetros (nombre y apellidos)

CREATE OR REPLACE FUNCTION getnombrecompleto(part1 varchar(25),part2 varchar(25))

        RETURNS VARCHAR(50)
        BEGIN
            DECLARE CONCATENADO VARCHAR(100) DEFAULT 'PEPE';
            SET CONCATENADO=concat(part1,' ',part2);
            RETURN CONCATENADO;
        END;

SELECT getnombrecompleto('ALEJANDRO','MENDOZA');

SELECT  getnombrecompleto(ESTUDIANTES.NOMBRES,ESTUDIANTES.APELLIDOS) AS NOMBRE_COMLPETO
FROM estudiantes;