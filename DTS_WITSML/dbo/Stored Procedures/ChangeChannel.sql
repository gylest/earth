CREATE PROCEDURE [dbo].[ChangeChannel]
   @ID                   int,
   @mnemonic             str256,
   @columnIndex          int,
   @classPOSC            strcatalog = NULL,
   @unit                 strcatalog = NULL,
   @description          str256     = NULL,
   @ModifyDate           datetime        OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error    int
   DECLARE @Count    int

   SET @Error = 0

   -- Update
   IF (@Error = 0)
   BEGIN
      UPDATE Channels 
         SET [mnemonic]    = @mnemonic,
             [classPOSC]   = @classPOSC,
             [unit]        = @unit,
             [columnIndex] = @columnIndex,
             [description] = @description,
             [ModifyDate]  = DEFAULT
      WHERE  [ID] = @ID

      SET @Count = @@ROWCOUNT
      SET @Error = @@ERROR

      IF @Count <> 1
      BEGIN
         SET @Error = 60601
         RAISERROR ( @Error, 16, 1, @ID) WITH LOG
      END
   END

   -- Set output values
   IF (@Error = 0)
   BEGIN
      SELECT @ModifyDate = [ModifyDate] FROM Channels WHERE [ID] = @ID
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[ChangeChannel] TO PUBLIC
    AS [dbo];
GO

