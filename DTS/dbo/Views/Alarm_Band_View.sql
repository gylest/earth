CREATE VIEW dbo.Alarm_Band_View
AS
SELECT     * FROM         dbo.Alarm_Band
GO

GRANT SELECT
    ON OBJECT::[dbo].[Alarm_Band_View] TO [VisitorRole]
    AS [dbo];
GO