CREATE PROCEDURE ChangeOrderDetail
   @OrderDetailID     int,
   @UnitPrice         money,
   @Quantity          int,
   @UnitPriceDiscount money,
   @LineTotal         money      OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error      int
   DECLARE @OrderID    int

   SET @Error = 0
   
   -- 
   -- Validate order detail
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
   
   -- Modify order detail 
   IF (@Error=0)
   BEGIN
      UPDATE [OrderDetail] 
         SET [UnitPrice]         = @UnitPrice,
             [Quantity]          = @Quantity,
             [UnitPriceDiscount] = @UnitPriceDiscount,
             [ModifyDate]        = DEFAULT
      WHERE  [OrderDetailID] = @OrderDetailID
      SET @Error = @@Error
   END
   
   -- Set output value
   IF (@Error=0)
   BEGIN
      SELECT @LineTotal = LineTotal FROM [OrderDetail] WHERE [OrderDetail].OrderDetailID = @OrderDetailID
      SET @Error = @@Error
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON ChangeOrderDetail TO PUBLIC
GO
