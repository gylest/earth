CREATE PROCEDURE [dbo].[ChangeSensorToActive]
   @ID                int,
   @ModifyDate        datetime        OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error          int
   DECLARE @Count          int
   DECLARE @countUA        int
   DECLARE @countBores     int

   SET @Error = 0

   --
   -- Validation
   -- 

   -- V1) Check Sensor exists
   IF (@Error=0)
   BEGIN
      SELECT @Count = COUNT(*) FROM Sensors WHERE [ID] = @ID

      IF (@Count <> 1)
      BEGIN
         SET @Error = 60104
         RAISERROR ( @Error, 16, 1, @ID) WITH LOG
      END     
   END

   -- V2) Check Sensor has necessary children to be made active
   IF (@Error = 0)
   BEGIN
      SELECT @countUA     = COUNT(*) FROM UnitAcquisitions WHERE [ID] = @ID

      SELECT @countBores  = COUNT(*) FROM Wellbores
      WHERE WellID IN
      (SELECT [ID] FROM Wells WHERE [DTSID] = @ID)
    
      IF (@countUA=0) OR (@countBores=0)
      BEGIN
         SET @Error = 60105
         RAISERROR ( @Error, 16, 1, @ID) WITH LOG
      END
   END

   --
   -- Update actvity
   --
   IF (@Error = 0)
   BEGIN
      -- Start a transaction
      BEGIN TRANSACTION 

      -- De-activate existing Sensor
      UPDATE Sensors
         SET [Active]     = 0,
             [ModifyDate] = DEFAULT
      WHERE  [Active]     = 1 AND
             [ID]         <> @ID

      -- Set required Sensor to Active
      UPDATE Sensors 
         SET [Active]     = 1,
             [ModifyDate] = DEFAULT
      WHERE  [ID] = @ID

      -- If successful commit else rollback ...
      IF (@@ROWCOUNT = 1)
      BEGIN
         COMMIT TRANSACTION
      END
      ELSE
      BEGIN
         SET @Error = 60101
         RAISERROR ( @Error, 16, 1, @ID) WITH LOG
         ROLLBACK TRANSACTION
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
    ON OBJECT::[dbo].[ChangeSensorToActive] TO PUBLIC
    AS [dbo];
GO

