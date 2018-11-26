CREATE DATABASE bdEmpresa;
USE bdEmpresa;

CREATE TABLE area( 
    id INT AUTO_INCREMENT,
    nombreA VARCHAR (20),
    PRIMARY KEY (id)
);

CREATE TABLE trabajador( 
    id INT AUTO_INCREMENT,
    rut VARCHAR (20),
    nombre VARCHAR (20),
    apellido VARCHAR (20),
    areaFk int,
    FOREIGN KEY(areaFk)REFERENCES area(id),
    PRIMARY KEY (id)
);

CREATE TABLE producto( 
    id INT AUTO_INCREMENT,
    nombre VARCHAR (20),
    cantidad INT,
    precio INT,
    PRIMARY KEY (id)
);




INSERT INTO area VALUES(NULL,"sector 6G");
INSERT INTO area VALUES(NULL,"sector 7G");
INSERT INTO area VALUES(NULL,"sector 5G");


INSERT INTO trabajador VALUES(NULL,"1.999.999-1","Homero","Simpson",2);
INSERT INTO trabajador VALUES(NULL,"2.999.999-1","Carl","Carlson",1);
INSERT INTO trabajador VALUES(NULL,"3.999.999-1","Lenny","Leonard",3);

CREATE VIEW datos_persona AS
SELECT trabajador.id,trabajador.rut,trabajador.nombre,trabajador.apellido,area.nombreA
FROM trabajador
INNER JOIN area
ON trabajador.areaFk = area.id


SELECT * FROM trabajador;
SELECT * FROM area;

SELECT * FROM datos_persona;
SELECT * FROM datos_persona WHERE id = 2;


SELECT nombreA FROM area WHERE id = 1;


--DROP DATABASE bdEmpresa
