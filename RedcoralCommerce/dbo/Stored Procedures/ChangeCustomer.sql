CREATE PROCEDURE ChangeCustomer
   @FirstName      nvarchar(50),
   @LastName       nvarchar(50),
   @DateOfBirth    date,
   @Phone          nvarchar(50),
   @Email          nvarchar(100)
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Modify record
   IF (@Error=0)
   BEGIN
      UPDATE Customer 
         SET [FirstName]       = @FirstName,
             [LastName]        = @LastName,
             [DateOfBirth]     = @DateOfBirth,
             [Phone]           = @Phone,
             [ModifyDate]      = DEFAULT
      WHERE  [Email] = @Email
      SET @Error = @@Error
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON ChangeCustomer TO PUBLIC
GO