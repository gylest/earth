CREATE PROCEDURE [dbo].[sp_ModifyConfigToActive]
   @Name        VARCHAR(200)
AS
   DECLARE @Error            INT
   DECLARE @OuterTransaction BIT            -- Does outer transaction exist?
   SET @Error = 0
   IF (@@TRANCOUNT > 0)
      SET @OuterTransaction = 1
   ELSE
      SET @OuterTransaction = 0
   IF (@Error = 0)
   BEGIN
      IF (@OuterTransaction = 0)
         BEGIN TRANSACTION 
      ELSE
         SAVE TRANSACTION MOD_POINT
      UPDATE Config SET Active = 0
      UPDATE Config SET Active = 1 WHERE [Name] = @Name
      IF (@@ROWCOUNT = 1)
      BEGIN
         IF (@OuterTransaction = 0)
            COMMIT TRANSACTION
      END
      ELSE
      BEGIN
         IF (@OuterTransaction = 0)
            ROLLBACK TRANSACTION
         ELSE
            ROLLBACK TRANSACTION MOD_POINT
         SET @Error = 50004
      END
   END
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_ModifyConfigToActive] TO [DTSModifyRole]
    AS [dbo];
GO

