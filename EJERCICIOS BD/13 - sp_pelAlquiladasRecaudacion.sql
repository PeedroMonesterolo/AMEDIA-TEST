USE TestCrud
GO

--13) Ver todas las películas, cuantas veces fueron alquiladas y cuanto se recaudo por ellas
CREATE PROCEDURE [dbo].[sp_pelAlquiladasRecaudacion] 
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT 
		TP.[cod_pelicula],
		TP.[txt_desc] pelicula,
		COUNT(TP.[cod_pelicula]) veces_alquiladas,
		SUM(TP.[precio_alquiler]) recaudacion
	FROM [dbo].[tPelicula] TP
	INNER JOIN [dbo].[tAlquiler] TA
		ON TP.[cod_pelicula] = TA.[cod_pelicula]
	GROUP BY TP.[cod_pelicula], TP.[txt_desc]
END
GO