CREATE PROCEDURE GetCustomer
   @Email          nvarchar(100)
WITH ENCRYPTION
AS
   DECLARE @Error      INT

   -- Initialize
   SET @Error = 0

   -- Get customer
   IF (@Error = 0)
   BEGIN
      SELECT *
      FROM Customer
      WHERE Email = @Email

      SET @Error = @@Error

   END

   RETURN @Error

GO

GRANT EXECUTE ON GetCustomer TO PUBLIC
GO