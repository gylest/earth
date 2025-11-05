CREATE PROCEDURE [dbo].[GetCatalogList]
   @GroupName    strcatalog
WITH ENCRYPTION
AS
   DECLARE @Error            int
   DECLARE @UniqueGroupValue strcatalog

   SET @Error = 0

   -- Get unique group value
   IF (@Error = 0)
   BEGIN
      SELECT @UniqueGroupValue = [Value] FROM [dbo].[Catalog]
      WHERE [CodedValue] = @GroupName AND
            [Group]      = 0
      SET @Error = @@ERROR
   END

   -- Get list
   IF (@Error = 0)
   BEGIN
      SELECT [CodedValue], [Value], [Default] FROM [dbo].[Catalog]
      WHERE [Group]      =  @UniqueGroupValue
      SET @Error = @@ERROR
   END  

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[GetCatalogList] TO PUBLIC
    AS [dbo];
GO

