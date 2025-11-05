CREATE PROCEDURE AddAuditMessage
   @AuditType         strcatalog,
   @AuditSource       nvarchar(100),
   @AuditDescription  nvarchar(1024),
   @AuditUser         str256
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Add new record
   IF (@Error=0)
   BEGIN
      INSERT INTO Audit  ( AuditType, AuditSource, AuditDescription, AuditUser, AuditDate)
                  VALUES ( @AuditType, @AuditSource, @AuditDescription, @AuditUser, DEFAULT )
      SET @Error = @@Error
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[AddAuditMessage] TO PUBLIC
    AS [dbo];
GO

