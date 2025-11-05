CREATE VIEW dbo.Zone_Message_View
AS
SELECT     * FROM         dbo.Zone_Message
GO

GRANT SELECT
    ON OBJECT::[dbo].[Zone_Message_View] TO [VisitorRole]
    AS [dbo];
GO
