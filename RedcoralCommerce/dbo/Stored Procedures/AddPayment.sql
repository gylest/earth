CREATE PROCEDURE AddPayment
   @CardType       int,
   @CardNumber     nvarchar(50),
   @CardHolderName nvarchar(50),
   @CardExpiryDate date,
   @PaymentID      int        OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Add new record
   IF (@Error=0)
   BEGIN
      INSERT INTO Payment (   CardType,  CardNumber,  CardHolderName,  CardExpiryDate,  CreateDate, ModifyDate )
                  VALUES   ( @CardType, @CardNumber, @CardHolderName, @CardExpiryDate,  DEFAULT,    DEFAULT)
      SET @Error = @@Error
   END

   -- Set output values and audit
   IF (@Error=0)
   BEGIN
      -- Set output values
      SET @PaymentID = SCOPE_IDENTITY()

      -- Audit
      DECLARE @appname nvarchar(128)
      DECLARE @user    nvarchar(256)
      DECLARE @msg     nvarchar(1024)

      SET @appname = APP_NAME()
      SET @user    = USER_NAME()
      SET @msg     = 'Added a payment (ID = ' + CAST(@PaymentID as nvarchar) + ')'
      EXECUTE AddAuditMessage 'Information', @appname, @msg, @user
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON AddPayment TO PUBLIC
GO