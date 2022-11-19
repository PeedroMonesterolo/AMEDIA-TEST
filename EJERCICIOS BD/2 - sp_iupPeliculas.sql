USE TestCrud
GO

--2) Crear/Borrar/Modificar peliculas (Borrar es poner en 0 el stock de ventas y alquileres)
CREATE PROCEDURE [dbo].[sp_iupPeliculas] 
	@cod_pelicula INT = NULL,
	@titulo VARCHAR(500) = NULL,
	@cant_disponibles_alquiler int = NULL,
	@cant_disponibles_venta int = NULL,
	@precio_alquiler numeric(18,2) = NULL,
	@precio_venta numeric(18,2) = NULL
AS
BEGIN
	SET NOCOUNT ON;
	
	IF  @titulo IS NULL AND @cant_disponibles_alquiler IS NULL AND 
		@cant_disponibles_venta IS NULL AND @precio_alquiler IS NULL AND @precio_venta IS NULL AND @cod_pelicula IS NOT NULL
	BEGIN
		-- BORRAR
		UPDATE [dbo].[tPelicula]
		SET [cant_disponibles_alquiler] = 0
			,[cant_disponibles_venta] = 0
		WHERE [cod_pelicula] = @cod_pelicula
	END
	ELSE IF @titulo IS NOT NULL AND @cant_disponibles_alquiler IS NOT NULL AND 
			@cant_disponibles_venta IS NOT NULL AND @precio_alquiler IS NOT NULL AND @precio_venta IS NOT NULL AND @cod_pelicula IS NOT NULL
	BEGIN
		-- ACTUALIZAR
		UPDATE [dbo].[tPelicula]
		SET [txt_desc] = @titulo
			,[cant_disponibles_alquiler] = @cant_disponibles_alquiler
			,[cant_disponibles_venta] = @cant_disponibles_venta
			,[precio_alquiler] = @precio_alquiler
			,[precio_venta] = @precio_venta
		WHERE [cod_pelicula] = @cod_pelicula
	END
	ELSE IF @cod_pelicula IS NULL AND @titulo IS NOT NULL AND @cant_disponibles_alquiler IS NOT NULL AND 
			@cant_disponibles_venta IS NOT NULL AND @precio_alquiler IS NOT NULL AND @precio_venta IS NOT NULL
	BEGIN
		-- INSERTAR
		INSERT INTO [dbo].[tPelicula]
			([txt_desc]
			,[cant_disponibles_alquiler]
			,[cant_disponibles_venta]
			,[precio_alquiler]
			,[precio_venta])
		VALUES
			(@titulo
			,@cant_disponibles_alquiler
			,@cant_disponibles_venta
			,@precio_alquiler
			,@precio_venta)
	END
END
GO