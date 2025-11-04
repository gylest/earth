CREATE PROCEDURE GetOrderDetails
   @OrderID         int
WITH ENCRYPTION
AS
   DECLARE @Error      int

   -- Initialize
   SET @Error = 0
   
   -- Get order details
   IF (@Error = 0)
   BEGIN
      SELECT * FROM [OrderDetail] WHERE OrderID = @OrderID

      SET @Error = @@Error
   END

   RETURN @Error

GO

GRANT EXECUTE ON GetOrderDetails TO PUBLIC
GO