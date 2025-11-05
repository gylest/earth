CREATE PROCEDURE [dbo].[sp_AddFibreBreakMessage]
   @FibreType         INT,
   @FibreNumber       INT,
   @FirstPosition     INT,
   @SecondPosition    INT,
   @MeasurementID     INT
AS
   DECLARE @Error    INT
   DECLARE @ConfigID INT
   SELECT @ConfigID = [ID] FROM Config WHERE Active = 1
   INSERT INTO FibreBreak_Message (  MeasurementID,  ConfigID,  Type,       FibreNumber,  FirstPosition,  SecondPosition, Retain)
               VALUES             ( @MeasurementID, @ConfigID, @FibreType, @FibreNumber, @FirstPosition, @SecondPosition, DEFAULT)
   SET @Error = @@Error
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_AddFibreBreakMessage] TO [DTSModifyRole]
    AS [dbo];
GO