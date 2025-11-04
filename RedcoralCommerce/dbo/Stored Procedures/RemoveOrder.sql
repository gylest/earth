CREATE PROCEDURE RemoveOrder
   @OrderID      int
WITH ENCRYPTION
AS
   DECLARE @Error       int
   DECLARE @OrderStatus strcatalog

   SET @Error = 0

   -- Check order exists
   IF (@Error=0)
   BEGIN
      SELECT @OrderStatus=OrderStatus FROM [Order] WHERE [Order].OrderID = @OrderID
      IF (@@ROWCOUNT <> 1)
      BEGIN
         SET @Error = 100002
         RAISERROR(@Error,16,1,@OrderID)
      END
   END
   
   -- Check order is quote
   IF (@Error=0)
   BEGIN
      IF @OrderStatus != 'QUOTE'
      BEGIN
         SET @Error = 100005
         RAISERROR(@Error,16,1,@OrderID)
      END
   END
   
   -- Remove order and order details
   IF (@Error=0)
   BEGIN
      BEGIN TRANSACTION
      
      IF (@Error=0)
      BEGIN
         DELETE OrderDetail  WHERE OrderID = @OrderID
         SET @Error = @@ERROR 
      END
      
      IF (@Error=0)
      BEGIN
         DELETE [Order]  WHERE OrderID = @OrderID
         SET @Error = @@ERROR 
      END
	
	  IF (@Error=0)
         COMMIT TRANSACTION
      ELSE
         ROLLBACK TRANSACTION
   END
 
   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON RemoveOrder TO PUBLIC
GO