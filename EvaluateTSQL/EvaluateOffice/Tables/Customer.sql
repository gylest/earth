CREATE TABLE [EvaluateOffice].[Customer]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[FirstName] NVARCHAR(100) NOT NULL,
	[LastName] NVARCHAR(100) NOT NULL,
	[MiddleName] NVARCHAR(50) NULL,
	[AddressLine1] [nvarchar](60) NOT NULL,
	[AddressLine2] [nvarchar](60) NULL,
	[City] [nvarchar](30) NOT NULL,
	[PostCode] [nvarchar](15) NOT NULL,
    [Telephone] [nvarchar](25) NOT NULL,
	[Email] [nvarchar](25) NOT NULL,
	[RecordModified] DATETIME2(7) NOT NULL
)
GO

ALTER TABLE [EvaluateOffice].[Customer] ADD  CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED ([Id]);
GO

ALTER TABLE [EvaluateOffice].[Customer] ADD  CONSTRAINT [DF_Customer_RecordModified]  DEFAULT (SYSDATETIME()) FOR [RecordModified];
GO
