CREATE PROCEDURE [dbo].[sp_AddLogMessage]
   @LogMessage  VARCHAR(500),
   @LogGroup    INT
AS
   DECLARE @Error INT
   INSERT INTO Application_Log (  LogMessage,  LogGroup, CreateDT)
               VALUES          ( @LogMessage, @LogGroup, DEFAULT)
   SET @Error = @@ERROR
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_AddLogMessage] TO [DTSModifyRole]
    AS [dbo];
GO
