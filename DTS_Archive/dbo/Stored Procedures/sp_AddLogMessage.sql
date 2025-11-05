CREATE PROCEDURE [dbo].[sp_AddLogMessage]
   @LogMessage  VARCHAR(500),
   @LogGroup    INT
WITH ENCRYPTION
AS
   DECLARE @Error INT

   INSERT INTO Application_Log (  LogMessage,  LogGroup, CreateDT)
               VALUES          ( @LogMessage, @LogGroup, DEFAULT)
   SET @Error = @@ERROR
   --
   -- Check error status and exit
   --
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END

   RETURN @Error

GO

