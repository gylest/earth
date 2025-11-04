CREATE TABLE [Person].[Person] (
    [BusinessEntityID] INT               NOT NULL,
    [PersonType]       NCHAR (2)         NOT NULL,
    [NameStyle]        [dbo].[NameStyle] CONSTRAINT [DF_Person_NameStyle] DEFAULT ((0)) NOT NULL,
    [Title]            NVARCHAR (8)      NULL,
    [FirstName]        [dbo].[Name]      NOT NULL,
    [MiddleName]       [dbo].[Name]      NULL,
    [LastName]         [dbo].[Name]      NOT NULL,
    [Suffix]           NVARCHAR (10)     NULL,
    [EmailPromotion]   INT               CONSTRAINT [DF_Person_EmailPromotion] DEFAULT ((0)) NOT NULL,
    [ModifiedDate]     DATETIME          CONSTRAINT [DF_Person_ModifiedDate] DEFAULT (GETDATE()) NOT NULL,
    CONSTRAINT [PK_Person_BusinessEntityID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC),
    CONSTRAINT [CK_Person_EmailPromotion] CHECK ([EmailPromotion]>=(0) AND [EmailPromotion]<=(2))
);