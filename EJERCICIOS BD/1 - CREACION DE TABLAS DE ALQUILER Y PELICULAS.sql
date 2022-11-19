USE TestCrud
GO


--1) Crear una tabla de alquiler de películas y otra de ventas, que te permita registrar qué usuario compró/alquiló dicha película, a que precio y en qué momento
CREATE TABLE tAlquiler (
	cod_alquiler INT IDENTITY PRIMARY KEY
	, cod_usuario INT NOT NULL
	, cod_pelicula INT NOT NULL
	, precio DECIMAL(18,2) NOT NULL
	, fecha DATETIME NOT NULL
	, devuelta BIT DEFAULT(0)
	, CONSTRAINT fk_alquiler_usuario FOREIGN KEY([cod_usuario]) REFERENCES [dbo].[tUsers]([cod_usuario])
	, CONSTRAINT fk_alquiler_pelicula FOREIGN KEY([cod_pelicula]) REFERENCES [dbo].[tPelicula]([cod_pelicula])
)

CREATE TABLE tVentas (
	cod_venta INT IDENTITY PRIMARY KEY
	, cod_usuario INT NOT NULL
	, cod_pelicula INT NOT NULL
	, precio DECIMAL(18,2) NOT NULL
	, fecha DATETIME NOT NULL
	, CONSTRAINT fk_venta_usuario FOREIGN KEY([cod_usuario]) REFERENCES [dbo].[tUsers]([cod_usuario])
	, CONSTRAINT fk_venta_pelicula FOREIGN KEY([cod_pelicula]) REFERENCES [dbo].[tPelicula]([cod_pelicula])
)