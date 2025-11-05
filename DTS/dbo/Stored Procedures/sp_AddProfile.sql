CREATE PROCEDURE [dbo].[sp_AddProfile]
   @MeasurementID          INT,
   @MeasurementMode        INT,
   @MeasuredSignal         INT,
   @MeasurementProcess     INT,
   @SectionNumber          INT,
   @FibreNumber            INT,
   @FibreEnd               INT,
   @DistanceFirstDataPoint INT,
   @NumberDataPoints       INT,
   @NumberOfMissingPoints  INT,
   @LengthProfile          INT,
   @CRCValue               INT,
   @CompressionInd         INT,
   @DataPoints             IMAGE
AS
   DECLARE @Error    INT
   DECLARE @ConfigID INT
   SELECT @ConfigID = [ID] FROM Config WHERE Active = 1
   INSERT INTO Profiles (  MeasurementID,  ConfigID,  MeasurementMode,  MeasuredSignal,  MeasurementProcess,  SectionNumber,  FibreNumber,  FibreEnd,  DistanceFirstDataPoint,  NumberDataPoints, NumberOfMissingPoints, LengthProfile, CRCValue, CompressionInd, DataPoints,Retain)
               VALUES   ( @MeasurementID, @ConfigID, @MeasurementMode, @MeasuredSignal, @MeasurementProcess, @SectionNumber, @FibreNumber, @FibreEnd, @DistanceFirstDataPoint, @NumberDataPoints,@NumberOfMissingPoints,@LengthProfile,@CRCValue,@CompressionInd,@DataPoints,DEFAULT)
   SET @Error = @@Error
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_AddProfile] TO [DTSModifyRole]
    AS [dbo];
GO


