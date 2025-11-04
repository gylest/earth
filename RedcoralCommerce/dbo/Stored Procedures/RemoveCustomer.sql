CREATE PROCEDURE RemoveCustomer
   @Email      nvarchar(100)
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Modify status to inactive
   IF (@Error=0)
   BEGIN
      UPDATE Customer 
         SET [Status]         = 'INACTIVE',
             [ModifyDate]      = DEFAULT
      WHERE  [Email] = @Email
      SET @Error = @@Error
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON RemoveCustomer TO PUBLIC
GO