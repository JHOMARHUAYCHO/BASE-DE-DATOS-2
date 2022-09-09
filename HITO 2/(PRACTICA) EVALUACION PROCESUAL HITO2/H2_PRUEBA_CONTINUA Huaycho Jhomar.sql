
CREATE DATABASE POLLOS_COPA;
 USE POLLOS_COPA;

CREATE TABLE CLIENTE
(
    ID_CLIENTE INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL ,
    FULLNAME VARCHAR(30),
    LASTNAME VARCHAR(30),
    EDAD INTEGER,
    DOMICILIO VARCHAR(40)
);
CREATE TABLE PEDIDO
(
    ID_PEDIDO INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ARTICULO VARCHAR(30),
    COSTO FLOAT,
    FECHA DATE
);

CREATE TABLE  DETALLE_PEDIDO
(
    ID_DETALLE_PEDIDO INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
    ID_PEDIDO INTEGER NOT NULL,
    ID_CLIENTE INTEGER NOT NULL,
    FOREIGN KEY (ID_PEDIDO) REFERENCES PEDIDO(ID_PEDIDO),
    FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE)
);

INSERT INTO CLIENTE(FULLNAME, LASTNAME, EDAD, DOMICILIO)
VALUES('PEDRO','SALAZAR GOMEZ',19,'RIO SECO'),
      ('MARIA','DELGADO MENDOZA',20,'BALLIVIAN');

INSERT INTO PEDIDO(ARTICULO, COSTO, FECHA)
VALUES('LECHE',21.2,'2022-08-02'),
      ('CARNE',7.4,'2022-09-12');

INSERT INTO DETALLE_PEDIDO(ID_PEDIDO, ID_CLIENTE)
VALUES(1,2),
      (2,1);

#PREGUNTA NUMERO 12
SELECT DETALLE_PEDIDO.ID_DETALLE_PEDIDO AS CODIGO_COMPRA,
       CONCAT(CLIENTE.FULLNAME,CLIENTE.LASTNAME) AS NOMBRE_COMPLETO,
       PEDIDO.ARTICULO,PEDIDO.COSTO

FROM DETALLE_PEDIDO
INNER JOIN CLIENTE ON DETALLE_PEDIDO.ID_CLIENTE = CLIENTE.ID_CLIENTE
INNER JOIN PEDIDO ON DETALLE_PEDIDO.ID_PEDIDO = PEDIDO.ID_PEDIDO;

#//////////////////////////////////////////////////////////////////////////////////////////
#//////////////////////////////////////////////////////////////////////////////////////////

#PREGUNTA 13

CREATE DATABASE tareaHito2;
USE tareaHito2;

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

#RESPUESTA CREANDO FUNCION

CREATE OR REPLACE FUNCTION COMPARA_MATERIAS(CODI_MAT VARCHAR(100),NOMBRE_MAT VARCHAR(100))
RETURNS BOOLEAN
BEGIN
    DECLARE RESPUESTA BOOLEAN;

        IF CODI_MAT=NOMBRE_MAT
        THEN
        SET RESPUESTA=1;
        END IF;
    RETURN RESPUESTA;
END;

SELECT ESTUDIANTES.id_est, ESTUDIANTES.NOMBRES,ESTUDIANTES.APELLIDOS,
       MATERIAS.NOMBRE_MAT,MATERIAS.COD_MAT
FROM inscripcion
INNER JOIN estudiantes ON inscripcion.id_est = estudiantes.id_est
INNER JOIN materias ON inscripcion.id_mat = materias.id_mat

WHERE COMPARA_MATERIAS(materias.cod_mat,'ARQ-105');

#PREGUNTA 14
CREATE OR REPLACE FUNCTION PROMEDIO_GENERO_MATERIA( GENERO VARCHAR(11),MATERIA_COD VARCHAR(100))
RETURNS INTEGER
BEGIN
    DECLARE PROMEDIO INTEGER DEFAULT 0;

    SELECT AVG(estudiantes.edad) INTO PROMEDIO
    FROM inscripcion
    INNER JOIN estudiantes ON inscripcion.id_est = estudiantes.id_est
    INNER JOIN materias ON inscripcion.id_mat = materias.id_mat
    WHERE estudiantes.sexo= GENERO AND materias.cod_mat=MATERIA_COD;
    RETURN PROMEDIO;
END;

SELECT PROMEDIO_GENERO_MATERIA('femenino','ARQ-104');

#PREGUNTA 15

CREATE OR REPLACE FUNCTION CONCATENAR_PALABRAS (A1 VARCHAR(30),A2 VARCHAR(30),A3 VARCHAR(30))
RETURNS VARCHAR(90)
BEGIN
    DECLARE CADENA_TOTAL VARCHAR(90) DEFAULT '';
    SET CADENA_TOTAL= CONCAT('(',A1,') (',A2,') (',A3,')');

    RETURN CADENA_TOTAL ;
END;

SELECT CONCATENAR_PALABRAS('PEPITO','PEP','50') AS CONCATENADO_TOTAL;

#PREGUNTA 16


CREATE OR REPLACE FUNCTION EST_SEGUN_EDAD_GENERO(SEXO VARCHAR(11),EDAD INTEGER)
RETURNS BOOLEAN
BEGIN
    DECLARE SUMA INTEGER DEFAULT 0;
    DECLARE SIoNO BOOLEAN;

    SELECT SUM(ESTUDIANTES.EDAD) INTO SUMA
    FROM estudiantes
    WHERE estudiantes.SEXO=SEXO;

    IF SUMA%2=0 AND SUMA>EDAD
    THEN
        SET SIoNO=1;
    END IF;
    RETURN SIoNO;
END;

SELECT ESTUDIANTES.NOMBRES, ESTUDIANTES.APELLIDOS,ESTUDIANTES.EDAD,INSCRIPCION.SEMESTRE
FROM inscripcion
INNER  JOIN estudiantes ON inscripcion.id_est = estudiantes.id_est
WHERE EST_SEGUN_EDAD_GENERO('MASCULINO',22);

SELECT SUM(EDAD)
FROM estudiantes
GROUP BY(ESTUDIANTES.SEXO);

## PREGUNTA 17

CREATE OR REPLACE FUNCTION BUSCA_NOMBRES_APELLIDOS(nombre varchar(100),apellidos varchar(100),nombre_c varchar (100),apellido_c varchar(100))

    RETURNS BOOLEAN
    BEGIN
        DECLARE DECISION BOOLEAN;
        if nombre=nombre_c and apellidos=apellido_c
        then
        set DECISION=1;
        end if;
        RETURN DECISION;

    END;


select *
from estudiantes
where  BUSCA_NOMBRES_APELLIDOS(estudiantes.nombres,
    estudiantes.apellidos,'miguel','gonzales veliz');

