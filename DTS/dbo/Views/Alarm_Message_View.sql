CREATE VIEW dbo.Alarm_Message_View
AS
SELECT     * FROM         dbo.Alarm_Message
GO

GRANT SELECT
    ON OBJECT::[dbo].[Alarm_Message_View] TO [VisitorRole]
    AS [dbo];
GO