CREATE PROCEDURE [dbo].[ChangeWell]
   @ID                int,
   @uidWell           str64,
   @nameWell          str64,
   @ModifyDate        datetime        OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error    int
   DECLARE @Count    int

   SET @Error = 0

   -- Update
   IF (@Error = 0)
   BEGIN
      UPDATE Wells 
         SET [uidWell]         = @uidWell,
             [nameWell]        = @nameWell,
             [ModifyDate]      = DEFAULT
      WHERE  [ID] = @ID

      SET @Count = @@ROWCOUNT
      SET @Error = @@ERROR

      IF @Count <> 1
      BEGIN
         SET @Error = 60201
         RAISERROR ( @Error, 16, 1, @ID) WITH LOG
      END
   END

   -- Set output values
   IF (@Error = 0)
   BEGIN
      SELECT @ModifyDate = [ModifyDate] FROM Wells WHERE [ID] = @ID
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[ChangeWell] TO PUBLIC
    AS [dbo];
GO

