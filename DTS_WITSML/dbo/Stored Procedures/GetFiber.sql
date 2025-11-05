CREATE PROCEDURE [dbo].[GetFiber]
   @WellboreID         int
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Select single fiber for well bore
   IF (@Error = 0)
   BEGIN
      SELECT [ID], WellboreID, fiberNumber, numSerial, correctionConstants, indexChannel, ProcessingMethod,
             length, dTim, retrievable,  offset, DirectionRef, lossTwoWay,
             installationCompany, manufacturer, type, diameter, indexRef, lossdiff,  
             lossLoop, lossConnector, lossOther, settingLoss, CreateDate, ModifyDate
      FROM Fibers
      WHERE [WellboreID] = @WellboreID

      SET @Error = @@ERROR
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[GetFiber] TO PUBLIC
    AS [dbo];
GO

