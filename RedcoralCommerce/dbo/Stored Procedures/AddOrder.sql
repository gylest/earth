CREATE PROCEDURE AddOrder
   @Email             nvarchar(100),
   @OrderNumber       nchar(15),
   @OrderDate         datetime,
   @OrderDescription  nvarchar(50),
   @OrderID           int      OUTPUT,
   @CustomerID        int      OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0
   
   -- Get customer ID
   IF (@Error=0)
   BEGIN
      SELECT @CustomerID = [Customer].CustomerID FROM [Customer] WHERE [Customer].Email = @Email
      IF (@@ROWCOUNT <> 1)
      BEGIN
         SET @Error = 100000
         RAISERROR(@Error,16,1,@Email)
      END
   END
   
   -- Add new order record
   IF (@Error=0)
   BEGIN
      INSERT INTO [Order] (  CustomerID,  OrderNumber,  OrderDate,  OrderStatus,  OrderDescription,  SubTotal, SalesTax, Freight, CreateDate, ModifyDate )
                  VALUES  ( @CustomerID, @OrderNumber, @OrderDate,  'QUOTE',     @OrderDescription,  0.0,      0.0,      0.0,     DEFAULT,    DEFAULT)
      SET @Error = @@Error
   END

   -- Set output values and audit
   IF (@Error=0)
   BEGIN
      -- Set output values
      SET @OrderID = SCOPE_IDENTITY()

      -- Audit
      DECLARE @appname nvarchar(128)
      DECLARE @user    nvarchar(256)
      DECLARE @msg     nvarchar(1024)

      SET @appname = APP_NAME()
      SET @user    = USER_NAME()
      SET @msg     = 'Added an order (ID = ' + CAST(@OrderID as nvarchar) + ', email = ' + @Email + ')'
      EXECUTE AddAuditMessage 'Information', @appname, @msg, @user
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON AddOrder TO PUBLIC
GO