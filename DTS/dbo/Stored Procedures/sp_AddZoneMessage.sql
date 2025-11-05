CREATE PROCEDURE [dbo].[sp_AddZoneMessage]
   @Name              NameUDT,
   @Value             FLOAT,
   @Position          INT,
   @MeasurementID     INT,
   @MeasurementStatus INT
AS
   DECLARE @Error    INT
   DECLARE @ConfigID INT
   DECLARE @ZoneID   INT
   SELECT @ConfigID = [ID] FROM Config WHERE Active = 1
   SELECT @ZoneID   = [ID] FROM Zone   WHERE [Name] = @Name AND ConfigID = @ConfigID
   INSERT INTO Zone_Message (  Value,  Position,  MeasurementID,  ZoneID,  MeasurementStatus, Retain)
               VALUES       ( @Value, @Position, @MeasurementID, @ZoneID, @MeasurementStatus, DEFAULT)
   SET @Error = @@Error
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_AddZoneMessage] TO [DTSModifyRole]
    AS [dbo];
GO


