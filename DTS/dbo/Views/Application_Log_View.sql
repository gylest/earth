CREATE VIEW dbo.Application_Log_View
AS
SELECT     * FROM       dbo.Application_Log
GO

GRANT SELECT
    ON OBJECT::[dbo].[Application_Log_View] TO [VisitorRole]
    AS [dbo];
GO