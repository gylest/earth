CREATE TABLE [dbo].[Audit] (
    [AuditID]          INT                IDENTITY (1, 1) NOT NULL,
    [AuditType]        [dbo].[strcatalog] NOT NULL,
    [AuditSource]      NVARCHAR (100)     NOT NULL,
    [AuditDescription] NVARCHAR (1000)    NOT NULL,
    [AuditUser]        NVARCHAR (256)     NOT NULL,
    [AuditDate]        DATETIME           CONSTRAINT [DF_Audit_AuditDate] DEFAULT (sysdatetime()) NOT NULL,
    CONSTRAINT [PK_Audit] PRIMARY KEY CLUSTERED ([AuditID] ASC)
);

