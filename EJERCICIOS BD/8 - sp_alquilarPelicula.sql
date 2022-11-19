USE TestCrud
GO

--8) Alquilar película
ALTER PROCEDURE [dbo].[sp_alquilarPelicula] 
	@cod_pelicula INT,
	@cod_usuario INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE 
		@cant_disponible_alquiler INT, 
		@fecha DATETIME = GETDATE(),
		@precio_alquiler NUMERIC(18,2);
	-- BUSCO LA CANTIDAD DISPONIBLE DE LA PELICULA PARA ALQUILAR Y PRECIO
	SELECT TOP 1 
		@cant_disponible_alquiler = [cant_disponibles_alquiler],  
		@precio_alquiler = [precio_alquiler]
	FROM [dbo].[tPelicula]
	WHERE [cod_pelicula] = @cod_pelicula

	-- VERIFICO QUE LA CANTIDAD PARA ALQUILAR SEA MAYOR A 0
	IF @cant_disponible_alquiler > 0
	BEGIN
		-- ACTUALIZO VALOR DE [cant_disponibles_alquiler] DE PELICULA
		UPDATE [dbo].[tPelicula]
		SET [cant_disponibles_alquiler] = @cant_disponible_alquiler - 1
		WHERE [cod_pelicula] = @cod_pelicula

		-- ALQUILA PELICULA
		INSERT INTO [dbo].[tAlquiler]
				([cod_usuario]
				,[cod_pelicula]
				,[precio]
				,[fecha])
			VALUES
				(@cod_usuario
				,@cod_pelicula
				,@precio_alquiler
				,@fecha)

		SELECT
			SCOPE_IDENTITY() cod_alquiler
			, @cod_usuario cod_usuario
			, @cod_pelicula cod_pelicula
			, @precio_alquiler precio
			, @fecha fecha
	END
	ELSE
	BEGIN
		RAISERROR ('La pelicula no esta disponible para alquilar', 1, 1)
	END
END
GO