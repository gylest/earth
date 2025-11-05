CREATE PROCEDURE [dbo].[GetSensors]
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Select all rows in table
   IF (@Error = 0)
   BEGIN
      SELECT [ID], uidDTS, [Description], Active, uidSource, nameField,
              numSlot, nameInstallation, country, operator, CreateDate, ModifyDate
      FROM Sensors

      SET @Error = @@ERROR
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[GetSensors] TO PUBLIC
    AS [dbo];
GO

