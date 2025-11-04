CREATE PROCEDURE GetOrders
   @Email          nvarchar(100)
WITH ENCRYPTION
AS
   DECLARE @Error      INT
   DECLARE @CustomerID INT

   -- Initialize
   SET @Error = 0
   
   -- 
   -- Validate User
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
   
   -- Get customer
   IF (@Error = 0)
   BEGIN
      SELECT *
      FROM [Order]
      WHERE CustomerID = @CustomerID

      SET @Error = @@Error

   END

   RETURN @Error

GO

GRANT EXECUTE ON GetOrders TO PUBLIC
GO