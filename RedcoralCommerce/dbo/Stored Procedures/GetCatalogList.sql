CREATE PROCEDURE GetCatalogList
   @GroupName    strcatalog
WITH ENCRYPTION
AS
   DECLARE @Error            int
   DECLARE @UniqueGroupValue strcatalog

   SET @Error = 0

   -- Get unique group value
   IF (@Error = 0)
   BEGIN
      SELECT @UniqueGroupValue = [Value] FROM [Catalog]
      WHERE [CodedValue] = @GroupName AND
            [Group]      = 0
      SET @Error = @@ERROR
   END

   -- Get list
   IF (@Error = 0)
   BEGIN
      SELECT [CodedValue], [Value], [Default] FROM [Catalog]
      WHERE [Group]      =  @UniqueGroupValue
      SET @Error = @@ERROR
   END  

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON GetCatalogList TO PUBLIC
GO
