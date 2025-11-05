CREATE TABLE [dbo].[Config] 
(
	[ID]          int IDENTITY (1, 1) NOT NULL,
	[Name]        varchar(100)        NOT NULL,
	[Description] varchar(250)        NOT NULL,
	[Version]     int                 NOT NULL,
	[Active]      bit                 NOT NULL,
	[CreateDT]    datetime            NOT NULL CONSTRAINT [DF_System_Config_CreateDT] DEFAULT (sysdatetime()),
	[ModifyDT]    datetime                NULL,
    CONSTRAINT [PK_System_Config] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [CK_System_Config_Active] CHECK ([Active]>=(0) AND [Active]<=(1)),
    CONSTRAINT [Unique_Config_Name] UNIQUE NONCLUSTERED ([Name] ASC)
) ON [PRIMARY]
GO
