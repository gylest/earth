CREATE PROCEDURE [dbo].[sp_AddMeasurement]
   @DTSID              INT,
   @TimeStampUTC       DATETIME,
   @TimeStampLoc       DATETIME,
   @ID                 INT        OUTPUT
AS
   DECLARE @Error INT
   SET @Error = 0
   SET @ID    = 0
   IF (@Error=0)
   BEGIN
      INSERT INTO Measurement (  DTSID,  TimeStampUTC, TimeStampLoc)
                  VALUES      ( @DTSID, @TimeStampUTC, SYSDATETIME())
      SET @Error = @@Error
   END
   IF (@Error=0)
   BEGIN
      SET @ID= SCOPE_IDENTITY()
   END
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_AddMeasurement] TO [DTSModifyRole]
    AS [dbo];
GO


