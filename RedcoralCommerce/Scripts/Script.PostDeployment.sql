/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

--
-- Populate Catalog 
--
INSERT Catalog VALUES ( 0, 'AuditType',              '10', 0)
INSERT Catalog VALUES ( 0, 'CardType',               '20', 0)
INSERT Catalog VALUES ( 0, 'CustomerStatus',         '30', 0)
INSERT Catalog VALUES ( 0, 'OrderStatus',            '40', 0)
INSERT Catalog VALUES ( 0, 'AddressStatus',          '50', 0)
GO

-- AuditType
INSERT Catalog VALUES ( 10, '0', 'Information',          1)
INSERT Catalog VALUES ( 10, '1', 'Warning',              0)
INSERT Catalog VALUES ( 10, '2', 'Error',                0)
GO

-- CardType
INSERT Catalog VALUES ( 20, '0', 'MasterCard/EuroCard',  1)
INSERT Catalog VALUES ( 20, '1', 'American Express',     0)
INSERT Catalog VALUES ( 20, '2', 'Visa/Delta/Electron',  0)
GO

-- CustomerStatus
INSERT Catalog VALUES ( 30, '0', 'ACTIVE',               1)
INSERT Catalog VALUES ( 30, '1', 'INACTIVE',             0)
INSERT Catalog VALUES ( 30, '2', 'UNVERIFIED',           0)
GO

-- OrderStatus
DELETE FROM Catalog WHERE [Group] = 40
INSERT Catalog VALUES ( 40, '0', 'QUOTE',               1)
INSERT Catalog VALUES ( 40, '1', 'PAID',                0)
INSERT Catalog VALUES ( 40, '2', 'REFUNDED',            0)
GO

-- AddressStatus
INSERT Catalog VALUES ( 50, '0', 'PRIMARY',              1)
INSERT Catalog VALUES ( 50, '1', 'ACTIVE',               0)
INSERT Catalog VALUES ( 50, '2', 'INACTIVE',             0)
GO

--
-- Populate Country
--
INSERT Country VALUES
    ( 'AT', 'Austria'),
    ( 'BE', 'Belgium'),
    ( 'BG', 'Bulgaria'),
    ( 'CY', 'Cyprus'),
    ( 'CZ', 'Czech Republic'),
    ( 'DK', 'Denmark'),
    ( 'EE', 'Estonia'),
    ( 'FI', 'Finland'),
    ( 'FR', 'France'),
    ( 'DE', 'German'),
    ( 'GR', 'Greece'),
    ( 'HU', 'Hungary'),
    ( 'IE', 'Ireland'),
    ( 'IT', 'Italy'),
    ( 'LV', 'Latvia'),
    ( 'LT', 'Lithuania'),
    ( 'LU', 'Luxembourg'),
    ( 'MT', 'Malta'),
    ( 'NL', 'Netherlands'),
    ( 'PL', 'Poland'),
    ( 'PT', 'Portugal'),
    ( 'RO', 'Romania'),
    ( 'SK', 'Slovakia'),
    ( 'SL', 'Slovenia'),
    ( 'ES', 'Spain'),
    ( 'SE', 'Sweden'),
    ( 'GB', 'United Kingdom'),
    ( 'NO', 'Norway'),
    ( 'CH', 'Swiss')
GO

--
-- Populate SalesTaxRate
--
INSERT SalesTaxRate VALUES( 'AT', 20.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'BE', 21.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'BG', 20.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'CY', 15.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'CZ', 19.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'DK', 25.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'EE', 20.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'FI', 23.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'FR', 19.60, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'DE', 19.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'GR', 19.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'HU', 25.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'IE', 21.50, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'IT', 20.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'LV', 21.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'LT', 21.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'LU', 15.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'MT', 18.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'NL', 19.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'PL', 22.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'PT', 19.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'RO', 19.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'SK', 19.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'SL',  2.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'ES', 16.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'SE', 25.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'GB', 15.00, '1-SEP-2009', '31-DEC-2009')
INSERT SalesTaxRate VALUES( 'GB', 17.50, '1-JAN-2010', NULL)
INSERT SalesTaxRate VALUES( 'NO', 25.00, '1-SEP-2009', NULL)
INSERT SalesTaxRate VALUES( 'CH',  7.60, '1-SEP-2009', NULL)
GO