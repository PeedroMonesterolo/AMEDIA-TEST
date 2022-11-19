USE TestCrud
GO

CREATE TABLE tRol
(
	cod_rol INT IDENTITY PRIMARY KEY
	, txt_desc VARCHAR(500)
	, sn_activo INT
)

INSERT INTO trol VALUES ('Administrador', -1)
INSERT INTO trol VALUES ('Cliente', -1)

CREATE TABLE tUsers
(
	cod_usuario INT PRIMARY KEY IDENTITY
	,txt_user VARCHAR(50) 
	,txt_password VARCHAR(50)
	,txt_nombre VARCHAR(200)
	,txt_apellido VARCHAR(200)
	,nro_doc VARCHAR(50)
	,cod_rol INT
	,sn_activo INT
	, CONSTRAINT fk_user_rol FOREIGN KEY (cod_rol) REFERENCES tRol(cod_rol)
)


-- PREGUNTAR PORQUE SI FUE ERROR DE TIPEO PORQUE DA ERROR AL INSERTAR [cod_rol] EN -1
INSERT INTO tUsers
	VALUES ('Admin', 'PassAdmin123', 'Administrador', 'Test', '1234321', 1, -1)
INSERT INTO tUsers
	VALUES ('userTest', 'Test1', 'Ariel', 'ApellidoConA', '12312321', 1, -1)
INSERT INTO tUsers
	VALUES ('userTest2', 'Test2', 'Bernardo', 'ApellidoConB', '12312322', 1, -1)
INSERT INTO tUsers
	VALUES ('userTest3', 'Test3', 'Carlos', 'ApellidoConC', '12312323', 1, -1)


CREATE TABLE tPelicula (
	cod_pelicula INT PRIMARY KEY IDENTITY
	, txt_desc VARCHAR(500)
	, cant_disponibles_alquiler INT
	, cant_disponibles_venta INT
	, precio_alquiler NUMERIC(18,2)
	, precio_venta NUMERIC(18,2))


INSERT INTO tPelicula VALUES ('Duro de matar III', 3, 0, 1.5, 5.0)
INSERT INTO tPelicula VALUES ('Todo Poderoso', 2, 1, 1.5, 7.0)
INSERT INTO tPelicula VALUES ('Stranger than fiction', 1, 1, 1.5, 8.0)
INSERT INTO tPelicula VALUES ('OUIJA', 0, 2, 2.0, 20.50)


CREATE TABLE tGenero (
	cod_genero INT PRIMARY KEY IDENTITY
	, txt_desc VARCHAR(500) 
)

INSERT INTO tGenero VALUES ('Acción')
INSERT INTO tGenero VALUES ('Comedia')
INSERT INTO tGenero VALUES ('Drama')
INSERT INTO tGenero VALUES ('Terror')


CREATE TABLE tGeneroPelicula (
	cod_pelicula INT
	, cod_genero INT
	, PRIMARY KEY(cod_pelicula, cod_genero)
	, CONSTRAINT fk_genero_pelicula FOREIGN KEY(cod_pelicula) REFERENCES tpelicula(cod_pelicula)
	, CONSTRAINT fk_pelicula_genero FOREIGN KEY(cod_genero) REFERENCES tGenero(cod_genero))


INSERT INTO tGeneroPelicula VALUES (1, 1)
INSERT INTO tGeneroPelicula VALUES (2, 2)
INSERT INTO tGeneroPelicula VALUES (3, 2)
INSERT INTO tGeneroPelicula VALUES (3, 3)
INSERT INTO tGeneroPelicula VALUES (4, 4)