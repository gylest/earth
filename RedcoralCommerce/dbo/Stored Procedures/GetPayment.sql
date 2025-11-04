CREATE PROCEDURE GetPayment
   @OrderID      int
WITH ENCRYPTION
AS
   DECLARE @Error      int
   DECLARE @PaymentID  int

   -- Initialize
   SET @Error = 0
   
   -- Get payment id for order
   IF (@Error = 0)
   BEGIN
      SELECT @PaymentID = PaymentID FROM [Order] WHERE OrderID = @OrderID
      IF (@@ROWCOUNT <> 1)
      BEGIN
         SET @Error = 100006
         RAISERROR(@Error,16,1,@OrderID)
      END

      SET @Error = @@Error

   END
   
   IF (@Error =0)
   BEGIN
      IF (@PaymentID is NULL)
      BEGIN
         SET @Error = 100006
         RAISERROR(@Error,16,1,@OrderID)
      END
   END
   
   -- Get payment
   IF (@Error =0)
   BEGIN
      SELECT * FROM Payment WHERE PaymentID = @PaymentID
   END

   RETURN @Error

GO

GRANT EXECUTE ON GetPayment TO PUBLIC
GO