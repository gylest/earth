CREATE PROCEDURE [dbo].[sp_GetConfigs]
AS
   DECLARE @Error      INT
   SET @Error = 0
   IF (@Error = 0)
   BEGIN
      SELECT Config.ID, Config.Name, Config.Description, Config.Version, Config.Active, Config.CreateDT, Config.ModifyDT
      FROM Config
      ORDER BY Config.ID
      SET @Error = @@Error
   END
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_GetConfigs] TO [DTSReadRole]
    AS [dbo];
GO

