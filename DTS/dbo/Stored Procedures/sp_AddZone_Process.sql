CREATE PROCEDURE [dbo].[sp_AddZoneProcess]
   @ProcessName                      NameUDT,
   @ProcessNameLocal                 LocalUDT,
   @ConfigName                       VARCHAR(200),
   @ProcessingMethod                 INT,
   @PositionReference                INT,
   @OutputEnabled                    INT,
   @MeasurementLossFirstInterval     INT,
   @MeasurementLossSecondInterval    INT,
   @NumberOfRateOfChangeMeasurements INT
AS
   DECLARE @Error    INT
   DECLARE @ConfigID INT
   SET @Error = 0
   IF (@Error=0)
   BEGIN
      IF (@ConfigName is null)
      BEGIN
         SELECT @ConfigName = [Name] FROM Config WHERE Active = 1
      END
      SELECT @ConfigID = [ID] FROM Config WHERE [Name] = @ConfigName
      IF (@@ROWCOUNT = 0)
      BEGIN
         SET @Error = 50001
      END
   END
   IF (@Error = 0)
   BEGIN
      INSERT INTO Zone_Process (  ProcessName,  ProcessNameLocal, Version,  ConfigID,  ProcessingMethod,  PositionReference,  OutputEnabled,  MeasurementLossFirstInterval,  MeasurementLossSecondInterval, NumberOfRateOfChangeMeasurements, CreateDT, ModifyDT)
                  VALUES       ( @ProcessName, @ProcessNameLocal, 1,       @ConfigID, @ProcessingMethod, @PositionReference, @OutputEnabled, @MeasurementLossFirstInterval, @MeasurementLossSecondInterval,@NumberOfRateOfChangeMeasurements, DEFAULT,  NULL)
   END
   SET @Error = @@Error
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_AddZoneProcess] TO [DTSModifyRole]
    AS [dbo];
GO
