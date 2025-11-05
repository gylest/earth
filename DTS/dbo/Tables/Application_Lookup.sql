CREATE TABLE [dbo].[Application_Lookup] 
(
	[Group]      int           NOT NULL,
	[CodedValue] varchar(200)  NOT NULL,
	[Value]      varchar(200)  NOT NULL,
 CONSTRAINT [PK_System_Lookup] PRIMARY KEY  CLUSTERED ([Group],[CodedValue])  ON [PRIMARY] 

) ON [PRIMARY]
GO
