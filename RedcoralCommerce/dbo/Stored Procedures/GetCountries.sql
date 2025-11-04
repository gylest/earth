CREATE PROCEDURE GetCountries
WITH ENCRYPTION
AS
   DECLARE @Error            int

   SET @Error = 0

   -- Get countries
   IF (@Error = 0)
   BEGIN
      SELECT * FROM Country
      SET @Error = @@ERROR
   END  

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON GetCountries TO PUBLIC
GO