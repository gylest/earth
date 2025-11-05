CREATE FUNCTION [dbo].[fn_GetCodedValue]  (@EnumGroup VARCHAR(200), @Value VARCHAR(200))
RETURNS INT
AS
BEGIN
RETURN(
      SELECT [CodedValue] FROM Application_Lookup
      WHERE Value=@Value and [Group] =
      ( SELECT [Value] from Application_Lookup
        WHERE CodedValue=@EnumGroup
      )
)
END
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[fn_GetCodedValue] TO [DTSReadRole]
    AS [dbo];
GO