CREATE PROCEDURE [dbo].[GetUnitAcquisition]
   @ID         int
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Select single row for UnitAcquisitions
   IF (@Error = 0)
   BEGIN
      SELECT [ID], numSerial, dTim, calibration_dtim, configuration_dtim,
             manufacturer, model, supplier, CreateDate, ModifyDate
      FROM UnitAcquisitions
      WHERE [ID] = @ID

      SET @Error = @@ERROR
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[GetUnitAcquisition] TO PUBLIC
    AS [dbo];
GO

