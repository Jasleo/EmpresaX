USE bdEmpresa;

CREATE TABLE usuario( 
    id INT AUTO_INCREMENT,
    rut VARCHAR (20),
    username VARCHAR (20),
    nombre VARCHAR (20),
    pass VARCHAR(20)
);


INSERT INTO usuario VALUES(NULL,"11.111.111-1","Burns","Charles Montgomery Burns","1q2w3e");