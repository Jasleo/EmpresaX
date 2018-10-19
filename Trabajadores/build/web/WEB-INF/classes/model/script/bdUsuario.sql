USE bdEmpresa;

CREATE TABLE usuario( 
    id INT AUTO_INCREMENT,
    rut VARCHAR (25),
    username VARCHAR (20),
    nombre VARCHAR (100),
    pass VARCHAR(20),
    PRIMARY KEY (id)
);

INSERT INTO usuario VALUES(NULL,"11.111.111-1","Burns","Charles Montgomery Burns","1q2w3e");

SELECT * FROM usuario;

SELECT * FROM usuario WHERE username = 'Burns' AND pass = '1q2w3e' ;