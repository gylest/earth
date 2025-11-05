CREATE VIEW dbo.Profile_View
AS
SELECT     * FROM         dbo.Profiles
GO

GRANT SELECT
    ON OBJECT::[dbo].[Profile_View] TO [VisitorRole]
    AS [dbo];
GO
