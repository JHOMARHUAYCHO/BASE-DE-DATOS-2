create database univeridad2;
use univeridad2


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

INSERT INTO estudiantes (nombres, apellidos, edad,gestion, fono, email, direccion, sexo)
  VALUES ('Miguel' ,'Gonzales Veliz', 20,2022, 2832115, 'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino'),
         ('Sandra' ,'Mavir Uria', 25, 2022,2832116, 'sandra@gmail.com', 'Av. 6 de Agosto', 'femenino'),
         ('Joel' ,'Adubiri Mondar', 30, 2022,2832117, 'joel@gmail.com', 'Av. 6 de Agosto', 'masculino'),
         ('Andrea' ,'Arias Ballesteros', 21,2022, 2832118, 'andrea@gmail.com', 'Av. 6 de Agosto', 'femenino'),
         ('Santos' ,'Montes Valenzuela', 24, 2022,2832119, 'santos@gmail.com', 'Av. 6 de Agosto', 'masculino');

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


#ejercicio 1
#generar el siguiente formato de salida
#concatenar  nombres y aoellido de la siguiente forma : nombres: william, apellidos: barra
#concatenar gestion y edad de la siguiente forma: gestion : 2922-edad(2018)

CREATE OR REPLACE FUNCTION CONCAT_NOMBRE_APELLIDO(NAME VARCHAR(25),AP VARCHAR(25))

RETURNS VARCHAR(50)

BEGIN
    DECLARE CADENA VARCHAR(50) DEFAULT'PEDRO MENDOZA';
    SET CADENA = CONCAT('NOMBRE: ',NAME,'   APELLIDOS: ',AP);
    RETURN CADENA;
END;

SELECT CONCAT_NOMBRE_APELLIDO('pepe','galarza');

SELECT  CONCAT_NOMBRE_APELLIDO(ESTUDIANTES.NOMBRES,ESTUDIANTES.APELLIDOS) AS NOMBRE_Y_APELLIDOS
FROM estudiantes;

#/////////////////////////////////////////////
#SEGUNDA FUNCION PARA DEVOLVER GESTION Y EDAD
#////////////////////////////////////////////
CREATE OR REPLACE FUNCTION CONCAT_GESTION_EDAD(GEST INTEGER,EDAD INTEGER)

RETURNS VARCHAR(50)

BEGIN
    DECLARE RESULTADO VARCHAR(50) DEFAULT'';
    SET RESULTADO = CONCAT('GESTION: ',GEST,'   EDAD: ',EDAD);
    RETURN RESULTADO;
END;

SELECT CONCAT_GESTION_EDAD(2022,32);

SELECT  CONCAT_NOMBRE_APELLIDO(ESTUDIANTES.NOMBRES,ESTUDIANTES.APELLIDOS) ,
    CONCAT_GESTION_EDAD(ESTUDIANTES.GESTION,ESTUDIANTES.EDAD)
FROM ESTUDIANTES;

#/////////////////////////////////////////////
#TECERA  FUNCION PARA DEVOLVER NOMBRES APELLIDOS GESTION Y EDAD
#////////////////////////////////////////////

CREATE OR REPLACE FUNCTION GRAN_CADENA(NAME VARCHAR(25),AP VARCHAR(25),GEST INTEGER,EDAD INTEGER)

RETURNS VARCHAR(100)

BEGIN
    DECLARE CADENA VARCHAR(100) DEFAULT'';
    SET CADENA = CONCAT('NOBRES:',NAME,'  APELLIDOS: ',AP,'         GESTION: ',GEST,'   EDAD: ',EDAD);
    RETURN CADENA;
END;

SELECT GRAN_CADENA('ANA','RODRIGUEZ',2022,43) AS DATOS_PERSONALES;

SELECT  GRAN_CADENA(ESTUDIANTES.NOMBRES,ESTUDIANTES.APELLIDOS,ESTUDIANTES.GESTION,ESTUDIANTES.EDAD) AS DATOS_PERSONALES
FROM ESTUDIANTES;

#MOSTRAR LOS NOMBRE
SELECT ESTUDIANTES.NOMBRES, ESTUDIANTES.APELLIDOS
FROM inscripcion
INNER JOIN ESTUDIANTES ON inscripcion.id_est=estudianteS.id_est
INNER JOIN MATERIAS ON inscripcion.id_mat=materias.id_mat

WHERE  inscripcion.gestion=2014 AND MATERIAS.nombre_mat='ARQ-101' AND  inscripcion.semestre='5to Semestre';


#OTRA CONSULTA DE ESTUDIANTES INSCRITOS EN 2016 Y 2017

SELECT ESTUDIANTES.NOMBRES, ESTUDIANTES.APELLIDOS, INSCRIPCION.GESTION
FROM inscripcion
INNER JOIN ESTUDIANTES ON inscripcion.id_est=estudianteS.id_est

WHERE inscripcion.gestion=2016 OR inscripcion.gestion=2017;
