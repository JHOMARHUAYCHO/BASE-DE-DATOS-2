USE defensa_hito_2;

CREATE TABLE autor
(
    id_autor    INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name        VARCHAR(100),
    nacionality VARCHAR(50)
);

CREATE TABLE book
(
    id_book   INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    codigo    VARCHAR(25)                        NOT NULL,
    isbn      VARCHAR(50),
    title     VARCHAR(100),
    editorial VARCHAR(50),
    pages     INTEGER,
    id_autor  INTEGER,
    FOREIGN KEY (id_autor) REFERENCES autor (id_autor)
);

CREATE TABLE category
(
    id_cat  INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    type    VARCHAR(50),
    id_book INTEGER,
    FOREIGN KEY (id_book) REFERENCES book (id_book)
);

CREATE TABLE users
(
    id_user  INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    ci       VARCHAR(15)                        NOT NULL,
    fullname VARCHAR(100),
    lastname VARCHAR(100),
    address  VARCHAR(150),
    phone    INTEGER
);

CREATE TABLE prestamos
(
    id_prestamo    INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_book        INTEGER,
    id_user        INTEGER,
    fec_prestamo   DATE,
    fec_devolucion DATE,
    FOREIGN KEY (id_book) REFERENCES book (id_book),
    FOREIGN KEY (id_user) REFERENCES users (id_user)
);

INSERT INTO autor (name, nacionality)
VALUES ('autor_name_1', 'Bolivia'),
       ('autor_name_2', 'Argentina'),
       ('autor_name_3', 'Mexico'),
       ('autor_name_4', 'Paraguay');

INSERT INTO book (codigo, isbn, title, editorial, pages, id_autor)
VALUES ('codigo_book_1', 'isbn_1', 'title_book_1', 'NOVA', 30, 1),
       ('codigo_book_2', 'isbn_2', 'title_book_2', 'NOVA II', 25, 1),
       ('codigo_book_3', 'isbn_3', 'title_book_3', 'NUEVA SENDA', 55, 2),
       ('codigo_book_4', 'isbn_4', 'title_book_4', 'IBRANI', 100, 3),
       ('codigo_book_5', 'isbn_5', 'title_book_5', 'IBRANI', 200, 4),
       ('codigo_book_6', 'isbn_6', 'title_book_6', 'IBRANI', 85, 4);

INSERT INTO category (type, id_book)
VALUES ('HISTORIA', 1),
       ('HISTORIA', 2),
       ('COMEDIA', 3),
       ('MANGA', 4),
       ('MANGA', 5),
       ('MANGA', 6);

INSERT INTO users (ci, fullname, lastname, address, phone)
VALUES ('111 cbba', 'user_1', 'lastanme_1', 'address_1', 111),
       ('222 cbba', 'user_2', 'lastanme_2', 'address_2', 222),
       ('333 cbba', 'user_3', 'lastanme_3', 'address_3', 333),
       ('444 lp', 'user_4', 'lastanme_4', 'address_4', 444),
       ('555 lp', 'user_5', 'lastanme_5', 'address_5', 555),
       ('666 sc', 'user_6', 'lastanme_6', 'address_6', 666),
       ('777 sc', 'user_7', 'lastanme_7', 'address_7', 777),
       ('888 or', 'user_8', 'lastanme_8', 'address_8', 888);

INSERT INTO prestamos (id_book, id_user, fec_prestamo, fec_devolucion)
VALUES (1, 1, '2017-10-20', '2017-10-25'),
       (2, 2, '2017-11-20', '2017-11-22'),
       (3, 3, '2018-10-22', '2018-10-27'),
       (4, 3, '2018-11-15', '2017-11-20'),
       (5, 4, '2018-12-20', '2018-12-25'),
       (6, 5, '2019-10-16', '2019-10-18');

##PREGUNTA UNO
#Mostrar el t??tulo del libro, los nombres y apellidos, y la categor??a de los usuarios que se prestaron libros donde la categor??a sea COMEDIA o MANGA
#Resultado esperado: (8:15)

SELECT CONCAT(FULLNAME,'   ',lastname)AS NOMBRE_COMPLETO,USERS.CI AS CI_USER,BOOK.TITLE AS LIBRO_PRESTADO,category.type AS CATEGORIA

FROM PRESTAMOS
INNER JOIN USERS ON PRESTAMOS.id_user=USERS.id_user
INNER JOIN BOOK ON PRESTAMOS.id_book=book.id_book
INNER JOIN CATEGORY ON book.id_book=category.id_book

WHERE category.type='MANGA' OR category.type='COMEDIA';

#PREGUNTA 2
#Se desea saber cu??ntos usuarios se prestaron libros que correspondan a la editorial IBRANI y que la cantidad de sus p??ginas sea mayor a 90.
#Deber?? de crear una funci??n que retorne esa cantidad.
#La funci??n debe de recibir 2 par??metros.
#Editorial y la cantidad de p??ginas.

CREATE OR REPLACE FUNCTION  CANTIDAD(EDIT VARCHAR(50),PAGI INTEGER)

 RETURNS INTEGER
    BEGIN
        DECLARE CANTIDAD INTEGER;
        SELECT COUNT(BOOK.id_book) INTO CANTIDAD
        FROM BOOK
        WHERE BOOK.editorial=EDIT AND BOOK.PAGES>=PAGI;
        RETURN CANTIDAD;
    END;

SELECT CANTIDAD('IBRANI',90)

#PREGUNTA 3
#Se desea saber qu?? libros se prestaron de la categor??a MANGA y la editorial IBRIANI
#Deber?? de crear una funci??n que verifique si es par o no y retornar un TEXT que indique PAR o IMPAR adicionalmente concatenado el n??mero de p??ginas.
#Esta funci??n recibe como par??metro la cantidad de p??ginas.
#La funci??n deber?? ser usada en la cl??usula SELECT.
#Deber?? de crear una funci??n que concatena cadenas.
#Se tiene el siguiente comportamiento esperado. (Debe de usar los mismos alias que de la imagen)


CREATE OR REPLACE FUNCTION VERIFICA_PAR(PAGINAS INTEGER)

RETURNS VARCHAR(10)
BEGIN
    DECLARE CADENA VARCHAR (10) DEFAULT '';

    IF PAGINAS%2=0 THEN
    SET CADENA='PAR';
    ELSE
    SET CADENA='IMPAR';
    END IF;
    RETURN CADENA;
END;

CREATE OR REPLACE FUNCTION CONCATENAAR(N1 VARCHAR(30),N2 VARCHAR(30))

RETURNS VARCHAR(100)
BEGIN
    DECLARE CADENA VARCHAR (100) DEFAULT '';
    SET CADENA = CONCAT('EDITORIAL :',N1,'; CATEGORIA ',N2);
    RETURN CADENA;
END;

SELECT CONCATENAAR(CATEGORY.TYPE,BOOK.EDITORIAL),VERIFICA_PAR(BOOK.PAGES)
FROM BOOK
INNER JOIN category ON book.id_book = category.id_book
WHERE BOOK.editorial='IBRANI' AND category.type='MANGA';


#PREGUNTA 4
#Se desea saber cu??ntos libros fueron prestados en la gesti??n 2018.
#Crear una funci??n que permita saber esa cantidad o directamente la consulta SQL
#Comportamiento esperado
















