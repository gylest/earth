CREATE PROCEDURE GetAuditMessages
   @StartDate	datetime,
   @EndDate     datetime
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Get records
   IF (@Error = 0)
   BEGIN
      SELECT AuditID, AuditType, AuditSource, AuditDescription, AuditUser, AuditDate
      FROM Audit
      WHERE AuditDate BETWEEN @StartDate AND @EndDate
      ORDER BY Audit.AuditID ASC

      SET @Error = @@Error

   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON GetAuditMessages TO PUBLIC
GO