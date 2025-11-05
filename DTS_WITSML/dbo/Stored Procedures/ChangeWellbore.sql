CREATE PROCEDURE [dbo].[ChangeWellbore]
   @ID                int,
   @uidWellbore       str64,
   @nameWellbore      str64,
   @depth             length,
   @dtmPermanent      strcatalog,
   @ModifyDate        datetime        OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error    int
   DECLARE @Count    int

   SET @Error = 0

   -- Update
   IF (@Error = 0)
   BEGIN
      UPDATE Wellbores 
         SET [uidWellbore]  = @uidWellbore,
             [nameWellbore] = @nameWellbore,
             [depth]        = @depth,
             [dtmPermanent] = @dtmPermanent,
             [ModifyDate]   = DEFAULT
      WHERE  [ID] = @ID

      SET @Count = @@ROWCOUNT
      SET @Error = @@ERROR

      IF @Count <> 1
      BEGIN
         SET @Error = 60301
         RAISERROR ( @Error, 16, 1, @ID) WITH LOG
      END
   END

   -- Set output values
   IF (@Error = 0)
   BEGIN
      SELECT @ModifyDate = [ModifyDate] FROM Wellbores WHERE [ID] = @ID
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[ChangeWellbore] TO PUBLIC
    AS [dbo];
GO

