CREATE PROCEDURE [dbo].[sp_GetUser]
   @Username          VARCHAR(15)
AS
    SELECT * FROM Users WHERE uname = @Username
GO

