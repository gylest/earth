CREATE PROCEDURE ChangeAddress
   @Email          nvarchar(100),
   @AddressID      int,
   @AddressLine1   nvarchar(50),
   @AddressLine2   nvarchar(50), 
   @City           nvarchar(50),  
   @PostCode       nvarchar(50),
   @Country        nvarchar(50)
WITH ENCRYPTION
AS
   DECLARE @Error            int
   DECLARE @CustomerID       int
   DECLARE @Status           strcatalog

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
      SELECT @Status = [Address].[Status] FROM [Address] WHERE [Address].AddressID = @AddressID AND [Address].CustomerID = @CustomerID
      IF (@@ROWCOUNT <> 1)
      BEGIN
         SET @Error = 100008
         RAISERROR(@Error,16,1,@AddressID)
      END
   END
   
   -- Modify record
   IF (@Error=0)
   BEGIN
      UPDATE Address 
         SET [AddressLine1]    = @AddressLine1,
             [AddressLine2]    = @AddressLine2,
             [City]            = @City,
             [PostCode]        = @PostCode,
             [Country]         = @Country,
             [ModifyDate]      = DEFAULT
      WHERE  [AddressID]       = @AddressID
      SET @Error = @@Error
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON ChangeAddress TO PUBLIC
GO