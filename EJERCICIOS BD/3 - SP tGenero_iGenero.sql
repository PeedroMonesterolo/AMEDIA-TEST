USE TestCrud
GO

--3) Crear géneros
CREATE PROCEDURE [dbo].[tGenero_iGenero] 
	@txt_desc VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON;

	IF (SELECT COUNT(*) FROM [dbo].[tGenero] WHERE [txt_desc] LIKE '%' + @txt_desc + '%') = 0
	BEGIN
		-- INSERTO REGISTRO
		INSERT INTO [dbo].[tGenero]
			   ([txt_desc])
		 VALUES
			   (@txt_desc)

		SELECT 
			SCOPE_IDENTITY() cod_genero, 
			@txt_desc txt_desc
	END
	ELSE
	BEGIN
		-- ERROR
		RAISERROR ('Ya existe el genero.', 1, 1)
	END
END
GO