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

INSERT INTO area VALUES(NULL,"Informatica");
INSERT INTO area VALUES(NULL,"Recursos Humanos");
INSERT INTO area VALUES(NULL,"Redes");
INSERT INTO trabajador VALUES(NULL,"1.999.999-1","Hugo","Contreras",2);
INSERT INTO trabajador VALUES(NULL,"2.999.999-1","Alan","Brito",1);
INSERT INTO trabajador VALUES(NULL,"3.999.999-1","Rasputin","II",3);

CREATE VIEW datos_persona AS
SELECT trabajador.nombre,trabajador.apellido,area.nombreA
FROM trabajador
INNER JOIN area
ON trabajador.areaFk = area.id


SELECT * FROM trabajador;
SELECT * FROM area;

SELECT * FROM datos_persona;

--DROP DATABASE bdEmpresa
