CREATE VIEW dbo.Application_Lookup_View
AS
SELECT     * FROM  dbo.Application_Lookup
GO

GRANT SELECT
    ON OBJECT::[dbo].[Application_Lookup_View] TO [VisitorRole]
    AS [dbo];
GO