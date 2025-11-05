CREATE PROCEDURE [dbo].[ChangeUnitAcquisition]
   @ID                 int,
   @numSerial          str32,
   @dTim               datetime,
   @calibration_dtim   datetime,
   @configuration_dtim datetime,
   @manufacturer       str64,
   @model              str32,
   @supplier           str32,
   @ModifyDate         datetime        OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error    int
   DECLARE @Count    int

   SET @Error = 0

   -- Update
   IF (@Error = 0)
   BEGIN
      UPDATE UnitAcquisitions 
         SET [numSerial]          = @numSerial,
             [manufacturer]       = @manufacturer,
             [model]              = @model,
             [supplier]           = @supplier,
             [dTim]               = @dTim,
             [calibration_dtim]   = @calibration_dtim,
             [configuration_dtim] = @configuration_dtim,
             [ModifyDate]         = DEFAULT
      WHERE  [ID] = @ID

      SET @Count = @@ROWCOUNT
      SET @Error = @@ERROR

      IF @Count <> 1
      BEGIN
         SET @Error = 60401
         RAISERROR ( @Error, 16, 1, @ID) WITH LOG
      END
   END

   -- Set output values
   IF (@Error = 0)
   BEGIN
      SELECT @ModifyDate = [ModifyDate] FROM UnitAcquisitions WHERE [ID] = @ID
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[ChangeUnitAcquisition] TO PUBLIC
    AS [dbo];
GO

