CREATE FUNCTION [dbo].[GetCodedValue]  (@EnumGroup VARCHAR(200), @Value VARCHAR(200))
RETURNS INT
WITH ENCRYPTION
AS
BEGIN
RETURN(
      SELECT [CodedValue] FROM Catalog
      WHERE Value=@Value and [Group] =
      ( SELECT [Value] from Catalog
        WHERE CodedValue=@EnumGroup
      )
)

END
GO