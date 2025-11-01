CREATE PROCEDURE [dbo].[sp_AdjustBalance]
   @AccountNo          INT,
   @Amount             INT
AS
   UPDATE Accounts SET Balance = Balance + @Amount WHERE AccountNo = @AccountNo
GO

