USE TestCrud
GO

--4) Asignar géneros a películas, verificar que la película no tenga asignada el género previamente.
CREATE PROCEDURE [dbo].[tGeneroPelicula_iGeneroPelicula] 
	@cod_pelicula INT,
	@cod_genero INT
AS
BEGIN
	SET NOCOUNT ON;

	IF (SELECT COUNT(*) FROM [dbo].[tGeneroPelicula] WHERE [cod_pelicula] = @cod_pelicula AND [cod_genero] = @cod_genero) = 0
	BEGIN
		-- INSERTO REGISTRO
		INSERT INTO [dbo].[tGeneroPelicula]
			   ([cod_pelicula], [cod_genero])
		 VALUES
			   (@cod_pelicula, @cod_genero)

		SELECT 
			@cod_pelicula cod_pelicula, 
			@cod_genero cod_genero,
			CONCAT(
			'Insertado Correctamente el género ',
			(SELECT TOP 1 [txt_desc] FROM [dbo].[tGenero] WHERE [cod_genero] = @cod_genero),
			' a la película ',
			(SELECT TOP 1 [txt_desc] FROM [dbo].[tPelicula] WHERE [cod_pelicula] = @cod_pelicula)
			) AS message
	END
	ELSE
	BEGIN
		-- ERROR
		RAISERROR ('La pelicula ya tiene asignado el genero.', 1, 1)
	END
END
GO