CREATE PROCEDURE [dbo].[ChangeSensor]
   @ID                int,
   @uidDTS            str64,
   @Description       str256,
   @uidSource         str64,
   @nameField         str64,
   @numSlot           str32,
   @nameInstallation  str64,
   @country           str64,
   @operator          str64,
   @ModifyDate        datetime        OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error    int
   DECLARE @Count    int

   SET @Error = 0

   -- Update
   IF (@Error = 0)
   BEGIN
      UPDATE Sensors 
         SET [uidDTS]           = @uidDTS,
             [uidSource]        = @uidSource,
             [nameField]        = @nameField,
             [numSlot]          = @numSlot,
             [nameInstallation] = @nameInstallation,
             [country]          = @country,
             [operator]         = @operator,
             [Description]      = @Description,
             [ModifyDate]       = DEFAULT
      WHERE  [ID] = @ID

      SET @Count = @@ROWCOUNT
      SET @Error = @@ERROR

      IF @Count <> 1
      BEGIN
         SET @Error = 60101
         RAISERROR ( @Error, 16, 1, @ID) WITH LOG
      END
   END

   -- Set output values
   IF (@Error = 0)
   BEGIN
      SELECT @ModifyDate = [ModifyDate] FROM Sensors WHERE [ID] = @ID
   END

   -- Set return code
   RETURN @Error
GO


GRANT EXECUTE
    ON OBJECT::[dbo].[ChangeSensor] TO PUBLIC
    AS [dbo];
GO

