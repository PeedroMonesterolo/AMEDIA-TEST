USE TestCrud
GO

--6) Obtener las películas en stock para vender
CREATE PROCEDURE [dbo].[sp_sStockPeliculasVenta] 
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		[cod_pelicula] id
		, [txt_desc] pelicula
		, [cant_disponibles_venta] stock
		, [precio_venta] precio
	FROM [dbo].[tPelicula]
	WHERE [cant_disponibles_venta] > 0	
END
GO