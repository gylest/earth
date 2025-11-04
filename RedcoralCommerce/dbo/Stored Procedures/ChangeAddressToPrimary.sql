CREATE PROCEDURE ChangeAddressToPrimary
   @Email            nvarchar(100),
   @AddressID        int
WITH ENCRYPTION
AS
   DECLARE @Error            int
   DECLARE @CustomerID       int
   DECLARE @Status           strcatalog

   -- Initialize
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


   -- Modify existing record
   IF (@Error = 0)
   BEGIN
      BEGIN TRANSACTION 
      -- Reset existing primary
      UPDATE [Address] SET [Address].Status = 'ACTIVE' WHERE [Address].CustomerID = @CustomerID AND [Address].Status = 'PRIMARY'

      -- Set specified address record to primary
      UPDATE [Address] SET [Address].Status = 'PRIMARY' WHERE [Address].AddressID = @AddressID

      IF (@@ROWCOUNT = 1)
      BEGIN
			COMMIT TRANSACTION
      END
      ELSE
      BEGIN
            ROLLBACK TRANSACTION
      END
   END

   --
   -- Check error status and exit
   --
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END

   RETURN @Error

GO

GRANT EXECUTE ON ChangeAddressToPrimary TO PUBLIC
GO