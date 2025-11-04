CREATE PROCEDURE GetProduct
   @SKU          nvarchar(50)
WITH ENCRYPTION
AS
   DECLARE @Error      INT

   -- Initialize
   SET @Error = 0

   -- Get customer
   IF (@Error = 0)
   BEGIN
      SELECT * FROM [Product] WHERE SKU = @SKU

      SET @Error = @@Error

   END

   RETURN @Error

GO

GRANT EXECUTE ON GetProduct TO PUBLIC
GO