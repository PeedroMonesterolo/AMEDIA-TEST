USE TestCrud
GO

--4) Asignar g�neros a pel�culas, verificar que la pel�cula no tenga asignada el g�nero previamente.
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
			'Insertado Correctamente el g�nero ',
			(SELECT TOP 1 [txt_desc] FROM [dbo].[tGenero] WHERE [cod_genero] = @cod_genero),
			' a la pel�cula ',
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