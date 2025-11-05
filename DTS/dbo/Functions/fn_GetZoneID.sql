CREATE FUNCTION [dbo].[fn_GetZoneID]  (@ZoneName VARCHAR(200), @ConfigName VARCHAR(200))
RETURNS INT
AS
BEGIN
   DECLARE @ID        int
   DECLARE @ConfigID  int
   SELECT  @ID       = 0
   SELECT  @ConfigID = 0
   IF (@ConfigName is null)
   BEGIN
      SELECT @ConfigName = [Name] FROM Config WHERE Active = 1
   END
   SELECT @ConfigID = [ID] FROM Config WHERE [Name] = @ConfigName
   IF (@@ROWCOUNT = 1)
   BEGIN
      SELECT @ID = [ID] FROM Zone WHERE [Name] = @ZoneName AND [ConfigID] = @ConfigID
      IF (@@ROWCOUNT = 0)
      BEGIN
         SELECT @ID = 0
      END
   END
   RETURN(@ID)
END
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[fn_GetZoneID] TO [DTSReadRole]
    AS [dbo];
GO