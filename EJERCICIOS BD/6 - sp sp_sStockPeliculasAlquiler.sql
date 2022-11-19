USE TestCrud
GO

--5) Alquilar y Vender películas
CREATE PROCEDURE [dbo].[sp_sStockPeliculasAlquiler] 
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		[cod_pelicula] id
		, [txt_desc] pelicula
		, [cant_disponibles_alquiler] stock
		, [precio_alquiler] precio
	FROM [dbo].[tPelicula]
	WHERE [cant_disponibles_alquiler] > 0	
END
GO