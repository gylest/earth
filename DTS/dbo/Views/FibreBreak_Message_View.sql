CREATE VIEW dbo.FibreBreak_Message_View
AS
SELECT     * FROM         dbo.FibreBreak_Message
GO

GRANT SELECT
    ON OBJECT::[dbo].[FibreBreak_Message_View] TO [VisitorRole]
    AS [dbo];
GO
