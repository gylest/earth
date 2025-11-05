CREATE TABLE [dbo].[Wellbores] (
    [ID]           INT                IDENTITY (1, 1) NOT NULL,
    [WellID]       INT                NOT NULL,
    [uidWellbore]  [dbo].[str64]      NOT NULL,
    [nameWellbore] [dbo].[str64]      NOT NULL,
    [depth]        [dbo].[length]     NOT NULL,
    [dtmPermanent] [dbo].[strcatalog] NOT NULL,
    [CreateDate]   DATETIME           CONSTRAINT [DF_Wellbores_CreateDate] DEFAULT (sysdatetime()) NOT NULL,
    [ModifyDate]   DATETIME           CONSTRAINT [DF_Wellbores_ModifyDate] DEFAULT (sysdatetime()) NOT NULL,
    CONSTRAINT [PK_Wellbores] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [CK_Wellbores_nameWellbore] CHECK (len([nameWellbore])>(0)),
    CONSTRAINT [CK_Wellbores_uidWellbore] CHECK (len([uidWellbore])>(0)),
    CONSTRAINT [FK_Wellbores_Wells] FOREIGN KEY ([WellID]) REFERENCES [dbo].[Wells] ([ID])
);
GO

