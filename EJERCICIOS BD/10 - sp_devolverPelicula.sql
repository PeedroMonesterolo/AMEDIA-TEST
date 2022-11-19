USE TestCrud
GO

--10) Devolver película
CREATE PROCEDURE [dbo].[sp_devolverPelicula] 
	@cod_alquiler INT,
	@cod_usuario INT
AS
BEGIN
	SET NOCOUNT ON;
	
	IF(SELECT COUNT(*) FROM [dbo].[tAlquiler] WHERE [cod_alquiler] = @cod_alquiler AND [cod_usuario] = @cod_usuario) = 0
	BEGIN
		RAISERROR ('No existe pelicula alquilada por el usuario', 1, 1)
	END
	ELSE
	BEGIN
		 --OBTENGO EL CODIGO DE LA PELICULA
		DECLARE @cod_pelicula INT, @cant_disponibles_alquiler INT;
		SELECT TOP 1
			@cod_pelicula = TA.[cod_pelicula]
			, @cant_disponibles_alquiler = TP.[cant_disponibles_alquiler]
		FROM [dbo].[tAlquiler] TA
		INNER JOIN [dbo].[tPelicula] TP
			ON TP.[cod_pelicula] = TA.[cod_pelicula]
		WHERE TA.[cod_alquiler] = @cod_alquiler AND TA.[cod_usuario] = @cod_usuario

		-- ACTUALIZO LA PELICULA COMO DEVUELTA
		UPDATE [dbo].[tAlquiler]
		SET [devuelta] = 1
		WHERE [cod_alquiler] = @cod_alquiler

		-- ACTUALIZO EL STOCK DE LA PELICULA
		UPDATE [dbo].[tPelicula]
		SET [cant_disponibles_alquiler] = @cant_disponibles_alquiler + 1 
		WHERE [cod_pelicula] = @cod_pelicula

		SELECT 'Pelicula devuelta correctamente.' as message, CAST(1 AS BIT) as succes
	END
END
GO