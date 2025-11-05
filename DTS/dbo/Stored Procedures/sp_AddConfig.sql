CREATE PROCEDURE [dbo].[sp_AddConfig]
   @Name        VARCHAR(200),
   @Description VARCHAR(200)
AS
   DECLARE @Error INT
   INSERT INTO Config ( Name, Description, Version, Active, CreateDT, ModifyDT)
               VALUES (@Name,@Description, 1,       0,      DEFAULT,  NULL)
   SET @Error = @@Error
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_AddConfig] TO [DTSModifyRole]
    AS [dbo];
GO

