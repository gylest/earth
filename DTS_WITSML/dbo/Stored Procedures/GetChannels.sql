CREATE PROCEDURE [dbo].[GetChannels]
   @FiberID         int
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Select channels for a fiber
   IF (@Error = 0)
   BEGIN
      SELECT [ID], FiberID, mnemonic, columnIndex, classPOSC, unit, [description], CreateDate, ModifyDate
      FROM Channels
      WHERE [FiberID] = @FiberID

      SET @Error = @@ERROR
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[GetChannels] TO PUBLIC
    AS [dbo];
GO

