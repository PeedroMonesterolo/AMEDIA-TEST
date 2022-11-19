USE TestCrud
GO

--1) Crear usuarios, cuyo documento no exista actualmente en la base de datos, en caso de existir, debería devolver un mensaje de error, en caso contrario insertarlo
CREATE PROCEDURE [dbo].[tUsers_iUsers] 
	@txt_user VARCHAR(50),
    @txt_password VARCHAR(50),
	@txt_nombre VARCHAR(200),
	@txt_apellido VARCHAR(200),
	@nro_doc VARCHAR(50),
	@cod_rol INT,
	@sn_activo INT
AS
BEGIN
	SET NOCOUNT ON;

	IF (SELECT COUNT(*) FROM [dbo].[tRol] WHERE [cod_rol] = @cod_rol) = 0
	BEGIN
		RAISERROR ('No existe el rol.', 1, 1)
		RETURN;
	END

	IF (SELECT COUNT(*) FROM [dbo].[tUsers] WHERE [nro_doc] = @nro_doc) = 0
	BEGIN
		-- INSERTO REGISTRO
		INSERT INTO [dbo].[tUsers]
				   ([txt_user]
				   ,[txt_password]
				   ,[txt_nombre]
				   ,[txt_apellido]
				   ,[nro_doc]
				   ,[cod_rol]
				   ,[sn_activo])
			 VALUES
				   (@txt_user
				   ,@txt_password
				   ,@txt_nombre
				   ,@txt_apellido
				   ,@nro_doc
				   ,@cod_rol
				   ,@sn_activo)

	END
	ELSE
	BEGIN
		-- ERROR
		RAISERROR ('Ya existe el usuario que se quiere crear.', 1, 1)
		RETURN;
	END
END
GO
