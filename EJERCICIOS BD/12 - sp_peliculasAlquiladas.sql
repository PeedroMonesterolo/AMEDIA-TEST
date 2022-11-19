USE TestCrud
GO

--12) Ver qué películas fueron alquiladas por usuario y cuánto pagó y que día
CREATE PROCEDURE [dbo].[sp_peliculasAlquiladas] 
	@cod_usuario INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT 
		TA.[cod_alquiler] 
		, TA.[precio] pago
		, TA.[fecha] fecha
		, TP.[txt_desc] pelicula
		, TU.[txt_user] usuario
		, TU.[txt_nombre] nombre
		, TU.[txt_apellido] apellido
	FROM [dbo].[tAlquiler] TA
	INNER JOIN [dbo].[tPelicula] TP
		ON TP.[cod_pelicula] = TA.[cod_pelicula]
	INNER JOIN [dbo].[tUsers] TU
		ON TU.[cod_usuario] = TA.[cod_usuario]
	WHERE TU.[cod_usuario] = @cod_usuario
END
GO