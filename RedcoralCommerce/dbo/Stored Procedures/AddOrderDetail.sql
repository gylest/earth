CREATE PROCEDURE AddOrderDetail
   @OrderID           int,
   @ProductID         int,
   @UnitPrice         money,
   @Quantity          int,
   @UnitPriceDiscount money,
   @OrderDetailID     int        OUTPUT,
   @LineTotal         money      OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error    int
   DECLARE @CustomerID int

   SET @Error = 0
   
   -- Check order exists
   IF (@Error=0)
   BEGIN
      SELECT * FROM [Order] WHERE [Order].OrderID = @OrderID
      IF (@@ROWCOUNT <> 1)
      BEGIN
         SET @Error = 100002
         RAISERROR(@Error,16,1,@OrderID)
      END
   END
   
    -- Check product exists
   IF (@Error=0)
   BEGIN
      SELECT * FROM [Product] WHERE [Product].ProductID = @ProductID
      IF (@@ROWCOUNT <> 1)
      BEGIN
         SET @Error = 100003
         RAISERROR(@Error,16,1,@OrderID)
      END
   END  
   
   -- Add new order detail record
   IF (@Error=0)
   BEGIN
      INSERT INTO [OrderDetail] (  OrderID,  ProductID,  UnitPrice,  Quantity,  UnitPriceDiscount,  CreateDate, ModifyDate)
                  VALUES        ( @OrderID, @ProductID, @UnitPrice, @Quantity, @UnitPriceDiscount , DEFAULT,    DEFAULT)
      SET @Error = @@Error
   END

   -- Set output values and audit
   IF (@Error=0)
   BEGIN
      -- Set output values
      SET    @OrderDetailID = SCOPE_IDENTITY()
      SELECT @LineTotal = LineTotal FROM [OrderDetail] WHERE [OrderDetail].OrderDetailID = @OrderDetailID
      
      -- Audit
      DECLARE @appname nvarchar(128)
      DECLARE @user    nvarchar(256)
      DECLARE @msg     nvarchar(1024)

      SET @appname = APP_NAME()
      SET @user    = USER_NAME()
      SET @msg     = 'Added an order detail(ID = ' + CAST(@OrderDetailID as nvarchar) + ', order = ' + CAST(@OrderID as nvarchar) + ')'
      EXECUTE AddAuditMessage 'Information', @appname, @msg, @user
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON AddOrderDetail TO PUBLIC
GO
