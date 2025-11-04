CREATE PROCEDURE ChangeOrderPayment
   @OrderID           int,
   @PaymentID         int,
   @OrderStatus       strcatalog,
   @OrderDescription  nvarchar(50),
   @PaymentDate       datetime
WITH ENCRYPTION
AS
   DECLARE @Error      int
   DECLARE @CustomerID int

   SET @Error = 0
   
   -- 
   -- Validate order
   --
   IF (@Error=0)
   BEGIN
      SELECT @CustomerID = [Order].CustomerID FROM [Order] WHERE [Order].OrderID = @OrderID
      IF (@@ROWCOUNT <> 1)
      BEGIN
         SET @Error = 100002
         RAISERROR(@Error,16,1,@OrderID)
      END
   END   

   -- Modify order description
   IF (@Error=0)
   BEGIN
      IF @OrderDescription != NULL
      BEGIN
         UPDATE [Order] 
            SET [OrderDescription] = @OrderDescription,
                [OrderStatus]      = @OrderStatus,
                [ModifyDate]       = DEFAULT
         WHERE  [OrderID] = @OrderID 
         SET @Error = @@Error     
      END   
   END
   
   -- Modify payment details
   IF (@Error=0)
   BEGIN
      UPDATE [Order] 
         SET [PaymentID]        = @PaymentID,
             [OrderStatus]      = @OrderStatus,
             [PaymentDate]      = @PaymentDate,
             [ModifyDate]       = DEFAULT
      WHERE  [OrderID] = @OrderID
      SET @Error = @@Error
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON ChangeOrderPayment TO PUBLIC
GO