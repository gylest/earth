CREATE PROCEDURE ChangeCustomerPassword
   @Email          nvarchar(100),
   @EmailPassword  nvarchar(500)
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Modify record
   IF (@Error=0)
   BEGIN
      
      UPDATE Customer 
         SET [EmailPassword]   = @EmailPassword,
             [ModifyDate]      = DEFAULT
      WHERE  [Email] = @Email
      SET @Error = @@Error
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON ChangeCustomerPassword TO PUBLIC
GO