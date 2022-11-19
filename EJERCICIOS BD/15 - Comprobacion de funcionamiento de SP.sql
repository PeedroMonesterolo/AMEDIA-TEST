SELECT * FROM [dbo].[tUsers]
SELECT * FROM [dbo].[tRol]

SELECT * FROM [dbo].[tPelicula]
SELECT * FROM [dbo].[tGenero]
SELECT * FROM [dbo].[tGeneroPelicula]


--1) Crear usuarios, cuyo documento no exista actualmente en la base de datos, en caso de existir, deber�a devolver un mensaje de error, en caso contrario insertarlo
SELECT * FROM [dbo].[tUsers]
SELECT * FROM [dbo].[tRol]

EXECUTE [dbo].[tUsers_iUsers] 'userTest','Test1','Ariel','ApellidoConA','12312321', 1, 1 -- VALIDACION DE USUARIO CREADO
EXECUTE [dbo].[tUsers_iUsers] 'pmonesterolo1','qwerty','Pedro1','Monesterolo1','38280393', 1, -1 -- USUARIO NO REGISTRADO







--2) Crear/Borrar/Modificar peliculas (Borrar es poner en 0 el stock de ventas y alquileres)
SELECT * FROM [dbo].[tPelicula]
-- CREAR
EXECUTE [dbo].[sp_iupPeliculas] @cod_pelicula = 5, @titulo = 'Rapido y furiosos', @cant_disponibles_alquiler = 8, @cant_disponibles_venta = 6
  , @precio_alquiler = 500, @precio_venta = 600
GO

-- ACTUALIZAR
EXECUTE [dbo].[sp_iupPeliculas] @cod_pelicula = 5, @titulo = 'Rapido y furiosos', @cant_disponibles_alquiler = 8, @cant_disponibles_venta = 6
  , @precio_alquiler = 500, @precio_venta = 600
GO

-- BORRAR
EXECUTE [dbo].[sp_iupPeliculas] @cod_pelicula = 5, @titulo = NULL, @cant_disponibles_alquiler = NULL, @cant_disponibles_venta = NULL
  , @precio_alquiler = NULL, @precio_venta = NULL
GO






--3) Crear g�neros
SELECT * FROM [dbo].[tGenero]
-- TODO: Establezca los valores de los par�metros aqu�.
EXECUTE [dbo].[tGenero_iGenero] @txt_desc = 'Amor'
GO






--4) Asignar g�neros a pel�culas, verificar que la pel�cula no tenga asignada el g�nero previamente.
SELECT * FROM [dbo].[tPelicula]
SELECT * FROM [dbo].[tGenero]
SELECT * FROM [dbo].[tGeneroPelicula]


EXECUTE [dbo].[tGeneroPelicula_iGeneroPelicula] @cod_pelicula = 5, @cod_genero = 3
GO








--5) Alquilar y Vender pel�culas
SELECT * FROM [dbo].[tUsers]

SELECT * FROM [dbo].[tPelicula]
SELECT * FROM [dbo].[tAlquiler]
SELECT * FROM [dbo].[tVentas]

-- TODO: Establezca los valores de los par�metros aqu�.
-- ALQUILER
EXECUTE [dbo].[sp_alquilar_vender_peliculas] 1, @cod_pelicula = 5, @cod_usuario = 7
GO

-- VENTA
EXECUTE [dbo].[sp_alquilar_vender_peliculas] 0, @cod_pelicula = 5, @cod_usuario = 7
EXECUTE [dbo].[sp_alquilar_vender_peliculas] 0, @cod_pelicula = 2, @cod_usuario = 4
EXECUTE [dbo].[sp_alquilar_vender_peliculas] 0, @cod_pelicula = 5, @cod_usuario = 6
GO








--6) Obtener las pel�culas en stock para alquiler
EXECUTE [dbo].[sp_sStockPeliculasAlquiler]








--7) Obtener las pel�culas en stock para vender
EXECUTE [dbo].[sp_sStockPeliculasVenta]








--8) Alquilar pel�cula
SELECT * FROM [dbo].[tUsers]
SELECT * FROM [dbo].[tPelicula]
SELECT * FROM [dbo].[tAlquiler]
EXECUTE [dbo].[sp_alquilarPelicula] @cod_pelicula = 1, @cod_usuario = 7
GO








--9) Vender pelicula
SELECT * FROM [dbo].[tUsers]
SELECT * FROM [dbo].[tPelicula]
SELECT * FROM [dbo].[tVentas]
EXECUTE [dbo].[sp_venderPelicula] @cod_pelicula = 4, @cod_usuario = 2
GO









--10) Devolver pel�cula
EXECUTE [dbo].[sp_devolverPelicula] @cod_alquiler = 4, @cod_usuario = 4
EXECUTE [dbo].[sp_devolverPelicula] @cod_alquiler = 2, @cod_usuario = 7









--11) Ver pel�culas que no fueron devueltas y que usuarios la tienen
EXECUTE [dbo].[sp_peliculasNoDevueltas]









--12) Ver qu� pel�culas fueron alquiladas por usuario y cu�nto pag� y que d�a
EXECUTE [dbo].[sp_peliculasAlquiladas] 4









--13) Ver todas las pel�culas, cuantas veces fueron alquiladas y cuanto se recaudo por ellas
EXECUTE [dbo].[sp_pelAlquiladasRecaudacion]