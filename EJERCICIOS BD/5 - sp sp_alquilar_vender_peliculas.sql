USE TestCrud
GO

--5) Alquilar y Vender películas
CREATE PROCEDURE [dbo].[sp_alquilar_vender_peliculas] 
	@alquila BIT, -- 0 FALSE(VENDE), 1 TRUE (ALQUILA)
	@cod_pelicula INT,
	@cod_usuario INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE 
		@cant_disponible_alquiler INT, 
		@cant_disponible_venta INT, 
		@fecha DATETIME = GETDATE(),
		@precio_alquiler NUMERIC(18,2),
		@precio_venta NUMERIC(18,2);
	-- BUSCO LA CANTIDAD DISPONIBLE DE LA PELICULA TANTO PARA ALQUILAR COMO PARA VENDER
	SELECT TOP 1 
		@cant_disponible_alquiler = [cant_disponibles_alquiler],  
		@cant_disponible_venta = [cant_disponibles_venta],
		@precio_alquiler = [precio_alquiler],
		@precio_venta = [precio_venta]
	FROM [dbo].[tPelicula]
	WHERE [cod_pelicula] = @cod_pelicula


	IF @alquila = 0
	BEGIN
		-- VENDE PELICULA
		
		-- VERIFICO QUE LA CANTIDAD PARA ALQUILAR SEA MAYOR A 0
		IF @cant_disponible_venta > 0
		BEGIN
			INSERT INTO [dbo].[tVentas]
				   ([cod_usuario]
				   ,[cod_pelicula]
				   ,[precio]
				   ,[fecha])
			 VALUES
				   (@cod_usuario
				   ,@cod_pelicula
				   ,@precio_venta
				   ,@fecha)
			
			-- ACTUALIZO VALOR DE [cant_disponibles_alquiler] DE PELICULA
			UPDATE [dbo].[tPelicula]
			SET [cant_disponibles_venta] = @cant_disponible_venta - 1
			WHERE [cod_pelicula] = @cod_pelicula

			SELECT
				SCOPE_IDENTITY() cod_venta
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
	ELSE
	BEGIN
		-- ALQUILA

		-- VERIFICO QUE LA CANTIDAD PARA ALQUILAR SEA MAYOR A 0
		IF @cant_disponible_alquiler > 0
		BEGIN
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

		    -- ACTUALIZO VALOR DE [cant_disponibles_alquiler] DE PELICULA
			UPDATE [dbo].[tPelicula]
			SET [cant_disponibles_alquiler] = @cant_disponible_alquiler - 1
			WHERE [cod_pelicula] = @cod_pelicula

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
END
GO