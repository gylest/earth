CREATE PROCEDURE AddProduct
   @SKU                nvarchar(50),
   @ProductName        nvarchar(50),
   @ProductDescription nvarchar(50),
   @UnitPrice          money,
   @Note               nvarchar(50),
   @ForSale            boolean,
   @ProductID          int OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Add new record
   IF (@Error=0)
   BEGIN
      INSERT INTO Product (   SKU,  ProductName,  ProductDescription,  UnitPrice,  Note,  ForSale, CreateDate, ModifyDate )
                  VALUES   ( @SKU, @ProductName, @ProductDescription, @UnitPrice, @Note, @ForSale, DEFAULT,    DEFAULT)
      SET @Error = @@Error
   END

   -- Set output values and audit
   IF (@Error=0)
   BEGIN
      -- Set output values
      SET @ProductID = SCOPE_IDENTITY()

      -- Audit
      DECLARE @appname nvarchar(128)
      DECLARE @user    nvarchar(256)
      DECLARE @msg     nvarchar(1024)

      SET @appname = APP_NAME()
      SET @user    = USER_NAME()
      SET @msg     = 'Added a product (ID = ' + CAST(@ProductID as nvarchar) + ', SKU = ' + @SKU + ')'
      EXECUTE AddAuditMessage 'Information', @appname, @msg, @user
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON AddProduct TO PUBLIC
GO