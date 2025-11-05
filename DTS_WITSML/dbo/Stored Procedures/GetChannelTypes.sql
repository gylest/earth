CREATE PROCEDURE [dbo].[GetChannelTypes]
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Select all channel types
   IF (@Error = 0)
   BEGIN
      SELECT mnemonic, MeasurementMode, MeasuredSignal, MeasurementProcess, FibreEnd
      FROM ChannelTypes

      SET @Error = @@ERROR
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[GetChannelTypes] TO PUBLIC
    AS [dbo];
GO

