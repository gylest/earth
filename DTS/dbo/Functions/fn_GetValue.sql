CREATE FUNCTION [dbo].[fn_GetValue]  (@EnumGroup VARCHAR(200), @CodedValue int)
RETURNS VARCHAR(200)
AS
BEGIN
RETURN(
      SELECT [Value] FROM Application_Lookup
      WHERE CodedValue=@CodedValue and [Group] =
      ( SELECT [Value] from Application_Lookup
        WHERE CodedValue=@EnumGroup
      )
)
END
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[fn_GetValue] TO [DTSReadRole]
    AS [dbo];
GO