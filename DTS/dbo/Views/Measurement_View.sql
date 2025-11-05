CREATE VIEW dbo.Measurement_View
AS
SELECT     * FROM       dbo.Measurement
GO

GRANT SELECT
    ON OBJECT::[dbo].[Measurement_View] TO [VisitorRole]
    AS [dbo];
GO
