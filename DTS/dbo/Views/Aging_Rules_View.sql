CREATE VIEW dbo.Aging_Rules_View
AS
SELECT * FROM dbo.Aging_Rules
GO

GRANT SELECT
    ON OBJECT::[dbo].[Aging_Rules_View] TO [VisitorRole]
    AS [dbo];
GO