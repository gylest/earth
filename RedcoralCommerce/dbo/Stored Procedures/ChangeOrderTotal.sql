CREATE PROCEDURE ChangeOrderTotal
   @OrderID           int,
   @SubTotal         money,
   @SalesTax         money,
   @Freight          money,
   @TotalDue         int      OUTPUT
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
 
   --
   -- Modify total fields
   --
   IF (@Error=0)
   BEGIN
      UPDATE [Order] 
         SET [SubTotal]     = @SubTotal,
             [SalesTax]     = @SalesTax,
             [Freight]      = @Freight,
             [ModifyDate]   = DEFAULT
      WHERE  [OrderID] = @OrderID
      SET @Error = @@Error
   END
   
   --
   -- Set output total
   --
   IF (@Error=0)
   BEGIN
      SELECT @TotalDue = TotalDue FROM [Order] WHERE [Order].OrderID = @OrderID
      SET @Error = @@Error
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON ChangeOrderTotal TO PUBLIC
GO