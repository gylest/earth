CREATE VIEW dbo.Config_View
AS
SELECT     ID, Name, Description, Version,
           dbo.fn_GetValue('Boolean',Active) as 'Active',
           CreateDT, ModifyDT
FROM       dbo.Config
GO

GRANT SELECT
    ON OBJECT::[dbo].[Config_View] TO [VisitorRole]
    AS [dbo];
GO
