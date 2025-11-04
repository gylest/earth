CREATE PROCEDURE ChangePayment
   @PaymentID      int,
   @CardType       int,
   @CardNumber     nvarchar(50),
   @CardHolderName nvarchar(50),
   @CardExpiryDate date
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Modify record
   IF (@Error=0)
   BEGIN
      UPDATE [Payment]
         SET [CardType]       = @CardType,
             [CardNumber]     = @CardNumber,
             [CardHolderName] = @CardHolderName,
             [CardExpiryDate] = @CardExpiryDate,
             [ModifyDate]     = DEFAULT
      WHERE  [PaymentID] = @PaymentID
      SET @Error = @@Error
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON ChangePayment TO PUBLIC
GO