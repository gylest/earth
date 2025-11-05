CREATE PROCEDURE [dbo].[sp_DeleteConfig]
   @ID        INT
AS
   DECLARE @Error  INT
   DECLARE @Total  INT
   DECLARE @Active BIT
   SET @Error = 0
   IF (@Error=0)
   BEGIN
      SELECT @Active= Active FROM Config WHERE [ID] = @ID
      IF (@@ROWCOUNT <> 1)
      BEGIN
         SET @Error = 50001     -- config must exist if it is to be deleted!
      END
      ELSE
      BEGIN
         SELECT @Total = COUNT(*) FROM Config
         IF (@Active=1) AND (@Total > 1)
         BEGIN
            SET @Error = 50009  -- can only remove active config when there are no other configs
         END
      END
   END
   IF (@Error=0)
   BEGIN
      BEGIN TRANSACTION
      DELETE FROM Alarm_Message WHERE ZoneID IN (SELECT ID FROM Zone WHERE ConfigID = @ID)
      DELETE FROM FibreBreak_Message WHERE ConfigID = @ID
      DELETE FROM Profiles WHERE ConfigID = @ID
      DELETE FROM Zone_Message WHERE ZoneID IN (SELECT ID FROM Zone WHERE ConfigID = @ID)
      DELETE FROM Zone WHERE ConfigID = @ID
      DELETE FROM Zone_Process WHERE ConfigID = @ID
      DELETE FROM Alarm_Band WHERE AlarmID IN (SELECT ID FROM Alarm WHERE ConfigID = @ID)
      DELETE FROM Alarm WHERE ConfigID = @ID
      DELETE FROM Config WHERE [ID] = @ID
      IF (@@ROWCOUNT = 1)
      BEGIN
         COMMIT TRANSACTION
      END
      ELSE
      BEGIN
         ROLLBACK TRANSACTION
         SET @Error = 50010       -- unexpected error when trying to remove config record
      END
   END
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_DeleteConfig] TO [DTSModifyRole]
    AS [dbo];
GO


