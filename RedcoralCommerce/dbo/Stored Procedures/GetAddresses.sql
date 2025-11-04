CREATE PROCEDURE GetAddresses
   @Email          nvarchar(100)
WITH ENCRYPTION
AS
   DECLARE @Error      INT
   DECLARE @CustomerID INT

   -- Initialize
   SET @Error = 0

   -- 
   -- Validate User
   --    Does user exist?
   --
   IF (@Error=0)
   BEGIN
      SELECT @CustomerID = [Customer].CustomerID FROM [Customer] WHERE [Customer].Email = @Email
      IF (@@ROWCOUNT <> 1)
      BEGIN
         SET @Error = 100000
         RAISERROR(@Error,16,1,@Email)
      END
   END 
   
   -- Get addresses for customer
   IF (@Error = 0)
   BEGIN
      SELECT *
      FROM Address
      WHERE CustomerID  = @CustomerID

      SET @Error = @@Error

   END

   RETURN @Error

GO

GRANT EXECUTE ON GetAddresses TO PUBLIC
GO