CREATE PROCEDURE AddCustomer
   @FirstName      nvarchar(50),
   @LastName       nvarchar(50),
   @DateOfBirth    date,
   @Phone          nvarchar(50),
   @Email          nvarchar(100),
   @EmailPassword  nvarchar(500),
   @CustomerID     int        OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Add new record
   IF (@Error=0)
   BEGIN
      INSERT INTO Customer (  FirstName,  LastName,  DateOfBirth,  Phone,  Email,  EmailPassword, [Status],     CreateDate, ModifyDate )
                  VALUES   ( @FirstName, @LastName, @DateOfBirth, @Phone, @Email, @EmailPassword, 'UNVERIFIED', DEFAULT,    DEFAULT)
      SET @Error = @@Error
   END

   -- Set output values and audit
   IF (@Error=0)
   BEGIN
      -- Set output values
      SET @CustomerID = SCOPE_IDENTITY()

      -- Audit
      DECLARE @appname nvarchar(128)
      DECLARE @user    nvarchar(256)
      DECLARE @msg     nvarchar(1024)

      SET @appname = APP_NAME()
      SET @user    = USER_NAME()
      SET @msg     = 'Added a customer (ID = ' + CAST(@CustomerID as nvarchar) + ', email = ' + @Email + ')'
      EXECUTE AddAuditMessage 'Information', @appname, @msg, @user
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON AddCustomer TO PUBLIC
GO