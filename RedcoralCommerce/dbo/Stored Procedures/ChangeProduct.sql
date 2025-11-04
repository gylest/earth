CREATE PROCEDURE ChangeProduct
   @SKU                nvarchar(50),
   @ProductName        nvarchar(50),
   @ProductDescription nvarchar(50),
   @UnitPrice          money,
   @Note               nvarchar(50),
   @ForSale            boolean
WITH ENCRYPTION
AS
   DECLARE @Error     int
   DECLARE @ProductID int

   SET @Error = 0
   
   -- 
   -- Check product exists
   --
   IF (@Error=0)
   BEGIN
      SELECT @ProductID = ProductID FROM [Product] WHERE [Product].SKU = @SKU
      IF (@@ROWCOUNT <> 1)
      BEGIN
         SET @Error = 100007
         RAISERROR(@Error,16,1, @SKU)
      END
   END 

   -- Modify record
   IF (@Error=0)
   BEGIN
      UPDATE Product 
         SET [ProductName]        = @ProductName,
             [ProductDescription] = @ProductDescription,
             [UnitPrice]          = @UnitPrice,
             [Note]               = @Note,
             [ForSale]            = @ForSale,
             [ModifyDate]         = DEFAULT
      WHERE  [SKU] = @SKU
      SET @Error = @@Error
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON ChangeProduct TO PUBLIC
GO