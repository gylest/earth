CREATE PROCEDURE GetSalesTaxRates
WITH ENCRYPTION
AS
   DECLARE @Error            int

   SET @Error = 0

   -- Get sales tax rates
   IF (@Error = 0)
   BEGIN
      SELECT * FROM SalesTaxRate ORDER BY [SalesTaxRate].CountryCode
      SET @Error = @@ERROR
   END  

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE ON GetSalesTaxRates TO PUBLIC
GO