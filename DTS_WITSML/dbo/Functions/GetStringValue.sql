CREATE FUNCTION [dbo].[GetStringValue]  (@EnumGroup VARCHAR(200), @CodedValue int)
RETURNS VARCHAR(200)
WITH ENCRYPTION
AS
BEGIN
RETURN(
      SELECT [Value] FROM Catalog
      WHERE CodedValue=@CodedValue and [Group] =
      ( SELECT [Value] from Catalog
        WHERE CodedValue=@EnumGroup
      )
)

END
GO