USE TestCrud
GO

--9) Vender pelicula
CREATE PROCEDURE [dbo].[sp_venderPelicula] 
	@cod_pelicula INT,
	@cod_usuario INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE 
		@cant_disponible_venta INT, 
		@fecha DATETIME = GETDATE(),
		@precio_venta NUMERIC(18,2);
	-- BUSCO LA CANTIDAD DISPONIBLE DE LA PELICULA PARA ALQUILAR Y PRECIO
	SELECT TOP 1 
		@cant_disponible_venta = [cant_disponibles_venta],  
		@precio_venta = [precio_venta]
	FROM [dbo].[tPelicula]
	WHERE [cod_pelicula] = @cod_pelicula


	-- VERIFICO QUE LA CANTIDAD PARA ALQUILAR SEA MAYOR A 0
	IF @cant_disponible_venta > 0
	BEGIN
		-- ACTUALIZO VALOR DE [cant_disponibles_venta] DE PELICULA
		UPDATE [dbo].[tPelicula]
		SET [cant_disponibles_venta] = @cant_disponible_venta - 1
		WHERE [cod_pelicula] = @cod_pelicula

		-- VENTA PELICULA
		INSERT INTO [dbo].[tAlquiler]
				([cod_usuario]
				,[cod_pelicula]
				,[precio]
				,[fecha])
			VALUES
				(@cod_usuario
				,@cod_pelicula
				,@precio_venta
				,@fecha)

		SELECT
			SCOPE_IDENTITY() cod_alquiler
			, @cod_usuario cod_usuario
			, @cod_pelicula cod_pelicula
			, @precio_venta precio
			, @fecha fecha
	END
	ELSE
	BEGIN
		RAISERROR ('La pelicula no esta disponible para vender', 1, 1)
	END
END
GO