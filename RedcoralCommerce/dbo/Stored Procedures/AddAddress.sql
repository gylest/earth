CREATE PROCEDURE AddAddress
   @Email          nvarchar(100),
   @AddressLine1   nvarchar(50),
   @AddressLine2   nvarchar(50), 
   @City           nvarchar(50),  
   @PostCode       nvarchar(50),
   @Country        nvarchar(50),
   @AddressID      int      OUTPUT,
   @CustomerID     int      OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error             int

   SET @Error = 0
   
   -- 
   -- Validate User
   --    Does user exist?
   --
   IF (@Error=0)
   BEGIN
      SELECT @CustomerID = [Customer].CustomerID FROM [Customer] WHERE [Customer].Email = @Email
      IF (@@ROWCOUNT <> 1)
      BEGIN
         SET @Error = 100000
         RAISERROR(@Error,16,1,@Email)
      END
   END   

   -- Add address record
   IF (@Error=0)
   BEGIN
		INSERT INTO Address (   CustomerID,  AddressLine1,  AddressLine2,  City,  PostCode,  Country,   Status,  CreateDate, ModifyDate )
                    VALUES   ( @CustomerID, @AddressLine1, @AddressLine2, @City, @PostCode, @Country, 'ACTIVE', DEFAULT,    DEFAULT)
        SET @Error = @@ERROR 
   END
   
   -- Set output values and audit
   IF (@Error=0)
   BEGIN
      -- Set output values
      SET @AddressID = SCOPE_IDENTITY()

      -- Audit
      DECLARE @appname nvarchar(128)
      DECLARE @user    nvarchar(256)
      DECLARE @msg     nvarchar(1024)

      SET @appname = APP_NAME()
      SET @user    = USER_NAME()
      SET @msg     = 'Added a address (ID = ' + CAST(@AddressID as nvarchar) + ', email = ' + @Email + ')'
      EXECUTE AddAuditMessage 'Information', @appname, @msg, @user
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON AddAddress TO PUBLIC
GO