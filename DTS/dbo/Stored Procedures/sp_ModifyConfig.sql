CREATE PROCEDURE [dbo].[sp_ModifyConfig]
   @OldName     VARCHAR(200),
   @NewName     VARCHAR(200),
   @Description VARCHAR(200)
AS
   DECLARE @Error   INT
   DECLARE @Version INT
   SET @Error = 0
   IF (@Error = 0)
   BEGIN
       SELECT @Version = Version FROM Config WHERE [Name] = @OldName
       IF (@@ROWCOUNT = 0)
       BEGIN
           SET @Error = 50002  -- No record found
       END
   END
   IF (@Error = 0)
   BEGIN
      SET @Version = @Version + 1
      UPDATE Config
         SET Name = @NewName, Description = @Description, Version = @Version, ModifyDT = SYSDATETIME()
         WHERE [Name] = @OldName
      SET @Error = @@ERROR
   END
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_ModifyConfig] TO [DTSModifyRole]
    AS [dbo];
GO

