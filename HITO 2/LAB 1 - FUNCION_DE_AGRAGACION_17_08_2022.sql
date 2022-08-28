
create database function_agregation;

use function_agregation

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


UPDATE estudiantes
SET GESTION ='2022'
WHERE id_est>0;


CREATE TABLE materias
(
id_mat INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
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
VALUES  ('Introduccion a la Arquitectura','ARQ-101'),
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

SELECT estudiantes.nombres,estudiantes.apellidos,materias.nombre_mat
FROM inscripcion
    INNER JOIN ESTUDIANTES ON inscripcion.id_est=estudiantes.id_est
    INNER JOIN MATERIAS ON inscripcion.id_mat=materias.id_mat
WHERE MATERIAS.cod_mat='ARQ-103';
#CONTAR CUANTOS REGISTROS

#MOSTRAR PROMEDIO DE LAS ESTUDIANTES

SELECT AVG(EST.edad)
FROM estudiantes AS EST;

#MOSTRAR EL MAXMIMO DE EDAD
SELECT MAX(EST.edad)
FROM estudiantes AS EST;

#MOSTRAR EL MINIMO DE EDAD
SELECT MIN(EST.edad)
FROM estudiantes AS EST;

#DETERMINAR LA EDAD MAXIMA EDAD DE LOS ESTUDIANTES
# CUYO GENERO SEA MASCULINO/FEMENINO
# Y ADEMAS LA EDAD SEA MAYOR A 20

CREATE OR REPLACE FUNCTION GET_MAX_EDAD()
RETURNS INTEGER
    BEGIN
        RETURN
        (
        SELECT MAX(EST.edad)
        FROM estudiantes AS EST
        );
    END;

SELECT GET_MAX_EDAD();



#MENOR EDAD
CREATE FUNCTION MENOR_EDAD()
RETURNS INTEGER
    BEGIN
        RETURN
        (
        SELECT MIN(EST.edad)
        FROM estudiantes AS EST
        );
    END;
SELECT MENOR_EDAD();
#PROMEDIO DE EDADES

CREATE FUNCTION PROMEDIO_EDADES()
RETURNS INTEGER
    BEGIN
        RETURN
        (
        SELECT AVG(EST.edad)
        FROM estudiantes AS EST
        );
    END;

SELECT PROMEDIO_EDADES();

#MAYOR EDAD ESTUDIANTES
CREATE OR REPLACE FUNCTION MAYORGENERO()
RETURNS INTEGER
    BEGIN
        RETURN
        (
        SELECT MAX(EST.edad)
        FROM estudiantes AS EST
        WHERE SEXO='MASCULINO'
        );
    END;

SELECT MAYORGENERO();


CREATE FUNCTION MAYOR_ID()
RETURNS INTEGER
    BEGIN
        RETURN
        (
        SELECT MAX(EST.id_est)
        FROM estudiantes AS EST
        );
    END;


SELECT NOMBRES,apellidos,id_est
FROM estudiantes
WHERE  estudiantes.id_est=MAYOR_ID();
