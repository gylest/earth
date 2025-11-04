CREATE PROCEDURE VerifyCustomer
   @Email      nvarchar(100)
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Modify customer status
   IF (@Error=0)
   BEGIN
      UPDATE Customer 
         SET [Status]         = 'ACTIVE',
             [ModifyDate]      = DEFAULT
      WHERE  [Email] = @Email
      SET @Error = @@Error
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON VerifyCustomer TO PUBLIC
GO