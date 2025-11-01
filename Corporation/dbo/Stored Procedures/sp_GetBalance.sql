CREATE PROCEDURE [dbo].[sp_GetBalance]
   @AccountNo          INT,
   @Balance            INT        OUTPUT
AS
   SELECT @Balance = Balance from Accounts WHERE AccountNo = @AccountNo
GO


