CREATE PROCEDURE [dbo].[GetWebServices]
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Select all rows in table
   IF (@Error = 0)
   BEGIN
      SELECT [ID], [Description], url, totalPosts, saveXML, security, Username, [Password], Active, 
             lastProfileID, lastProfileDate, lastPostDate,
             CreateDate, ModifyDate
      FROM WebServices

      SET @Error = @@ERROR
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[GetWebServices] TO PUBLIC
    AS [dbo];
GO

