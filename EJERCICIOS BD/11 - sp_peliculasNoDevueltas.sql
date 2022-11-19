USE TestCrud
GO

--11) Ver películas que no fueron devueltas y que usuarios la tienen
CREATE PROCEDURE [dbo].[sp_peliculasNoDevueltas] 
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT 
		TA.[cod_alquiler] 
		, TA.[precio]
		, TA.[fecha]
		, TP.[txt_desc] pelicula
		, TU.[txt_user] usuario
		, TU.[txt_nombre] nombre
		, TU.[txt_apellido] apellido
	FROM [dbo].[tAlquiler] TA
	INNER JOIN [dbo].[tPelicula] TP
		ON TP.[cod_pelicula] = TA.[cod_pelicula]
	INNER JOIN [dbo].[tUsers] TU
		ON TU.[cod_usuario] = TA.[cod_usuario]
	WHERE TA.[devuelta] = 0 -- NO DEVUELTA
END
GO