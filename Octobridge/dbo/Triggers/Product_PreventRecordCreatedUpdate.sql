-- Prevent updates to RecordCreated
CREATE TRIGGER trg_Product_PreventRecordCreatedUpdate
ON [dbo].[Product]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE p
    SET RecordCreated = i.RecordCreated
    FROM [dbo].[Product] p
    INNER JOIN inserted i ON p.ProductId = i.ProductId
    INNER JOIN deleted d ON p.ProductId = d.ProductId
    WHERE i.RecordCreated <> d.RecordCreated;
END