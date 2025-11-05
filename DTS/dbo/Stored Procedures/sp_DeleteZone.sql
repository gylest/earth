CREATE PROCEDURE [dbo].[sp_DeleteZone]
   @Name       NameUDT,
   @ConfigName VARCHAR(200)
AS
   DECLARE @Error INT
   DECLARE @ID    INT
   SET @Error = 0
   SET @ID = dbo.fn_GetZoneID( @Name, @ConfigName)
   IF (@ID=0)
   BEGIN
      SET @Error = 50005
   END
   IF (@Error=0)
   BEGIN
      DELETE FROM Zone WHERE [ID] = @ID
      IF (@@ROWCOUNT = 0)
      BEGIN
         SET @Error = 50003
      END
   END
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_DeleteZone] TO [DTSModifyRole]
    AS [dbo];
GO

