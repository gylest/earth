CREATE PROCEDURE RemoveAddress
   @Email            nvarchar(100),
   @AddressID        int
WITH ENCRYPTION
AS
   DECLARE @Error      int
   DECLARE @CustomerID int
   DECLARE @Status     strcatalog

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
        
   -- 
   -- Validate address
   --    Does address exist for user specified?
   --
   IF (@Error=0)
   BEGIN
      SELECT @Status = [Address].Status FROM [Address] WHERE [Address].AddressID = @AddressID AND [Address].CustomerID = @CustomerID
      IF (@@ROWCOUNT <> 1)
      BEGIN
         SET @Error = 100008
         RAISERROR(@Error,16,1,@AddressID)
      END
   END
   
   -- Modify status to inactive
   IF (@Error=0)
   BEGIN
      UPDATE [Address]
         SET [Status]         = 'INACTIVE',
             [ModifyDate]      = DEFAULT
      WHERE  [AddressID] = @AddressID
      SET @Error = @@Error
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON RemoveAddress TO PUBLIC
GO