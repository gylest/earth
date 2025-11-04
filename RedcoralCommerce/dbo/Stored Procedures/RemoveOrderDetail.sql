CREATE PROCEDURE RemoveOrderDetail
   @OrderDetailID      int
WITH ENCRYPTION
AS
   DECLARE @Error       int
   DECLARE @OrderID     int
   DECLARE @OrderStatus strcatalog
   
   SET @Error = 0
   
   -- 
   -- Check order detail exists
   --
   IF (@Error=0)
   BEGIN
      SELECT @OrderID = [OrderDetail].OrderID FROM [OrderDetail] WHERE [OrderDetail].OrderDetailID = @OrderDetailID
      IF (@@ROWCOUNT <> 1)
      BEGIN
         SET @Error = 100004
         RAISERROR(@Error,16,1,@OrderDetailID)
      END
   END  
   
   --
   -- Check if associated order has been paid
   --
   IF (@Error=0)
   BEGIN
      SELECT @OrderStatus = [Order].OrderStatus FROM [Order] WHERE [Order].OrderID = @OrderID
      IF (@OrderStatus = 'PAID')
      BEGIN
         SET @Error = 100009
         RAISERROR(@Error,16,1,@OrderDetailID)
      END
   END
   
   -- Remove order detail
   IF (@Error=0)
   BEGIN
		DELETE OrderDetail  WHERE OrderDetailID = @OrderDetailID
   END
 
   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON RemoveOrderDetail TO PUBLIC
GO